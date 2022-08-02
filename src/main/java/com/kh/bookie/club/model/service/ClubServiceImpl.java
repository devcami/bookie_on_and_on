package com.kh.bookie.club.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.club.model.dao.ClubDao;
import com.kh.bookie.club.model.dto.Chat;
import com.kh.bookie.club.model.dto.ChatAttachment;
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
	public List<Club> selectClubList(int cPage, int numPerPage, String sortType) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		
		// 새로하는거
		Map<String, Object> map = new HashMap<>();
		map.put("rowBounds", rowBounds);
		map.put("sortType", sortType);
		List<Club> list = clubDao.selectClubList(map);
		//
		
		/**
		// 1. club 찾아와
		List<Club> list = clubDao.selectClubList(rowBounds);
		 */
		
		
		// 2. club에 사진 할당해
		for(Club club : list) {
			List<ClubBook> bookList = clubDao.selectClubBook(club.getClubNo());
			club.setBookList(bookList);
		}
		
		return list;
		
	}

	@Override
	public int selectTotalClub() {
		return clubDao.selectTotalClub();
	}

	@Override
	public Club selectOneClub(Map<String, Object> param) {
		
		// 1. 클럽 찾아와
		Club club = clubDao.selectOneClub(param.get("clubNo"));
		
		// log.debug("1. club = {}", club);
		
		for(int i = 0; i < club.getBookList().size(); i++) {
			String itemId = club.getBookList().get(i).getItemId();
			Map<String, Object> map = new HashMap<>();
			map.put("itemId", itemId);
			map.put("clubNo", param.get("clubNo"));
			club.getBookList().set(i, clubDao.selectBookMission(map));
		}
		
		if(param.get("memberId") != null) {
			club.setIsJoined(clubDao.checkClubJoined(param));
		}
		
		log.debug("2. club = {}", club);
		
		return club; 
	}

	@Override
	public List<Mission> getMissions(Map<String, Object> param) {
		
		return clubDao.getMissions(param);
	}

	@Override
	public List<String> getClubWishListbyMemberId(String username) {
		return clubDao.getClubWishListbyMemberId(username);
	}

	@Override
	public List<String> getClubLikesListbyMemberId(String username) {
		return clubDao.getClubLikesListbyMemberId(username);
	}

	@Override
	public int insertClubLike(Map<String, Object> map) {
		return clubDao.insertClubLike(map);
	}

	@Override
	public int insertClubWishList(Map<String, Object> map) {
		return clubDao.insertClubWishList(map);
	}

	@Override
	public int deleteClubLike(Map<String, Object> map) {
		return clubDao.deleteClubLike(map);
	}

	@Override
	public int deleteClubWishList(Map<String, Object> map) {
		return clubDao.deleteClubWishList(map);
	}

	@Override
	public int checkMyPoint(String memberId) {
		return clubDao.checkMyPoint(memberId);
	}

	@Override
	public int joinClub(Map<String, Object> map) {
		// 멤버의 북클럽 신청
		
		// 1. my_club에 멤버 넣기
		int result = clubDao.joinClub(map);
		
		// 2. member 테이블 point에서 북클럽 디파짓만큼 금액 까기
		int restPoint = Integer.parseInt(map.get("myPoint").toString()) - Integer.parseInt(map.get("deposit").toString());
		
		map.put("restPoint", restPoint);
		result = clubDao.updateMyPoint(map);
		
		return result;
	}

	@Override
	public int insertClubBoard(Chat clubBoard) {
		// 1. clubBoard 먼저 insert
		int result = clubDao.insertClubBoard(clubBoard);
		int chatNo = clubBoard.getChatNo();
		log.debug("chatNo = {}", chatNo);
		
		// 2. 첨부파일 삽입
		List<ChatAttachment> attachments = clubBoard.getChatAttachments();
		if(!attachments.isEmpty()) {
			for(ChatAttachment attach : attachments) {
				attach.setChatNo(chatNo);
				result = clubDao.insertClubBoardAttachment(attach);
			}
		}
		
		
		return result;
	}

	@Override
	public Chat selectOneBoardCollection(int chatNo) {
		return clubDao.selectOneBoardCollection(chatNo);
	}

	@Override
	public List<Chat> selectClubBoardList(int clubNo) {
		return clubDao.selectClubBoardList(clubNo);
	}

	@Override
	public List<ChatAttachment> findAllClubBoardAttachByChatNo(int chatNo) {
		return clubDao.findAllClubBoardAttachByChatNo(chatNo);
	}
	
	@Override
	public int deleteAttachment(int attachNo) {
		return clubDao.deleteAttachment(attachNo);
	}

	
	@Override
	public int deleteClubBoard(int chatNo) {
		return clubDao.deleteClubBoard(chatNo);
	}

	@Override
	public ChatAttachment findOneClubBoardAttachByAttachNo(int attachNo) {
		return clubDao.findOneClubBoardAttachByAttachNo(attachNo);
	}

	@Override
	public int updateClubBoard(Chat clubBoard) {
		return clubDao.updateClubBoard(clubBoard);
	}

	@Override
	public int insertClubChatAttach(ChatAttachment attach) {
		return clubDao.insertClubChatAttach(attach);
	}


	

}
