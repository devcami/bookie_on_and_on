package com.kh.bookie.pheed.controller;

import java.io.File;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedAttachment;
import com.kh.bookie.pheed.model.dto.PheedComment;
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
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/pheedFList.do")
	//@AuthenticationPrincipal Member loginMember
	public ModelAndView pheedFList(ModelAndView mav, HttpServletRequest request) {
		try {
			// 목록 조회
			// list 조회 때 loginMember를 넘긴다
//			List<Pheed> list = pheedService.selectPheedFList();
//			log.debug("list", list);
//			mav.addObject("list", list);
			
			mav.setViewName("pheed/pheedList");
		} catch (Exception e) {
			log.error("팔로워 피드 목록 조회 오류", e);
			mav.addObject("msg", "팔로워 피드 목록 조회 오류");
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/pheedCList.do")
	public ModelAndView pheedCList(ModelAndView mav, @AuthenticationPrincipal Member loginMember) {
		Map<String, Object> map = new HashMap<>();
		try {
			
			log.debug("authentication member = {} ", loginMember);
			log.debug("authentication member = {} ", loginMember.getNickname());
			
			if(loginMember != null) {
				
				// 멤버 있으면 북클럽 찜 리스트 가져와 
				List<String> pheedWishList = pheedService.getPheedWishListbyMemberId(loginMember.getMemberId());
				
				String wishStr = "";
				for(int i = 0; i < pheedWishList.size(); i++) {
					wishStr += pheedWishList.get(i);
					wishStr +=  ",";
				}
				
				mav.addObject("wishStr", wishStr);
				
				// 멤버 있으면 북클럽 하트 리스트 가져와 
				List<String> pheedLikesList = pheedService.getPheedLikesListbyMemberId(loginMember.getMemberId());
				
				String likesStr = "";
				for(int j = 0;  j < pheedLikesList.size(); j++) {
					likesStr += pheedLikesList.get(j);
					likesStr +=  ",";
				}
				mav.addObject("likesStr", likesStr);
			}
			
			
			
			// 목록 조회
			int cPage = 1;
			int numPerPage = 3;
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			
			List<Pheed> list = pheedService.selectPheedCList(map);
			log.debug("list = {}", list);
			mav.addObject("list", list);
			
			mav.setViewName("pheed/pheedList");
		} catch (Exception e) {
			log.error("최신 피드 목록 조회 오류", e);
			mav.addObject("msg", "최신 피드 목록 조회 오류");
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/getReadList.do")
	public ResponseEntity<?> getReadList(@RequestParam int cPage, @AuthenticationPrincipal Member loginMember){
		try {
			Map<String, Object> map = new HashMap<>();
			log.debug("authentication member = {} ", loginMember);
			log.debug("authentication member = {} ", loginMember.getNickname());
			
			if(loginMember != null) {
				
				// 멤버 있으면 북클럽 찜 리스트 가져와 
				List<String> pheedWishList = pheedService.getPheedWishListbyMemberId(loginMember.getMemberId());
				
				String wishStr = "";
				for(int i = 0; i < pheedWishList.size(); i++) {
					wishStr += pheedWishList.get(i);
					wishStr +=  ",";
				}
				
				map.put("wishStr", wishStr);
				
				// 멤버 있으면 북클럽 하트 리스트 가져와 
				List<String> pheedLikesList = pheedService.getPheedLikesListbyMemberId(loginMember.getMemberId());
				
				String likesStr = "";
				for(int j = 0;  j < pheedLikesList.size(); j++) {
					likesStr += pheedLikesList.get(j);
					likesStr +=  ",";
				}
				map.put("likesStr", likesStr);
			}
			
			
			// cPage = 2 -> 4~6
			// cPage = 3 -> 7~9 ...
			log.debug("cPage = {}", cPage);
			cPage = (cPage - 1) * 3 + 1;
			int numPerPage = cPage * 3;
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			List<Pheed> list = pheedService.selectPheedCList(map);
			log.debug("list = {}", list);
			if(list != null) {
				map.put("list", list);
				return ResponseEntity.ok(map);
			}
			else
				return ResponseEntity.ok(null);
		} catch (Exception e) {
			log.error("피드 스크롤 더 가져오기 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}
	
	@GetMapping("/pheedEnroll.do")
	public void pheedEnroll() {}
	
	@PostMapping("/pheedEnroll.do")
	public String pheedEnroll(Pheed pheed, RedirectAttributes ra, @RequestParam (required = false) MultipartFile upFile) {
		try {
			log.debug("pheed = {}", pheed);
			String saveDirectory = application.getRealPath("/resources/upload/pheed");
			
			//업로드한 파일 저장
			if(upFile.getSize() > 0) {
				// 파일명 재지정
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = HelloSpringUtils.getRenamedFilename(originalFilename);
				log.debug("renamedFilename = {}", renamedFilename);
			
				// 파일 저장
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);
				
				// ChatAttachment 객체로 만들어서 => club
				PheedAttachment attach = new PheedAttachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				pheed.setAttach(attach);
				
			}
			
			int result = pheedService.pheedEnroll(pheed);
			
			ra.addFlashAttribute("msg", "피드 등록 완료 !");	
		} catch (Exception e) {
			log.error("피드 등록 오류", e);
			e.printStackTrace();
		}
		return "redirect:/pheed/pheedCList.do";
	}
	
	@GetMapping("/selectComments.do")
	public ResponseEntity<?> pheedComments(@RequestParam int pheedNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			List<PheedComment> comments = pheedService.selectPheedCommentList(pheedNo);
			log.debug("comments = {}", comments);
			map.put("comments", comments);
		} catch (Exception e) {
			log.error("댓글 조회 오류", e);
			map.put("error", e.getMessage());
			map.put("msg", "댓글 조회 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/pheedReport.do")
	public ResponseEntity<?> report(@RequestParam String memberId, 
						 			@RequestParam String category,
					 				@RequestParam String content,
					 				@RequestParam int beenziNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			log.debug("memberId = {}", memberId);
			log.debug("category = {}", category);
			log.debug("content = {}", content);
			log.debug("beenziNo = {}", beenziNo);
			map.put("memberId", memberId);
			map.put("category", category);
			map.put("content", content);
			map.put("beenziNo", beenziNo);
			
			int result = pheedService.report(map);
			map.put("msg", "신고 접수가 완료되었습니다.");
		} catch (Exception e) {
			log.error("신고 접수 오류", e);
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
		
	}
	
	@PostMapping("/insertLikesWish.do")
	public ResponseEntity<?> insertLikesWish(
					@RequestParam String shape,
					@RequestParam String memberId,
					@RequestParam int pheedNo){
		
		log.debug("shape = {}", shape);
		log.debug("memberId = {}", memberId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("pheedNo", pheedNo);		
		
		try {
			if(shape.equals("heart")) {
				// 하트인경우 좋아요 인서트
				int result = pheedService.insertPheedLike(map);
			}
			else {
				int result = pheedService.insertPheedWishList(map);
			}
			
		} catch(Exception e) {
			log.error("피드 하트/찜 등록 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(null);
	}
	
	@PostMapping("/deleteLikesWish.do")
	public ResponseEntity<?> deleteLikesWish(
					@RequestParam String shape,
					@RequestParam String memberId,
					@RequestParam int pheedNo){
		
		log.debug("shape = {}", shape);
		log.debug("memberId = {}", memberId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("pheedNo", pheedNo);		
		
		try {
			if(shape.equals("heart")) {
				// 하트인경우 하트
				int result = pheedService.deletePheedLike(map);
			}
			else {
				int result = pheedService.deletePheedWishList(map);
			}
			
		} catch(Exception e) {
			log.error("피드 하트/찜 삭제 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(null);
	}
	
	@PostMapping("/deletePheed.do")
	public ResponseEntity<?> deletePheed(@RequestParam int pheedNo){
		Map<String, Object> map = new HashMap<>();
		try {
			int result = pheedService.deletePheed(pheedNo);
			map.put("msg", "삭제가 완료되었습니다.");
		} catch(Exception e) {
			log.error("피드 삭제 오류", e);
			map.put("msg", "피드 삭제 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/pheedUpdate.do")
	public ModelAndView pheedUpdate (@RequestParam int pheedNo, ModelAndView mav) {
		try {
			Pheed pheed = pheedService.selectOnePheed(pheedNo);
			log.debug("pheed = {}", pheed);
			mav.addObject("pheed", pheed);
			
			mav.setViewName("pheed/pheedUpdate");
		} catch (Exception e) {
			log.error("피드 수정 폼 요청 오류", e);
			mav.addObject("msg", "피드 수정 폼 요청 오류");
		}
		return mav;
	}
	
	@PostMapping("/pheedUpdate.do")
	public String pheedUpdate(Pheed pheed, RedirectAttributes ra, @RequestParam (required = false) MultipartFile upFile) {
		try {
			log.debug("pheed = {}", pheed);
			String saveDirectory = application.getRealPath("/resources/upload/pheed");
			
			//업로드한 파일 저장
			if(upFile.getSize() > 0) {
				// 파일명 재지정
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = HelloSpringUtils.getRenamedFilename(originalFilename);
				log.debug("renamedFilename = {}", renamedFilename);
			
				// 파일 저장
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);
				
				// ChatAttachment 객체로 만들어서 => club
				PheedAttachment attach = new PheedAttachment();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				pheed.setAttach(attach);
				
			}
			
			//int result = pheedService.pheedUpdate(pheed);
			
			ra.addFlashAttribute("msg", "피드 수정 완료 !");	
		} catch (Exception e) {
			log.error("피드 수정 오류", e);
			e.printStackTrace();
		}
		return "redirect:/pheed/pheedCList.do";
	}
	
}
