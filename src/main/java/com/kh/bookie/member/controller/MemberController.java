package com.kh.bookie.member.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.service.AdminService;
import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.email.MailSendService;
import com.kh.bookie.member.model.dto.Interest;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/member")
@Slf4j
@SessionAttributes({"loginMember", "next"})
public class MemberController {
   
   @Autowired
   private MemberService memberService;
   
   @Autowired
   private AdminService adminService;
   
   @Autowired
   ServletContext application;
   
   @Autowired
   BCryptPasswordEncoder bcryptPasswordEncoder;
   
   @GetMapping("/memberEnroll.do")
   public void memberEnroll() {}

   /* 이메일인증 필요 service */
   @Autowired
   private MailSendService mailService;
   
   @PostMapping("/memberEnroll.do")
   public String memberEnroll(Member member, RedirectAttributes redirectAttr,
                        @RequestParam (required = false) MultipartFile upFile,
                        @RequestParam (required = false) Interest interest) {
      log.info("Member = {}", member);
      try {
         // 올린 파일 있으면 저장
         String saveDirectory = application.getRealPath("/resources/upload/profile");
         
         //업로드한 파일 저장
         if(upFile.getSize() > 0) {
            // 파일명 재지정
            String originalFilename = upFile.getOriginalFilename();
            String renamedFilename = HelloSpringUtils.getRenamedFilename(originalFilename);
            log.debug("renamedFilename = {}", renamedFilename);
         
            // 파일 저장
            File destFile = new File(saveDirectory, renamedFilename);
            upFile.transferTo(destFile);
            
            // member에 set
            member.setOriginalFilename(originalFilename);
            member.setRenamedFilename(renamedFilename);
            
         }
         
         // 암호화 처리
         String rawPassword = member.getPassword();
         String encryptedPassword = bcryptPasswordEncoder.encode(rawPassword);
         member.setPassword(encryptedPassword);
         log.info("encryptedPassword = {}", encryptedPassword);
         
         // service단 처리
         if(interest != null) member.setInterests(interest);
         
         int result = memberService.memberEnroll(member);
         // 사용자 처리 피드백
         redirectAttr.addFlashAttribute("msg","회원가입이 성공적으로 처리되었습니다.");
      } catch (Exception e) {
         log.error("회원가입 오류", e);
         e.printStackTrace();
      }
      return "redirect:/"; // msg 담아도 안나옴 -> index.jsp를 거치도록
   }
   
   @GetMapping("/login.do")
   public void login() {
      try {
         
      }
      catch(Exception e) {
         e.printStackTrace();
      }
      
   }

	/**
	 * 로그인 성공시 후처리
	 * @param session
	 * @param model
	 * @return
	 */
	@PostMapping("/loginSuccess.do")
	public String loginSuccess(HttpSession session, Model model, @AuthenticationPrincipal Member loginMember) {
		log.debug("loginSuccess");
		
		List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) loginMember.getAuthorities();
		// 관리자가 아닌 경우에만 안읽은 메세지 수 체크
		if(!authorities.contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			// 관리자와의 1:1 채팅에서 안읽은 메세지 카운팅
			int unreadCount = adminService.getUnreadCount(loginMember.getMemberId());
			log.debug("unreadCount = {}", unreadCount);
			// 세션스코프에 unreadCount 저장
			//  -> 모델스코프는 의미없지 리다이렉트라서 -> model 쓸거면 @SessionAttributes 어노테이션 쓰면 돼
			session.setAttribute("unreadCount", unreadCount);
		}
		
		// security의 redirect 사용하기
		SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST"); //다음에 리다이렉트할 주소를 담은 객체
		String location = "/";
		if(savedRequest != null)
			location = savedRequest.getRedirectUrl();
		log.debug("location = {}", location); //location = http://localhost:9090/spring/board/boardForm.do
		return "redirect:" + location;
	}
   
   
   @GetMapping("/checkIdDuplicate.do")
   public ResponseEntity<?> checkIdDuplicate(@RequestParam String memberId) {
      Map<String, Object> map = new HashMap<>();
      try {
         Member member = memberService.selectOneMember(memberId);
         boolean available = member == null; // 조회결과가 없으면 true | 있으면 false
         
         map.put("memberId", memberId);
         map.put("available", available);
         
      } catch (Exception e) {
         log.error("아이디 중복체크 오류", e);
         map.put("error", e.getMessage());
         map.put("msg", "이용에 불편을 드려 죄송합니다.");
         return ResponseEntity
               .status(HttpStatus.INTERNAL_SERVER_ERROR)
               .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
               .body(map);
      }
      return ResponseEntity
               .status(HttpStatus.OK)
               .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
               .body(map);
   }
   
   @GetMapping("/checkNicknameDuplicate.do")
   public ResponseEntity<?> checkNicknameDuplicate(@RequestParam String nickname) {
      Map<String, Object> map = new HashMap<>();
      try {
         Member member = memberService.selectOneMemberByNickname(nickname);
         boolean available = member == null; // 조회결과가 없으면 true | 있으면 false
         
         map.put("nickname", nickname);
         map.put("available", available);
         
      } catch (Exception e) {
         log.error("아이디 중복체크 오류", e);
         map.put("error", e.getMessage());
         map.put("msg", "이용에 불편을 드려 죄송합니다.");
         return ResponseEntity
               .status(HttpStatus.INTERNAL_SERVER_ERROR)
               .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
               .body(map);
      }
      return ResponseEntity
            .status(HttpStatus.OK)
            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
            .body(map);
   }

   @GetMapping("/mailCheck")
   @ResponseBody
   public String mailCheck(String email) {
      log.debug("이메일 인증 요청이 들어옴!");
      log.debug("이메일 인증 이메일 : " + email);
      return mailService.joinEmail(email);
   }
   
   @GetMapping("/emailCertified")
   public void emailCertified() {}

   @GetMapping("/checkAlarm.do")
   public void checkAlarm(Model model, @AuthenticationPrincipal Member loginMember) {
	   try {
		   List<Alarm> list = memberService.selectAlarmList(loginMember.getMemberId());
		   log.debug("list = {}",list);
		   model.addAttribute("list", list);
	   } catch(Exception e){
		   log.error("알람리스트 조회 오류",e);
		   throw e;
	   }
	   
   }
   
   @PostMapping("/readAlarm.do")
   public ResponseEntity<?> readAlarm(@RequestParam int alarmNo, HttpSession session, @AuthenticationPrincipal Member loginMember){
	   Map<String, Object> map = new HashMap<>();
	   try {
		   int result = memberService.readAlarm(alarmNo);
		   int unreadCount = adminService.getUnreadCount(loginMember.getMemberId());
			log.debug("unreadCount = {}", unreadCount);
			// 세션스코프에 unreadCount 저장
			//  -> 모델스코프는 의미없지 리다이렉트라서 -> model 쓸거면 @SessionAttributes 어노테이션 쓰면 돼
			session.setAttribute("unreadCount", unreadCount);
		   map.put("unreadCount", unreadCount);
	   } catch (Exception e) {
		   log.error("알림 읽기 처리 오류", e);
		   map.put("msg", "이용에 불편을 드려 죄송합니다.");
		   return ResponseEntity
				   .status(HttpStatus.INTERNAL_SERVER_ERROR)
				   .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
				   .body(map);
	   }
	   return ResponseEntity
			   .status(HttpStatus.OK)
			   .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
			   .body(map);
   }
}