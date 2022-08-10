package com.kh.bookie.mypage.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.dto.MemberEntity;
import com.kh.bookie.member.model.service.MemberService;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.mypage.model.service.MypageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage")
@Slf4j
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	/* 팔로우페이지 */
	@GetMapping("/follower.do")
	public String follower(Model model, @RequestParam String memberId) {
		Member member = memberService.selectOneMember(memberId);
		model.addAttribute("member", member);
		return "mypage/mypage";
	}
	
	@GetMapping("/mypage.do")
	public void mypage(Model model, @AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		try {
			Member member = memberService.selectOneMember(memberId);
			model.addAttribute("member", member);
			
			// 1. 미니프로필
			
			// 2. 기록
			
			// 3. 읽고있는 책
			
			// 4. 마이픽
			
			// 5. 달력
			
			// 6. 차트
			
		} catch (Exception e) {
			log.error("내서재 조회오류", e);
//			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body();
		}
		
	}
	
	@GetMapping("/mypageSetting.do")
	public void mypageSetting() {}
	
/**
 * QNA
 */
	@GetMapping("/qnaList.do")
	public void qnaList(@RequestParam String memberId, Model model){
		try {
			List<Qna> list = mypageService.selectMyQnaList(memberId);
			log.debug("list", list);
			model.addAttribute("list", list);
		} catch (Exception e) {
			log.error("QNA리스트 불러오기 오류",e);
			throw e;
		}
	}
	
	@GetMapping("/qnaEnroll.do")
	public void qnaEnroll() {}
	
	@PostMapping("/qnaEnroll.do")
	public String qnaEnroll(Qna qna) {
		try {
			log.debug("qna = {}", qna);
			int result = mypageService.qnaEnroll(qna);
		} catch (Exception e) {
			log.error("QNA 글 등록 오류", e);
			e.printStackTrace();
			throw e;
		}
		return "redirect:/mypage/qnaList.do?memberId=" + qna.getMemberId();
	}
	
	@GetMapping("/qnaDetail.do")
	public void qnaDetail(@RequestParam int qnaNo, Model model){
		try {
			Qna qna = mypageService.selectOneQna(qnaNo);
			log.debug("qna = {}", qna);
			model.addAttribute("qna", qna);
		} catch (Exception e) {
			log.error("QNA 상세보기 오류",e);
			throw e;
		}
	}
	
	
	@GetMapping("/myMiniProfile.do")
	public void myMiniProfile() {}

	@GetMapping("/myMainProfile.do")
	public void myMainProfile(Model model, @RequestParam Member loginMember) {
		log.debug("model = {}", model);
		log.debug("loginMember = {}", loginMember);
		String memberId = loginMember.getMemberId();
		try {
			// 
//			Member member = memberService.selectInterests(memberId);
			
			
		} catch (Exception e) {
			
		}
	}
	
	@GetMapping("/myBook.do")
	public void myBook() {}

	@GetMapping("/myScrap.do")
	public void myScrap() {}
	
	@GetMapping("/myDokoo.do")
	public void myDokoo() {}
	
	@GetMapping("/myPheed.do")
	public void myPheed() {}
	
	@GetMapping("/myBookClub.do")
	public void myBookClub() {}
	
	@GetMapping("/myProfileDelete.do")
	public String myProfileDelete(@AuthenticationPrincipal Member loginMember, RedirectAttributes redirectAttr) {
		String nickname = loginMember.getNickname(); 
		log.debug("nickname = {}", nickname);
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile");
		log.debug(loginMember.getRenamedFilename());
        
		try {
			if(loginMember.getRenamedFilename() != null) {
				Member profileMember =  memberService.selectOneMemberByNickname(nickname);
				log.debug("profileMember = {}", profileMember);
				
				// a. 첨부파일삭제
				String renamedFilename = profileMember.getRenamedFilename();
				File deleteFile = new File(saveDirectory, renamedFilename);
				if(deleteFile.exists()) {
					deleteFile.delete();
					log.debug("{}의 {}파일 삭제", nickname, renamedFilename);
				}
				
				// b. 레코드삭제
				int result = memberService.deleteMemberProfile(nickname);
				log.debug("{}의 MemberProfile 레코드 삭제", nickname);	
			}
			
			redirectAttr.addFlashAttribute("msg", "Mini프로필을 성공적으로 수정했습니다.");
			
		} catch (Exception e) {
			log.error("프로필 삭제 오류", e);
			throw e;
		}
		return "redirect:/mypage/myMiniProfile.do";
	}
	
	/* nicknameCheck */
	@GetMapping("/nicknameCheck.do")
	public ResponseEntity<?> nicknameCheck(@RequestParam String nickname){
		log.debug("nickname = {}", nickname);
		
		Map<String, Object> map = new HashMap<>();
		try {
			MemberEntity member = memberService.selectOneMemberByNickname(nickname);
			log.debug("member = {}", member);
			boolean available = member == null; // 조회결과가 없으면 true | 있으면 false
			log.debug("available = {}", available);
			
			map.put("available", available);
			map.put("member", member);
			
		} catch (Exception e) {
			log.error("닉네임 중복체크 오류", e);
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
	
	/* 상세프로필 수정 */
	@PostMapping("/myMainProfileUpdate.do")
	public ResponseEntity<?> myMainProfileUpdate(@RequestParam String nickname) {
		return null;
	};
	
	/* 미니프로필 수정 */
	@PostMapping("/myMiniProfileUpdate.do")
	public String myMiniProfileUpdate(@RequestParam String newNickname,
					@RequestParam String sns,
					@RequestParam String introduce,
					RedirectAttributes redirectAttr,
					@RequestParam("upFile") MultipartFile upFile,
					@RequestParam String delFile,
					@AuthenticationPrincipal Member loginMember) throws Exception {
		String nickname = loginMember.getNickname();
		log.debug("upFile = {}", upFile);
		log.debug("delFile = {}", delFile);
		log.debug("sns = {}", sns);
		log.debug("introduce = {}", introduce);
		log.debug("newNickname = {}", newNickname);
		
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile");
		try {
			// 1. 첨부파일 삭제 (파일 삭제)
			if(delFile == "0" && (loginMember.getRenamedFilename() != null)) {
				Member profileMember =  memberService.selectOneMemberByNickname(nickname);
				log.debug("profileMember = {}", profileMember);
				
				// a. 첨부파일삭제
				String renamedFilename = profileMember.getRenamedFilename();
				File deleteFile = new File(saveDirectory, renamedFilename);
				if(deleteFile.exists()) {
					deleteFile.delete();
					log.debug("{}의 {}파일 삭제", nickname, renamedFilename);
				}
				
				// b. 레코드삭제
				int delResult = memberService.deleteMemberProfile(nickname);
				log.debug("{}의 MemberProfile 레코드 삭제", nickname);
			}
			
			int updateResult;
			Member updateMember = loginMember;
			// 2. 첨부파일 등록 (파일 저장)
			if(upFile.getSize() > 0) {
				log.debug("요기?");
				MultipartFile updateFile = upFile;
				updateMember.setOriginalFilename(updateFile.getOriginalFilename());
				updateMember.setRenamedFilename(HelloSpringUtils.getRenamedFilename(updateFile.getOriginalFilename()));
				updateMember.setNickname(newNickname);
				updateMember.setIntroduce(introduce);
				updateMember.setSns(sns);
				
				File destFile = new File(saveDirectory, updateMember.getRenamedFilename());
				upFile.transferTo(destFile);
				updateResult = memberService.miniUpdateMember(updateMember);	
			}
			else {
				// 3. 맴버 간단수정
				updateMember.setOriginalFilename(loginMember.getOriginalFilename());
				updateMember.setRenamedFilename(loginMember.getRenamedFilename());
				updateMember.setNickname(newNickname);
				updateMember.setIntroduce(introduce);
				updateMember.setSns(sns);
				updateResult = memberService.miniUpdateMember(updateMember);	
				log.debug("updateResult = {}", updateResult);
			}

			redirectAttr.addFlashAttribute("msg", "Mini프로필을 성공적으로 수정했습니다.");
		} 
		catch(Exception e) {
			log.error("미니프로필 수정 오류", e);
			e.printStackTrace();
		}
		return "redirect:/mypage/myMiniProfile.do"; 
	}

}
