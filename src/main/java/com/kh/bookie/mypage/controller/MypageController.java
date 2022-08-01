package com.kh.bookie.mypage.controller;

import java.io.File;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.dto.MemberEntity;
import com.kh.bookie.member.model.service.MemberService;
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
	
	@GetMapping("/mypage.do")
	public void mypage(Model model, @AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		try {
			log.debug("loginMember =  {}", loginMember);
			log.debug("아이디 가져와져? =  {}", loginMember.getMemberId());
			log.debug("닉네임 가져와져? =  {}", loginMember.getNickname());
			log.debug("폰번 가져와져? =  {}", loginMember.getPhone());
			log.debug("성 가져와져? =  {}", loginMember.getGender());
			log.debug("한줄소개 가져와져? =  {}", loginMember.getIntroduce());
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
	
	@GetMapping("/myMiniProfile.do")
	public void myMiniProfile() {}
	
	@GetMapping("/myScrap.do")
	public void myScrap() {}
	
	@GetMapping("/myDokoo.do")
	public void myDokoo() {}
	
	@GetMapping("/myPheed.do")
	public void myPheed() {}
	
	@GetMapping("/myBookClub.do")
	public void myBookClub() {}
	
	/* nicknameCheck */
	@GetMapping("/nicknameCheck.do")
	public ResponseEntity<?> nicknameCheck(@RequestParam String nickname){
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
	
	@PostMapping("/myMiniProfileUpdate")
	public String myMiniProfileUpdate(@RequestParam String newNickname,
					@RequestParam String sns,
					@RequestParam String introduce,
					RedirectAttributes redirectAttr,
					@RequestParam("upFile") MultipartFile upFile,
					@RequestParam(value="delFile", required=false) String delFile,
					@AuthenticationPrincipal Member loginMember) throws Exception {
		String nickname = loginMember.getNickname();
		log.debug("newNickname = {}", newNickname);
		log.debug("introduce = {}", introduce);
		log.debug("sns = {}", sns);
		log.debug("logingMember = {}", loginMember);
		log.debug("upFile = {}", upFile);
		log.debug("delFile = {}", delFile);
		log.debug("nickname = {}", nickname);
		
		
		// 파일저장위치
        String saveDirectory = application.getRealPath("/resources/upload/profile"); // 정적파일보관자리 생각 src/main/resources와 구분잘하기
		try {
			
			// 1. 첨부파일 삭제 (파일 삭제)
			if(delFile != null) {
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
			
			log.debug("여긴온거야?");
			
			// 2. 첨부파일 등록 (파일 저장)
			MultipartFile updateFile = upFile;
			log.debug("updateFile = {}",updateFile);
			Member updateMember = loginMember;
			
			if(upFile.getSize() > 0) {
				updateMember.setOriginalFilename(updateFile.getOriginalFilename());
				updateMember.setRenamedFilename(HelloSpringUtils.getRenamedFilename(updateFile.getOriginalFilename()));
				updateMember.setNickname(newNickname);
				updateMember.setIntroduce(introduce);
				updateMember.setSns(sns);
				
				log.debug(saveDirectory);
				log.debug(updateMember.getRenamedFilename());
				File destFile = new File(saveDirectory, updateMember.getRenamedFilename());
				upFile.transferTo(destFile);
			}
			
			// 3. 맴버 간단수정
			log.debug("updateMember = {}", updateMember.getIntroduce());
			int result2 = memberService.miniUpdateMember(updateMember);
			
			redirectAttr.addFlashAttribute("msg", "Mini프로필을 성공적으로 수정했습니다.");
		} 
		catch(Exception e) {
			log.error("미니프로필 수정 오류", e);
			throw e;
		}
		return "redirect:/mypage/myMiniProfile.do"; 
	}

}
