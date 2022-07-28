package com.kh.bookie.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
<<<<<<< HEAD
=======
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.RequestHeader;
=======
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.SessionAttribute;
=======
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

<<<<<<< HEAD
import com.kh.bookie.member.model.service.MemberService;
import com.kh.bookie.member.model.dto.Member;
=======
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.service.MemberService;
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git

import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/member")
@Slf4j
@SessionAttributes({"loginMember", "next"})
public class MemberController {
	
	@Autowired
<<<<<<< HEAD
	MemberService memberService;
=======
	private MemberService memberService;
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
<<<<<<< HEAD
	
	
	@RequestMapping("/login.do")
	public void login() {}
=======
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {}
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
	
<<<<<<< HEAD
	@GetMapping("/memberEnroll.do")
	public String memberEnroll() {
		
		return "member/memberEnroll";
=======
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr, @RequestParam (required = false) String[] interest) {
		log.info("Member = {}", member);
		try {
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
			e.printStackTrace();
			throw e;
		}
		return "redirect:/"; // msg 담아도 안나옴 -> index.jsp를 거치도록
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
	}
	
<<<<<<< HEAD
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.info("member = {}", member);
		try {
			// 암호화처리
			String rawPassword = member.getPassword();
			String encryptedPassword = bcryptPasswordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			log.info("encryptedPassword = {}", encryptedPassword);
			
			// service에 insert요청
			int result = memberService.insertMember(member);
			
			// 사용자 처리 피드백
			redirectAttr.addFlashAttribute("msg", "성공적으로 회원가입했습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/";
	}
    // 로그인 홈페이지 연결 
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
=======
	@GetMapping("/login.do")
	public void login() {
		try {
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	};
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
	
	@GetMapping("/checkIdDuplicate.do")
<<<<<<< HEAD
	public ResponseEntity<?> checkIdDuplicate3(@RequestParam String memberId) {
		Map<String, Object> map = new HashMap<>();
		try {
			
			
			
			Member member = memberService.selectOneMember(memberId);
			boolean available = member == null;
			
			map.put("memberId", memberId);
			map.put("available", available);
			
		} catch (Exception e) {
			log.error("중복아이디 체크 오류", e);
			// throw e;
			
			map.put("error", e.getMessage());
			
			return ResponseEntity
					.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
			
		}
//		return ResponseEntity.ok(map); // 200 + body에 작성할 맵
		return ResponseEntity
				.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
				.body(map);
				
=======
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
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git
	}


}
