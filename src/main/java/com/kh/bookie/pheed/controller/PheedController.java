package com.kh.bookie.pheed.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
	public ModelAndView pheedCList(ModelAndView mav) {
		try {
			// 목록 조회
			int cPage = 1;
			int numPerPage = 3;
			List<Pheed> list = pheedService.selectPheedCList(cPage, numPerPage);
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
	public ResponseEntity<?> getReadList(@RequestParam int cPage){
		try {
			log.debug("cPage = {}", cPage);
			int numPerPage = 3;
			
			List<Pheed> list = pheedService.selectPheedCList(cPage, numPerPage);
			log.debug("list = {}", list);
			if(list != null)
				return ResponseEntity.ok(list);
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
	
}
