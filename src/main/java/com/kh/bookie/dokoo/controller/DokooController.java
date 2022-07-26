package com.kh.bookie.dokoo.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.service.DokooService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/dokoo")
@Slf4j
public class DokooController {

	@Autowired
	private DokooService dokooService;
	
	@Autowired
	ServletContext application;
	
	@GetMapping("/dokooList.do")
	public ModelAndView dokooList(@RequestParam(defaultValue = "1") int cPage, 
									ModelAndView mav, HttpServletRequest request) {
		try {
			int numPerPage = 10;
			List<Dokoo> list = dokooService.selectDokooList(cPage, numPerPage);
			log.debug("list = {}", list);
			mav.addObject("list", list);
			
			// pagebar
			int totalContent = dokooService.selectTotalContent();
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalContent, url);
			mav.addObject("pagebar", pagebar);
			mav.addObject("totalContent", totalContent);
			mav.addObject("cPage", cPage);
			
			mav.setViewName("dokoo/dokooList");
		} catch (Exception e) {
			log.error("독후감 목록 조회 오류", e);
			mav.addObject("msg", "독후감 목록 조회 오류");
		}
		return mav;
	}
	
	@GetMapping("/dokooDetail.do")
	public ModelAndView dokooDetail(@RequestParam int dokooNo, ModelAndView mav) {
		try {
			Dokoo dokoo = dokooService.selectOneDokoo(dokooNo);
			log.debug("dokoo = {}", dokoo);
			mav.addObject("dokoo", dokoo);
			
			mav.setViewName("dokoo/dokooDetail");
		} catch (Exception e) {
			log.error("독후감 상세 보기 오류", e);
			mav.addObject("msg", "독후감 상세 보기 오류");
		}
		return mav;
	}
}

