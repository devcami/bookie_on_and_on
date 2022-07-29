package com.kh.bookie.search.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.mypage.model.dto.Book;
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
	
	@GetMapping("/intro.do")
	public void intro() {}
	
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
	
	@GetMapping("/bookEnroll.do")
	public void bookEnroll(@RequestParam String isbn13, Model model, @AuthenticationPrincipal com.kh.bookie.member.model.dto.Member member) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", member.getMemberId());
		map.put("itemId", isbn13);
		Book book = searchService.getMyBook(map);
		if(book != null) {
			if(book.getItemId().equals(isbn13)) {
				model.addAttribute("book", book);
			}
		}
		model.addAttribute("isbn13", isbn13);
	}
	
	@PostMapping("/bookEnroll.do")
	public String bookEnroll(Book book, RedirectAttributes ra) {
		try {
			log.debug("book = {}", book);
			int result = searchService.bookEnroll(book);
			ra.addFlashAttribute("msg", "책 등록 완료 !");
		} catch (Exception e) {
			log.error("내 책 등록 오류", e);
			throw e;
		}
		return "redirect:/search/bookEnroll.do?isbn13=" + book.getItemId();
	}
	
	
}
