package com.kh.bookie.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.bookie.mypage.model.service.MypageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage")
@Slf4j
public class MypageController {
	
	MypageService mypageService;
	
//	@Autowired
//	private MemberService memberService;
	
	@GetMapping("/mypage.do")
	public void mypage() {}
	
	@GetMapping("/mypageSetting.do")
	public void mypageSetting() {}
	
	@GetMapping("/myMiniProfile.do")
	public void myMiniProfile() {}

}
