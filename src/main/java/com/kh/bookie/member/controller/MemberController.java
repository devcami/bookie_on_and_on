package com.kh.bookie.member.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.member.dto.Memberdto;

import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/member")
@Slf4j
@SessionAttributes({"loginMember", "next"})
public class MemberController {
	
	@RequestMapping("login.do")
	public String login() {
		return "member/login" ;
		
	}
	
	@RequestMapping("login_check.do")
	public ModelAndView login_check(@ModelAttribute Memberdto dto, HttpSession session) {
	 String name =  
	 ModelAndView mav = new ModelAndView();
	  if (name != null) { // 로그인 성공 시
	   mav.setViewName("home"); // 뷰의 이름
	   } else { // 로그인 실패 시
	     mav.setViewName("member/login"); 		
	     mav.addObject("message", "error");
	     }
	     return mav;
	   }

	
	//로그아웃 
	@GetMapping("/memberlogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		// 사용완료 마킹 ( 세션객체 폐기하지 않음)
	 if(!sessionStatus.isComplete())
		 sessionStatus.setComplete();
		
		return"redirect:/";
	}
	


}
