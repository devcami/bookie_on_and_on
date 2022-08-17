package com.kh.bookie.point.controller;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.point.model.dto.PointStatus;
import com.kh.bookie.point.model.service.PointService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/point")
@Slf4j
public class PointController {

	@Autowired
	private PointService pointService;

	@Autowired
	ServletContext application;
	
	@PostMapping("/myPoint.do")
	public ModelAndView myPoint(
			@AuthenticationPrincipal Member loginMember,
			ModelAndView mav) {
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			
			log.debug("loginMember = {}", loginMember);
	        log.debug("authentication member = {} ", loginMember.getMemberId());
	        String memberId = loginMember.getMemberId();
	        map.put("memberId", memberId);

	        DecimalFormat df = new DecimalFormat("0");
	        Calendar currentCalendar = Calendar.getInstance();
	        String month  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
	        
	        int lastMonth = currentCalendar.get(Calendar.MONTH);
	        int lastlastMonth = currentCalendar.get(Calendar.MONTH) - 1;
	        
	        
	        LocalDate start = YearMonth.now().atDay(1);
	        LocalDate end   = YearMonth.now().atEndOfMonth();
	        
	        map.put("start", start);
	        map.put("end", end);
	        
	        log.debug("start = {}", start);
	        log.debug("end = {}", end);
	        log.debug("month = {}", month);
	        
	        
//	        List<PointStatus> list = pointService.getMyPointStatusList(map);

	        List<List<PointStatus>> totalList = pointService.getMyPointStatusListTemp(memberId);
	        
	        mav.addObject("month", month);
	        mav.addObject("lastMonth", lastMonth);
	        mav.addObject("lastlastMonth", lastlastMonth);
	        mav.addObject("totalList", totalList);
		} catch (Exception e) {
			log.error("내 포인트 페이지 조회 오류", e);
			throw e;
		}
		 
		return mav;
	}
	
	@PostMapping("/chargeMyPoint.do")
	public ResponseEntity<?> chargeMyPoint(@RequestBody PointStatus pointStatus){
		Map<String, Object> map = new HashMap<>();
		try {
			
			log.debug("pointStatus = {}", pointStatus);
			
			int result = pointService.insertPoint(pointStatus);
			
			map.put("msg", "포인트 충전이 완료되었습니다.");
			map.put("pointStatus", pointStatus);
			return ResponseEntity.ok(map);
			
		} catch(Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
}
