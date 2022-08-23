package com.kh.bookie.club.model.service;

import java.time.LocalDate;
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
import com.kh.bookie.club.model.dto.ChatComment;
import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubApplicant;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.club.model.dto.Mission;
import com.kh.bookie.club.model.dto.MissionStatus;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.point.model.dto.PointStatus;

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
	public List<Club> selectClubList(Map<String, Object> map) {

		// 1. club 찾아와
		List<Club> list = clubDao.selectClubList(map);

		
		// 2. club에 사진 할당해
		for(Club club : list) {
			List<ClubBook> bookList = clubDao.selectClubBook(club.getClubNo());
			club.setBookList(bookList);
		}
		
		return list;
		
	}
	
	@Override
	public List<Club> selectClubOldList(Map<String, Object> map) {

		// 1. club 찾아와
		List<Club> list = clubDao.selectClubOldList(map);

		
		// 2. club에 사진 할당해
		for(Club club : list) {
			List<ClubBook> bookList = clubDao.selectClubBook(club.getClubNo());
			club.setBookList(bookList);
		}
		
		return list;
	}

	@Override
	public List<Club> selectClubListMonth(int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		
		// 1. club 찾아와
		List<Club> list = clubDao.selectClubListMonth(rowBounds);
		
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
	public int selectTotalOldClub() {
		return clubDao.selectTotalOldClub();
	}


	@Override
	public int selectTotalClubMonth() {
		return clubDao.selectTotalClubMonth();
	}
	
	@Override
	public Club selectOneClub(Map<String, Object> param) {
		
		// 1. 클럽 찾아와
		Club club = clubDao.selectOneClub(param.get("clubNo"));
		
		
		for(int i = 0; i < club.getBookList().size(); i++) {
			String itemId = club.getBookList().get(i).getItemId();
			Map<String, Object> map = new HashMap<>();
			map.put("itemId", itemId);
			map.put("clubNo", param.get("clubNo"));
			
			// log.debug("여기 clubNo = {}", param.get("clubNo"));
			
			club.getBookList().set(i, clubDao.selectBookMission(map));
			
		}
		
		if(param.get("memberId") != null) {
			club.setIsJoined(clubDao.checkClubJoined(param));
			club.setIsLiked(clubDao.checkClubLiked(param));
			club.setIsWished(clubDao.checkClubWished(param));
		}
		
		// log.debug("2. club = {}", club);
		
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
		
		// 3. pointStatus 내역에 추가하기
		PointStatus ps = new PointStatus();
		ps.setMemberId(String.valueOf(map.get("memberId")));
		ps.setPoint(Integer.parseInt(map.get("deposit").toString()));
		ps.setContent("북클럽 디파짓 차감");
		ps.setStatus("M");
		ps.setTotalPoint(restPoint);
		
		result = clubDao.insertPointStatus(ps);
		
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
		Chat chat = clubDao.selectOneBoardCollection(chatNo);
		chat.setChatComments(clubDao.selectChatComments(chatNo));
		
		log.debug("여기 chat = {}", chat);
		
		return chat;
	}

	@Override
	public List<Chat> selectClubBoardList(Map<String, Object> map) {
		return clubDao.selectClubBoardList(map);
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

	@Override
	public int commentEnroll(ChatComment cc) {
		return clubDao.commentEnroll(cc);
	}

	@Override
	public int commentDelete(int commentNo) {
		return clubDao.commentDelete(commentNo);
	}

	@Override
	public int commentUpdate(ChatComment cc) {
		return clubDao.commentUpdate(cc);
	}

	@Override
	public int commentRefEnroll(ChatComment cc) {
		return clubDao.commentRefEnroll(cc);
	}

	@Override
	public int selectTotalClubBoard(int clubNo) {
		return clubDao.selectTotalClubBoard(clubNo);
	}

	@Override
	public Club selectClubForClubStory(Map<String, Object> map) {
		
		Club club = clubDao.selectOneClub(map);
		List<ClubApplicant> applicantList = clubDao.selectClubApplicants(Integer.parseInt(map.get("clubNo").toString()));
		log.debug("여기 applicantList = {}", applicantList);
		club.setApplicantList(applicantList);
		
		for(int i = 0; i < club.getBookList().size(); i++) {
			String itemId = club.getBookList().get(i).getItemId();
			Map<String, Object> param = new HashMap<>();
			map.put("itemId", itemId);
			map.put("clubNo", map.get("clubNo"));
			
			// log.debug("여기 clubNo = {}", param.get("clubNo"));
			
			club.getBookList().set(i, clubDao.selectBookMission(map));
			
		}
		
		return club;
	}

	@Override
	public List<Mission> getMissionsForOneMember(int clubNo, String memberId) {
		List<Mission> missionList = clubDao.getMissionsForOneMember(clubNo);
		LocalDate now = LocalDate.now();
		
		Map<String, Object> map = new HashMap<>();
		int missionNo;
		for(int i = 0; i < missionList.size(); i++) {
			missionNo = missionList.get(i).getMissionNo();
			map.put("missionNo", missionNo);
			map.put("memberId", memberId);
	
			MissionStatus ms = clubDao.getMissionStatus(map);
			
			log.debug("ms = {}", ms);
			
			// 미션 날짜 검사해
			// 날짜 지났는데 미션 안되어있으면 (ms가 널인경우)
			if(now.isAfter(missionList.get(i).getMendDate()) && ms == null) {
				ms = new MissionStatus();
				ms.setMissionNo(missionNo);
				ms.setMemberId(memberId);
				ms.setStatus("F");
				ms.setClubNo(clubNo);
				log.debug("두번째 ms = {}", ms);
				int result = clubDao.insertFailMissionStatus(ms);
			}
			
			missionList.get(i).setMissionStatus(ms);

		}
		
		
		return missionList;
	}

	@Override
	public int missionStatusUpdate(MissionStatus ms) {
		return clubDao.missionStatusUpdate(ms);
	}
	
	@Override
	public int missionStatusInsert(MissionStatus ms) {
		return clubDao.missionStatusInsert(ms);
	}
	
	@Override
	public MissionStatus selectOneMissionStatus(MissionStatus ms) {
		return clubDao.selectOneMissionStatus(ms);
	}
	
	@Override
	public Club getClubDetailInfo(int clubNo) {
		Club club = clubDao.getClubDetailInfo(clubNo);
		
		List<ClubBook> clubBookList = clubDao.getClubBookList(clubNo);
		club.setBookList(clubBookList);
		
		List<Chat> clubBoardList = clubDao.getFiveRecentClubBoard(clubNo);
		club.setClubBoard(clubBoardList);
		
		List<Member> memberList = clubDao.getClubMemberList(clubNo);
		club.setClubMember(memberList);
		
		return club;
	}
	
	@Override
	public int deleteClub(int clubNo) {
		return clubDao.deleteClub(clubNo);
	}
	
	@Override
	public int cancelClubJoin(Map<String, Object> param) {
		// 먼저 my_club에서 삭제해
		int result = clubDao.cancelClubJoin(param);
		
		// 디파짓 member의 point에 다시 돌려줘
		result = clubDao.refundDeposit(param);
		
		// 방금 업데이트된 멤버의 포인트 가져와
		String memberId = (String) param.get("memberId");
		int myPoint = clubDao.checkMyPoint(memberId);
		
		param.put("totalPoint", myPoint);
		
		// point_status도 북클럽 취소해서 디파짓 환불된 내역 추가해
		result = clubDao.addPointStatusRefundDeposit(param);
		
		return result;
	}

}
