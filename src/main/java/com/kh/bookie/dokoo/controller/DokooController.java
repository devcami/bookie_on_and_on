package com.kh.bookie.dokoo.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView dokooList(ModelAndView mav) {
		try {
			List<Dokoo> list = dokooService.selectDokooList();
			log.debug("list = {}", list);
			mav.addObject("list", list);
			mav.setViewName("dokoo/dokooList");
		} catch (Exception e) {
			log.error("독후감 목록 조회 오류", e);
			mav.addObject("msg", "독후감 목록 조회 오류");
			throw e;
		}
		return mav;
	}
}

