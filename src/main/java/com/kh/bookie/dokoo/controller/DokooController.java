package com.kh.bookie.dokoo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;
import com.kh.bookie.dokoo.model.dto.DokooSns;
import com.kh.bookie.dokoo.model.service.DokooService;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dto.Book;

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
	
	@GetMapping("/dokooEnroll.do")
	public void dokooEnroll() {}
	
	@GetMapping("/getReadBookList.do")
	public ResponseEntity<?> getReadBookList(@RequestParam String memberId){
		try {
			log.debug("memberId = {}", memberId);
			List<Book> bookList = dokooService.getReadBookList(memberId);
			log.debug("bookList = {}", bookList);
			return ResponseEntity.ok(bookList);
		} catch (Exception e) {
			log.error("다 읽은 책 내역 가져오기 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
		
	}
	
	@PostMapping("/dokooEnroll.do")
	public String dokooEnroll(Dokoo dokoo, RedirectAttributes ra) {
		try {
			log.debug("dokoo = {}", dokoo);
			int result = dokooService.dokooEnroll(dokoo);
			ra.addFlashAttribute("msg", "독후감 등록 완료 !");	
		} catch (Exception e) {
			log.error("독후감 등록 오류", e);
			throw e;
		}
		return "redirect:/dokoo/dokooDetail.do?dokooNo=" + dokoo.getDokooNo();
	}
	
	@PostMapping("/commentEnroll.do")
	public ResponseEntity<?> commentEnroll(DokooComment dc){
		try {
			log.debug("dokooComment = {}", dc);
			int result = dokooService.commentEnroll(dc);
			
			return ResponseEntity.ok(dc);
		} catch (Exception e) {
			log.error("댓글 등록 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	@PostMapping("/commentDel.do")
	public ResponseEntity<?> commentDel(@RequestParam int dokooCNo){
		try {
			log.debug("dokooComment = {}", dokooCNo);
			int result = dokooService.commentDel(dokooCNo);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			log.error("댓글 삭제 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	@PostMapping("/commentUpdate.do")
	public ResponseEntity<?> commentUpdate(DokooComment dokooComment, RedirectAttributes ra) {
		try {
			log.debug("dokooComment = {}", dokooComment);
			int result = dokooService.commentUpdate(dokooComment);
			ra.addFlashAttribute("msg", "독후감 댓글 수정 완료 !");	
			return ResponseEntity.ok(dokooComment);
		} catch (Exception e) {
			log.error("독후감 댓글 수정 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	@PostMapping("/commentRefEnroll.do")
	public ResponseEntity<?> commentRefEnroll(DokooComment dc){
		try {
			log.debug("dokooComment = {}", dc);
			int result = dokooService.commentRefEnroll(dc);
			return ResponseEntity.ok(dc);
		} catch (Exception e) {
			log.error("댓글 등록 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	@GetMapping("/getDokooSns.do")
	public ResponseEntity<?> getDokooSns(@RequestParam int dokooNo, @RequestParam String memberId){
		try {
			log.debug("dokooNo = {}, loginMember = {}", dokooNo, memberId);
			Map<String, Object> map = new HashMap<>();
			map.put("dokooNo", dokooNo);
			map.put("memberId", memberId);
			List<DokooSns> dokooSns = dokooService.getDokooSns(map);
			log.debug("dokooSns = {}", dokooSns);
			if(dokooSns.isEmpty()) {
				return ResponseEntity.ok().build();
			}
			else {
				return ResponseEntity.ok(dokooSns);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	@PostMapping("/insertLikesWish.do")
	public ResponseEntity<?> insertLikesWish(
					@RequestParam String shape,
					@RequestParam String memberId,
					@RequestParam int dokooNo){
		
		log.debug("shape = {}", shape);
		log.debug("memberId = {}", memberId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("dokooNo", dokooNo);		
		
		try {
			if(shape.equals("heart")) {
				// 하트인경우 하트
				int result = dokooService.insertDokooLike(map);
			}
			else {
				int result = dokooService.insertDokooWishList(map);
			}
			
		} catch(Exception e) {
			log.error("북클럽 하트/찜 등록 오류", e);
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
			
		}
		return ResponseEntity.ok(null);
	}
	
	@PostMapping("/deleteLikesWish.do")
	public ResponseEntity<?> deleteLikesWish(
					@RequestParam String shape,
					@RequestParam String memberId,
					@RequestParam int dokooNo){
		
		log.debug("shape = {}", shape);
		log.debug("memberId = {}", memberId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("dokooNo", dokooNo);		
		
		try {
			if(shape.equals("heart")) {
				// 하트인경우 하트
				int result = dokooService.deleteDokooLike(map);
			}
			else {
				int result = dokooService.deleteDokooWishList(map);
			}
			
		} catch(Exception e) {
			log.error("북클럽 하트/찜 등록 오류", e);
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();			
		}
		return ResponseEntity.ok(null);
	}
	
	@PostMapping("/deleteDokoo.do")
	public String deleteDokoo(@RequestParam int dokooNo) {
		try {
			log.debug("dokooNo = {}", dokooNo);
			int result = dokooService.deleteDokoo(dokooNo);
		} catch (Exception e) {
			log.error("독후감 삭제 오류", e);
		}
		return "redirect:/dokoo/dokooList.do";
	}
	
	@GetMapping("/updateDokoo.do")
	public ModelAndView updateDokoo(@RequestParam int dokooNo, ModelAndView mav) {
		try {
			Dokoo dokoo = dokooService.selectOneDokoo(dokooNo);
			log.debug("dokoo = {}", dokoo);
			mav.addObject("dokoo", dokoo);
			
			mav.setViewName("dokoo/dokooUpdate");
		} catch (Exception e) {
			log.error("독후감 수정 폼 요청 오류", e);
			mav.addObject("msg", "독후감 수정 폼 요청 오류");
		}
		return mav;
	}
	
	@PostMapping("/updateDokoo.do")
	public String updateDokoo(Dokoo dokoo, RedirectAttributes ra) {
		try {
			log.debug("dokoo = {}", dokoo);
			int result = dokooService.updateDokoo(dokoo);
		} catch (Exception e) {
			log.error("독후감 수정 오류", e);
			throw e;
		}
		return "redirect:/dokoo/dokooDetail.do?dokooNo=" + dokoo.getDokooNo();
	}
	
}

