package com.kh.bookie.pheed.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

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
	
	@GetMapping("/pheedFList.do")
	public ModelAndView pheedFList(ModelAndView mav) {
		mav.setViewName("pheed/pheedList");
		return mav;
	}
}
