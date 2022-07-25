package com.kh.bookie.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage")
@Slf4j
public class MypageController {
	
//	@Autowired
//	private MemberService memberService;
	
	@GetMapping("/mypage.do")
	public void loginMember() {}

}
