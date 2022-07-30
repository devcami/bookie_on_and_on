package com.kh.bookie.club.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.club.model.dto.Mission;
import com.kh.bookie.club.model.service.ClubService;
import com.kh.bookie.common.HelloSpringUtils;
import com.kh.bookie.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/club")
@Slf4j
@SessionAttributes({ "next" })
public class ClubController {

	@Autowired
	private ClubService clubService;

	@Autowired
	ServletContext application;

	@GetMapping("/clubList.do")
	public ModelAndView clubList(
			@RequestParam(defaultValue = "1") int cPage,
			ModelAndView mav,
			HttpServletRequest request,
			Principal principal) {
		
		
		try {
			
			UsernamePasswordAuthenticationToken authentication = (UsernamePasswordAuthenticationToken)principal;
			log.debug("authentication = {} ", authentication);
			
			if(authentication != null) {
				Object _principal = authentication.getPrincipal();
				Member loginMember = (Member)_principal;					
				log.debug("있나여? loginMember = {}", loginMember.getUsername());
				
				
				// 멤버 있으면 북클럽 찜 리스트 가져와 
				List<String> clubWishList = clubService.getClubWishListbyMemberId(loginMember.getUsername());
//				log.debug("clubWishList = {}", clubWishList);
				
				String wishStr = "";
				for(int i = 0; i < clubWishList.size(); i++) {
					wishStr += clubWishList.get(i);
					wishStr +=  ",";
				}
				
				mav.addObject("wishStr", wishStr);
				
				// 멤버 있으면 북클럽 하트 리스트 가져와 
				List<String> clubLikesList = clubService.getClubLikesListbyMemberId(loginMember.getUsername());
				
				String likesStr = "";
				for(int j = 0;  j < clubLikesList.size(); j++) {
					likesStr += clubLikesList.get(j);
					likesStr +=  ",";
				}
				mav.addObject("likesStr", likesStr);
				
			}
			

			
			// 목록 조회
			int numPerPage = 8;
			List<Club> list = clubService.selectClubList(cPage, numPerPage);
			mav.addObject("list", list);
			
			// 페이지 바
			int totalClub = clubService.selectTotalClub();
			String url = request.getRequestURI();
			String pagebar = HelloSpringUtils.getPagebar(cPage, numPerPage, totalClub, url);
			mav.addObject("pagebar", pagebar);
			
		} catch(Exception e) {
			log.error("북클럽목록 조회 오류!!", e);
			mav.addObject("msg", "북클럽목록 조회에 실패했습니다!");
			throw e;
		}
		
		return mav;
	}

	@GetMapping("/enrollClub.do")
	public void enrollClub() {
	}

	@PostMapping("/enrollClub.do")
	public ModelAndView enrollClub(
			ModelAndView mav, 
			Club club, 
			@RequestParam List<String> isbn13,
			@RequestParam List<String> bookImg, 
			@RequestParam(required = false) List<String> interests,
			@RequestParam(required = false) List<String> missionName,
			@RequestParam(required = false) List<String> missionDate,
			@RequestParam(required = false) List<String> missionContent,
			@RequestParam(required = false) int finalDeposit, 
			@RequestParam(required = false) List<String> mCount,
			@RequestParam List<String> bookName) {

		List<ClubBook> bookList = new ArrayList<>();
		List<Mission> missionList = new ArrayList<>();

		try {

//			log.debug("club = {}", club);
//			log.debug("isbn13 = {}", isbn13);
//			log.debug("bookImg = {}", bookImg);
//			log.debug("missionName = {}", missionName);
//			log.debug("missionDate = {}", missionDate);
//			log.debug("missionContent = {}", missionContent);
//			log.debug("missionDeposit = {}", finalDeposit);
//			log.debug("mCount = {}", mCount);
//			log.debug("mCount = {}", mCount);
//			log.debug("bookName = {}", bookName);

//			log.debug("interests = {}", interests);
			String interest = "";

			for(int m = 0; m < interests.size(); m++) {
				interest += interests.get(m);
				interest += ",";
			}
			interest = interest.substring(0, interest.length()-1);
			club.setInterest(interest);
			club.setBookCount(isbn13.size());
			
			//
			if(!mCount.isEmpty()) {
				String missionCnt = "";			
				for(int n = 0; n < mCount.size(); n++) {
					missionCnt += mCount.get(n);
					missionCnt += ",";
				}				
				missionCnt = missionCnt.substring(0, missionCnt.length()-1);
				club.setMissionCnt(missionCnt);
			}
			
			// 
			

			
			for (int i = 0; i < isbn13.size(); i++) {
				ClubBook book = new ClubBook();
				book.setItemId(isbn13.get(i));
				book.setImgSrc(bookImg.get(i));
				book.setBookTitle(bookName.get(i));

				bookList.add(book);
				
				
				if(mCount.size() != 0) {
					int mCnt = Integer.parseInt(mCount.get(i));
					
					for(int j = 0; j < mCnt; j++) { 
						
						Mission mission = new Mission(); 
						
						mission.setItemId(isbn13.get(i));
						mission.setContent(missionContent.get(j)); 
						mission.setPoint(finalDeposit);
						mission.setTitle(missionName.get(j));
						mission.setMendDate(LocalDate.parse(missionDate.get(j).substring(2), DateTimeFormatter.ISO_DATE));
						
						missionList.add(mission);
					}
					
					for(int k = mCnt-1; k >= 0 ; k--) {
						missionContent.remove(k);
						missionName.remove(k);
						missionDate.remove(k);
					}
					
				}
				 

			}
			
			club.setBookList(bookList);
			club.setMissionList(missionList);
			
//			log.debug("bookList = {}", club.getBookList());
//			log.debug("missionList = {}", club.getMissionList());
			
			int result = clubService.enrollClub(club);
			mav.addObject("club", club);
			mav.addObject("msg", "북클럽이 등록되었습니다!");
			mav.setViewName("club/clubAnn");

		} catch (Exception e) {
			log.error("북클럽 등록 오류!!", e);
			mav.addObject("msg", "북클럽 등록에 실패했습니다!");
			throw e;
		}

		return mav;
	}


	@GetMapping("/clubAnn.do")
	public ModelAndView clubAnn(
			ModelAndView mav,
			@RequestParam int clubNo,
			@RequestParam(required = false) String memberId) {

		Map<String, Object> param = new HashMap<>();
		
		try {
			
			param.put("clubNo", clubNo);
			param.put("memberId", memberId);
			
			Club club = clubService.selectOneClub(param);

			log.debug("bookMission = {}", club.getBookList().get(0).getMissionList());
						
			mav.addObject("club", club);
			
		} catch(Exception e) {
			log.error("클럽 공고 상세보기 오류!", e);
			mav.addObject("msg", "클럽 공고 상세조회에 실패했습니다!");
			throw e;
		}
		
		return mav;
	}

	
	@GetMapping("/getMission.do")
	public ResponseEntity<?> getMissions(
			@RequestParam String itemId,
			@RequestParam int clubNo) {
		
		Map<String, Object> map = new HashMap<>();

		try {
			Map<String, Object> param = new HashMap<>();
			log.debug("itemId = {}", itemId);
			log.debug("clubNo = {}", clubNo);
			
			param.put("itemId", itemId);
			param.put("clubNo", clubNo);
			
			List<Mission> missionList = clubService.getMissions(param);
			
//			log.debug("missionList = {}", missionList);
			map.put("missionList", missionList);
		} catch(Exception e) {
			log.error("선택한 책 미션리스트 불러오기 오류", e);
			map.put("msg", "선택한 책 미션리스트 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/insertLikesWish.do")
	public ResponseEntity<?> insertLikesWish(
					@RequestParam String shape,
					@RequestParam String memberId,
					@RequestParam int clubNo){
		
		log.debug("shape = {}", shape);
		log.debug("memberId = {}", memberId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("clubNo", clubNo);		
		
		try {
			if(shape.equals("heart")) {
				// 하트인경우 하트
				int result = clubService.insertClubLike(map);
			}
			else {
				int result = clubService.insertClubWishList(map);
			}
			
		} catch(Exception e) {
			log.error("북클럽 하트/찜 등록 오류", e);
			
		}
		return ResponseEntity.ok(null);
	}
	
	
	@PostMapping("/deleteLikesWish.do")
	public ResponseEntity<?> deleteLikesWish(
					@RequestParam String shape,
					@RequestParam String memberId,
					@RequestParam int clubNo){
		
		log.debug("shape = {}", shape);
		log.debug("memberId = {}", memberId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("clubNo", clubNo);		
		
		try {
			if(shape.equals("heart")) {
				// 하트인경우 하트
				int result = clubService.deleteClubLike(map);
			}
			else {
				int result = clubService.deleteClubWishList(map);
			}
			
		} catch(Exception e) {
			log.error("북클럽 하트/찜 삭제 오류", e);
			
		}
		return ResponseEntity.ok(null);
	}
	
	@GetMapping("/checkMyPoint.do")
	public ResponseEntity<?> checkMyPoint(
			@RequestParam String memberId,
			@RequestParam int deposit
			){
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			
			log.debug("memberId = {}", memberId);
			log.debug("deposit = {}", deposit);
			
			int myPoint = clubService.checkMyPoint(memberId);
			
			map.put("myPoint", myPoint);
			
			if(myPoint >= deposit) {
				map.put("result", "enough");
				map.put("msg", "포인트가 충분합니다 :)");
			}
			else {
				map.put("result", "notEnough");
				map.put("msg", "포인트가 부족합니다! 마이페이지에서 먼저 포인트를 충전해주세요.");
			}
			
		} catch(Exception e) {
			log.error("내 디파짓 조회 오류!", e);
			map.put("errorMsg", "내 포인트 조회 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/joinClub.do")
	public String joinClub(
			@RequestParam String memberId,
			@RequestParam int clubNo,
			@RequestParam int deposit,
			@RequestParam int myPoint,
			RedirectAttributes redirectAttr
			) {
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			map.put("memberId", memberId);
			map.put("clubNo", clubNo);
			map.put("deposit", deposit);
			map.put("myPoint", myPoint);

			int result = clubService.joinClub(map);
			
			redirectAttr.addFlashAttribute("msg", "북클럽에 신청되었습니다!");
		} catch(Exception e) {
			log.error("멤버 북클럽 신청 오류", e);
			redirectAttr.addFlashAttribute("msg", "북클럽 신청에 실패했습니다!");
		}
		
		return "redirect:/club/clubAnn.do?clubNo=" + clubNo + "&memberId=" + memberId;

	}
	
	
}
