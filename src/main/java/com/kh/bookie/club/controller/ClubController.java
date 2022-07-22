package com.kh.bookie.club.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.bookie.club.model.service.ClubService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/club")
@Slf4j
@SessionAttributes({"next"})
public class ClubController {

	@Autowired
	private ClubService clubService;
	
	@Autowired
	ServletContext application;
	
	@GetMapping("/clubList.do")
	public void clubList() {}

	@GetMapping("/enrollClub.do")
	public void enrollClub() {}
	
	@GetMapping("/addBookPopup.do")
	public void addBookPopup() {}
	
//	@GetMapping("/bookEnroll.do")
//	public void bookEnroll(@RequestParam String isbn13, Model model) {
//		model.addAttribute("isbn13", isbn13);
//	}
	
	
	
	
}
