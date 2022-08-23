package com.kh.bookie.search.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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

import com.kh.bookie.member.model.dto.Follower;
import com.kh.bookie.member.model.dto.Member;
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
	
	// 소개페이지 연결
	@GetMapping("/intro.do")
	public void intro() {}
	
	// 책 검색 페이지 연결
	@GetMapping("/searchForm.do")
	public void searchForm() {}
	
	/**
	 * 알라딘 API - 베스트 셀러 가져오기 
	 */
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
	      log.debug("list book aladdin url = {}", searchUrl);
	      if(!Query.equals("") && Query != null) {
	         searchUrl += "&Query=" + Query;
	         resource = resourceLoader.getResource(searchUrl);
	      } else {
	         resource = resourceLoader.getResource(bestUrl);
	      }
	      log.debug("resource = {}", resource);
	      return ResponseEntity.ok(resource);
	   }
	
	
	/**
	 * 알라딘 API - 검색한 한권 정보 가져오기 
	 */
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
		log.debug("one book aladdin url = {}", url);
		Resource resource = resourceLoader.getResource(url);
		log.debug("resource = {}", resource);
		return ResponseEntity.ok(resource);
	}
	
	// 카테고리 선택 페이지 가져오기
	@GetMapping("/categoryList.do")
	public void categoryList() {}
	
	// 카테고리 별 챍 리스트 페이지 가져오기
	@GetMapping("/bookListByCategory.do")
	public void bookListByCategory(Model model, @RequestParam String category) {
		model.addAttribute("category", category);
	}
	
	/**
	 * 알라딘 API - 카테고리별 책 리스트 가져오기 
	 */
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
	
	/**
	 * 내 책 등록 페이지 요청 + 책번호 모델로 전송
	 */
	@GetMapping("/bookEnroll.do")
	public void bookEnroll(@RequestParam String isbn13, Model model, @AuthenticationPrincipal Member member) {
		log.debug("member = {}", member);
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
	
	/**
	 * 완독일 리스트 가져오기
	 */
	@GetMapping("/selectReadList.do")
	public ResponseEntity<?> selectReadList(@RequestParam String itemId, @RequestParam String memberId){
		try {
			log.debug("itemId = {} , memberId = {}", itemId, memberId);
			Map<String, Object> map = new HashMap<>();
			map.put("itemId", itemId);
			map.put("memberId", memberId);
			
			// book에서 가져와
			List<Book> bookList = searchService.selectReadList(map);
			log.debug("bookList = {}", bookList);
			
			return ResponseEntity.ok(bookList);
		} catch (Exception e) {
			log.error("book_ing 책 내역 가져오기 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	/**
	 * 내 책 등록
	 */
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
	
	/**
	 * 내 책 수정
	 */
	@PostMapping("/bookUpdate.do")
	public String bookUpdate(Book book, RedirectAttributes ra) {
		try {
			log.debug("book = {}", book);
			log.debug("bookStatus = {}", book.getStatus());
			int result = searchService.bookUpdate(book);
			ra.addFlashAttribute("msg", "책 수정 완료 !");
		} catch (Exception e) {
			log.error("내 책 수정 오류", e);
			throw e;
		}
		return "redirect:/search/bookEnroll.do?isbn13=" + book.getItemId();
	}
	
	/**
	 * 내 책 삭제
	 */
	@PostMapping("/bookDelete.do")
	public String bookDelete(Book book, RedirectAttributes ra) {
		try {
			log.debug("book = {}", book);
			log.debug("bookStatus = {}", book.getStatus());
			int result = searchService.bookDelete(book);
			ra.addFlashAttribute("msg", "책 삭제 완료 !");
		} catch (Exception e) {
			log.error("내 책 삭제 오류", e);
			throw e;
		}
		return "redirect:/search/bookEnroll.do?isbn13=" + book.getItemId();
	}
	
	/**
	 * 완독일 추가
	 * @return
	 */
	@PostMapping("/moreRead.do")
	public String moreRead(Book book, RedirectAttributes ra) {
		try {
			log.debug("book = {}", book); //memberId itemId startedAt endedAt score status content ingNo
			int result = searchService.moreReadEnroll(book);
			ra.addFlashAttribute("msg", "완독일 추가 등록 완료 !");
		} catch (Exception e) {
			log.error("완독일 추가 등록 오류", e);
			throw e;
		}
		return "redirect:/search/bookEnroll.do?isbn13=" + book.getItemId();
	}
	
	/**
	 * 완독일 삭제
	 */
	@PostMapping("/moreReadDelete.do")
	public ResponseEntity<?> moreReadDelete(@RequestParam String itemId, @RequestParam String memberId, @RequestParam int ingNo){
		Map<String, Object> map = new HashMap<>();
		log.debug("itemId = {} , memberId = {}", itemId, memberId);
		log.debug("ingNo = {}",ingNo);
		try {
			
			Book book = new Book();
			book.setIngNo(ingNo);
			book.setItemId(itemId);
			book.setMemberId(memberId);
			
			int result = searchService.moreReadDelete(book);
			map.put("msg", "완독일 삭제 완료");
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			log.error("완독일 삭제 오류", e);
			map.put("msg", "완독일 삭제 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		}
	}
	
	/**
	 * 완독일 수정
	 */
	@PostMapping("/moreReadUpdate.do")
	public ResponseEntity<?> moreReadUpdate(Book book){
		Map<String, Object> map = new HashMap<>();
		log.debug("book = {}",book);
		try {
			int result = searchService.moreReadUpdate(book);
			map.put("book", book);
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			log.error("완독일 삭제 오류", e);
			map.put("msg", "완독일 삭제 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		}
	}
	
	@GetMapping("/recommendUser.do")
	public void recommendUser(Model model, @AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		Member member = searchService.selectOneMember(memberId);
		log.debug("member = {}", member);
		if(member.getInterest() != null) {
			List<String> interests = Arrays.asList(member.getInterest().split(","));
			log.debug("interests = {}", interests);
			
			
			model.addAttribute("interests", interests);
		}
		// 넘길 때 로그인 유저의 팔로워 같이 넘기기
		List<Follower> followerList = searchService.selectFollowerList(memberId);
		if(!followerList.isEmpty()) {
			String followers = "";
			for(Follower follower : followerList) {
				 followers += follower.getFollowingMemberId() + ",";
			}
			model.addAttribute("followers", followers);
		}
		model.addAttribute("member", member);
	}
	
	@PostMapping("/updateMypick.do")
	public ResponseEntity<?> updateMypick(Book book){
		Map<String, Object> map = new HashMap<>();
		log.debug("book = {}",book);
		try {
			int result = searchService.updateMypick(book);
			map.put("book", book);
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			log.error("마이픽 등록 오류", e);
			map.put("msg", "마이픽 등록 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		}
	}
	
	@GetMapping("/selectMemberListByInterest.do")
	public ResponseEntity<?> selectMemberListByInterest(@RequestParam String interest, @RequestParam String memberId){
		Map<String, Object> map = new HashMap<>();
		log.debug("interest = {}", interest);
		log.debug("memberId = {}", memberId);
		try {
			map.put("memberId", memberId);
			map.put("interest", interest);
			List<Member> list = searchService.selectMemberListByInterest(map);
			
			return ResponseEntity.ok(list);
		} catch (Exception e) {
			log.error("관심사 멤버 불러오기 오류", e);
			map.put("msg", "관심사 멤버 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		}
	}
	
	@PostMapping("/insertFollower.do")
	public ResponseEntity<?> insertFollower(@RequestParam String memberId, @RequestParam String followingMemberId){
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("memberId", memberId);
			map.put("followingMemberId", followingMemberId);
			int result = searchService.insertFollower(map);
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			log.error("팔로워 등록 오류", e);
			map.put("msg", "팔로워 등록 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		}
	}
	
	@PostMapping("/deleteFollower.do")
	public ResponseEntity<?> deleteFollower(@RequestParam String memberId, @RequestParam String followingMemberId){
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("memberId", memberId);
			map.put("followingMemberId", followingMemberId);
			int result = searchService.deleteFollower(map);
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			log.error("팔로워 취소 오류", e);
			map.put("msg", "팔로워 취소 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		}
	}
		
	
}
