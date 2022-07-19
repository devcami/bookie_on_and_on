package com.kh.bookie.search.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.bookie.search.model.service.SearchService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/search")
@Slf4j
@SessionAttributes({"next"})
public class SearchController {

	@Autowired
	private SearchService searchService;
	
	@Autowired
	ServletContext application;
	
	@GetMapping("/searchForm.do")
	public void searchForm() {}
	
	@GetMapping("/bookEnroll.do")
	public void bookEnroll(@RequestParam String itemId, Model model) {
		model.addAttribute("itemId", itemId);
	}
	
	
	
}
