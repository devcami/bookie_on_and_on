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
	         @RequestParam String ttbkey, 
	         @RequestParam String QueryType,
	         @RequestParam String SearchTarget,
	         @RequestParam int Start,
	         @RequestParam int MaxResults,
	         @RequestParam String Output,
	         @RequestParam String Cover,
	         @RequestParam String Version,
	         @RequestParam String Query){
	      Resource resource;
	      
	      String bestUrl = ALADDIN_URL + "ItemList.aspx?ttbkey=" + ttbkey 
	               + "&QueryType=" + QueryType
	               + "&SearchTarget=" + SearchTarget
	               + "&Start=" + Start
	               + "&MaxResults=" + MaxResults
	               + "&Output=" + Output
	               + "&Cover=" + Cover
	               + "&Version=" + Version;
	      String searchUrl = ALADDIN_URL + "ItemSearch.aspx?ttbkey=" + ttbkey 
	            + "&QueryType=" + QueryType
	            + "&SearchTarget=" + SearchTarget
	            + "&Start=" + Start
	            + "&MaxResults=" + MaxResults
	            + "&Output=" + Output
	            + "&Cover=" + Cover
	            + "&Version=" + Version;
	      if(!Query.equals("") && Query != null) {
	         searchUrl += "&Query=" + Query;
	         resource = resourceLoader.getResource(searchUrl);
	      } else {
	         resource = resourceLoader.getResource(bestUrl);
	      }
	      
	      return ResponseEntity.ok(resource);
	   }
	
	@GetMapping("/bookEnroll.do")
	public void bookEnroll(@RequestParam String isbn13, Model model) {
		model.addAttribute("isbn13", isbn13);
	}
	
	@GetMapping("/selectBook.do")
	public ResponseEntity<?> selectBook(
									@RequestParam String ttbkey,
									@RequestParam String itemIdType,
									@RequestParam String ItemId,
									@RequestParam String output,
									@RequestParam String Cover,
									@RequestParam String Version) {
		String url = ALADDIN_URL + "ItemLookUp.aspx?ttbkey=" + ttbkey
					+ "&itemIdType=" + itemIdType
					+ "&ItemId=" + ItemId
					+ "&output=" + output
					+ "&Cover=" + Cover
					+ "&Version=" + Version;
		Resource resource = resourceLoader.getResource(url);
		return ResponseEntity.ok(resource);
	}
	
	
	@GetMapping("/categoryList.do")
	public void categoryList() {}
	
	@GetMapping("/bookListByCategory.do")
	public void bookListByCategory(Model model, @RequestParam String category) {
		model.addAttribute("category", category);
	}
	
	@GetMapping("selectBookListByCategory.do")
	public ResponseEntity<?> selectBookListByCategory(
											@RequestParam String ttbkey, 
											@RequestParam String QueryType,
											@RequestParam String SearchTarget,
											@RequestParam int Start,
											@RequestParam int MaxResults,
											@RequestParam String Output,
											@RequestParam String Cover,
											@RequestParam String Version,
											@RequestParam int CategoryId){
		/*
		 * http://www.aladin.co.kr/ttb/api/ItemList.aspx?
		 * ttbkey=ttbiaj96820130001
		 * &QueryType=ItemNewAll
		 * &MaxResults=20
		 * &start=1
		 * &SearchTarget=Book
		 * &CategoryId=3103
		 * &output=js
		 * &Version=20131101
		 */
		String url = ALADDIN_URL + "ItemList.aspx?ttbkey=" + ttbkey 
				+ "&QueryType=" + QueryType
				+ "&MaxResults=" + MaxResults
				+ "&Start=" + Start
				+ "&SearchTarget=" + SearchTarget
				+ "&CategoryId=" + CategoryId
				+ "&Cover=" + Cover
				+ "&Output=" + Output
				+ "&Version=" + Version;
		Resource resource = resourceLoader.getResource(url);
		return ResponseEntity.ok(resource);
	}
	
	
	
}
