package com.kh.bookie.club.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.club.model.dto.Mission;
import com.kh.bookie.club.model.service.ClubService;

import lombok.extern.slf4j.Slf4j;

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
			HttpServletRequest request) {
		
		try {
			
			// 목록 조회
			int numPerPage = 5;
			List<Club> list = clubService.selectClubList(cPage, numPerPage);
			log.debug("list = {}", list);
			
			
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
			@RequestParam(required = false) List<String> mCount) {

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

//			log.debug("interests = {}", interests);
			String interest = "";

			for(int m = 0; m < interests.size(); m++) {
				interest += interests.get(m);
				interest += ",";
			}
			
			interest = interest.substring(0, interest.length()-1);
			club.setInterest(interest);
			
			
//			log.debug("제발!! interest = {}", interest);
			
			
			club.setBookCount(isbn13.size());

			for (int i = 0; i < isbn13.size(); i++) {
				ClubBook book = new ClubBook();
				book.setItemId(isbn13.get(i));
				book.setImgSrc(bookImg.get(i));

				bookList.add(book);
				
				int mCnt = Integer.parseInt(mCount.get(i));
				
				
				for(int j = 0; j < mCnt; j++) { 
					 
					Mission mission = new Mission(); 
					 
					mission.setItemId(isbn13.get(i));
					mission.setContent(missionContent.get(j)); 
					mission.setPoint(finalDeposit);
					mission.setTitle(missionName.get(j));
					mission.setMEndDate(LocalDate.parse(missionDate.get(j).substring(2), DateTimeFormatter.ISO_DATE));
					
					missionList.add(mission);
				}
				 
				for(int k = mCnt-1; k >= 0 ; k--) {
					missionContent.remove(k);
					missionName.remove(k);
					missionDate.remove(k);
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


	
	

}
