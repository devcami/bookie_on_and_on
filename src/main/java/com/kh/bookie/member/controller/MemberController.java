package com.kh.bookie.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


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
	BCryptPasswordEncoder bcryptPasswordEncoder;
	

	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {}

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

	}
	

	@GetMapping("/login.do")
	public void login() {
		try {
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	};	
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


}
