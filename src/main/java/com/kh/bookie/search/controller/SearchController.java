package com.kh.bookie.search.controller;

import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	ResourceLoader resourceLoader;
	
	final String ALADDIN_URL = "http://www.aladin.co.kr/ttb/api/";
	@Autowired
	ServletContext application;
	
	@GetMapping("/searchForm.do")
	public void searchForm() {}
	
	@GetMapping("/selectBookList.do")
	public ResponseEntity<?> selectBestSeller(
			@RequestBody Map<String, Object> book){
		log.debug("book = {}", book);
		log.debug("ttbkey = {}", book.get("ttbkey"));
		
//		String url = ALADDIN_URL + "ItemList.aspx?ttbkey=" + ttbkey 
//					+ "&queryType=" + queryType
//					+ "&searchTarget=" + searchTarget
//					+ "&start=" + start
//					+ "&maxResults=" + maxResults
//					+ "&output=" + output
//					+ "&cover=" + cover
//					+ "&version=" + version;
//		Resource resource = resourceLoader.getResource(url);
		return ResponseEntity.ok(null);
	}
	
	@GetMapping("/bookEnroll.do")
	public void bookEnroll(@RequestParam String isbn13, Model model) {
		model.addAttribute("isbn13", isbn13);
	}
	
	
	
	
}
