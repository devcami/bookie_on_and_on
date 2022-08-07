package com.kh.bookie.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
@SessionAttributes({"next"})
public class AdminController {
	
	@Autowired
	MemberService memberService;
	

	@GetMapping("/memberList.do")
	public void admin(Model model) {
		
		try {
			List<Member> list = memberService.selectMemberList();
			log.debug("list = {}",list);
			
		}catch(Exception e){
			log.error("회원괸리 오류",e);
			throw e;
		}
		
	}
}
