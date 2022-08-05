package com.kh.bookie.member.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.kh.bookie.common.HelloSpringUtils;

import com.kh.bookie.email.MailSendService;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.service.MemberService;
import com.kh.bookie.pheed.model.dto.PheedAttachment;


import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/member")
@Slf4j
@SessionAttributes({"loginMember", "next"})
public class MemberController {
	
	@Autowired

	private MemberService memberService;

	
	@Autowired
	ServletContext application;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
  // 로그인 처리
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {}


	/* 이메일인증 필요 service */
	@Autowired
	private MailSendService mailService;
	

	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr,
								@RequestParam (required = false) MultipartFile upFile,
								@RequestParam (required = false) String[] interest) {
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
	

	
	
	
	
	
	
	
	
	

	@GetMapping("/checkTelDuplicate.do")
	public ResponseEntity<?> checkTelDuplicate(@RequestParam String telNum) {
		Map<String, Object> map = new HashMap<>();
		try {
			Member member = memberService.selectOneMemberByTel(telNum);
			boolean available = member == null; // 조회결과가 없으면 true | 있으면 false
			
			map.put("telNum", telNum);
			map.put("available", available);
			
		} catch (Exception e) {
			log.error("핸드폰 번호 중복 오류 ", e);
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

}