package com.kh.bookie.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.service.AdminService;
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
	
	@Autowired
	AdminService adminService;

	@GetMapping("/memberList.do")
	public void admin(Model model) {
		try {
			List<Member> list = memberService.selectMemberList();
			log.debug("list = {}",list);
			model.addAttribute("list", list);
		}catch(Exception e){
			log.error("회원괸리 오류",e);
			throw e;
		}
		
	}
	
	@GetMapping("/sendAlarm.do")
	public void sendAlarm(Model model) {
		try {
			List<Member> list = memberService.selectMemberList();
			log.debug("list = {}",list);
			model.addAttribute("list", list);
		}catch(Exception e){
			log.error("회원괸리 오류",e);
			throw e;
		}
	};
	
	@GetMapping("/selectMemberListByInterest.do")
	public ResponseEntity<?> selectMemberListByInterest(@RequestParam String interest){
		Map<String, Object> map = new HashMap<>();
		try {
			Member member = new Member();
			member.setInterest(interest);
			List<Member> list = memberService.selectMemberListByInterest(member);
			map.put("msg", "관심사별 멤버 불러오기 완료");
			map.put("list", list);
		} catch (Exception e) {
			log.error("관심사별 멤버 불러오기 오류", e);
			map.put("msg", "관심사별 멤버 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/insertAlarm.do")
	public ResponseEntity<?> insertAlarm(Alarm alarm){
		Map<String, Object> map = new HashMap<>();
		try {
			int result = adminService.insertAlarm(alarm);
			map.put("msg", "알림 등록 완료");
		} catch (Exception e) {
			log.error("알림 등록 오류", e);
			map.put("msg", "알림 등록 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
}
