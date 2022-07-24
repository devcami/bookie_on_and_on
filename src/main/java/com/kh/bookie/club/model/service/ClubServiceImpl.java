package com.kh.bookie.club.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.club.model.dao.ClubDao;
import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.club.model.dto.Mission;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ClubServiceImpl implements ClubService {
	
	@Autowired
	private ClubDao clubDao;

	@Override
	public int enrollClub(Club club) {
		
		// 1. club insert 
		int result = clubDao.enrollClub(club);
		
		// club.no 확인
		log.debug("club#no = {}", club.getClubNo());
		
		// 2. clubBook insert
		List<ClubBook> bookList = club.getBookList();
		if(!bookList.isEmpty()) {
			for(ClubBook book : bookList) {
				book.setClubNo(club.getClubNo());
				result = clubDao.insertClubBook(book);
			}
		}
		
		// 3. mission insert
		List<Mission> missionList = club.getMissionList();
		if(!missionList.isEmpty()) {
			for(Mission mission : missionList) {
				mission.setClubNo(club.getClubNo());
				result = clubDao.insertMission(mission);
			}
		}
		
		return result;
	}

	@Override
	public List<Club> selectClubList(int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		// 1. club 찾아와
		return clubDao.selectClubList(rowBounds);
	}

	@Override
	public int selectTotalClub() {
		return clubDao.selectTotalClub();
	}

	@Override
	public Club selectOneClub(int clubNo) {
		return clubDao.selectOneClub(clubNo);
	}

}
