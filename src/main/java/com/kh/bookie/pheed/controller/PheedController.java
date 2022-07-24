package com.kh.bookie.pheed.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedComment;
import com.kh.bookie.pheed.model.service.PheedService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/pheed")
@Slf4j
@SessionAttributes({"next"})
public class PheedController {

	@Autowired
	private PheedService pheedService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/pheedFList.do")
	//@AuthenticationPrincipal Member loginMember
	public ModelAndView pheedFList(ModelAndView mav, HttpServletRequest request) {
		try {
			// 목록 조회
			// list 조회 때 loginMember를 넘긴다
//			List<Pheed> list = pheedService.selectPheedFList();
//			log.debug("list", list);
//			mav.addObject("list", list);
			
			mav.setViewName("pheed/pheedList");
		} catch (Exception e) {
			log.error("팔로워 피드 목록 조회 오류", e);
			mav.addObject("msg", "팔로워 피드 목록 조회 오류");
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/pheedCList.do")
	public ModelAndView pheedCList(ModelAndView mav, HttpServletRequest request) {
		try {
			// 목록 조회
			List<Pheed> list = pheedService.selectPheedCList();
			log.debug("list = {}", list);
			mav.addObject("list", list);
			
			mav.setViewName("pheed/pheedList");
		} catch (Exception e) {
			log.error("최신 피드 목록 조회 오류", e);
			mav.addObject("msg", "최신 피드 목록 조회 오류");
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/selectComments.do")
	public ResponseEntity<?> pheedComments(@RequestParam int pheedNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			List<PheedComment> comments = pheedService.selectPheedCommentList(pheedNo);
			log.debug("comments = {}", comments);
			map.put("comments", comments);
		} catch (Exception e) {
			log.error("댓글 조회 오류", e);
			map.put("error", e.getMessage());
			map.put("msg", "댓글 조회 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
}
