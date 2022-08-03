package com.kh.bookie.point.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.point.model.service.PointService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/point")
@Slf4j
@SessionAttributes({ "next" })
public class PointController {

	@Autowired
	private PointService pointService;

	@Autowired
	ServletContext application;
	
	@GetMapping("/myPoint.do")
	public ModelAndView myPoint(
			@AuthenticationPrincipal Member loginMember,
			ModelAndView mav) {
		try {
			
//			log.debug("loginMember = {}", loginMember);
//	        log.debug("authentication member = {} ", loginMember.getMemberId());
//	        String memberId = loginMember.getMemberId();


		} catch (Exception e) {
			log.error("내 포인트 페이지 조회 오류", e);
			throw e;
		}
		 
		return mav;
	}
	
	@PostMapping("/chargeMyPoint.do")
	public ResponseEntity<?> chargeMyPoint(@RequestBody String imp_uid){
		Map<String, Object> map = new HashMap<>();
		try {
			
			log.debug("amount = {}", imp_uid);
			map.put("msg", "됐다!!!!!!!!!!!!!!!!!!");
			return ResponseEntity.ok(map);
			
		} catch(Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
}
