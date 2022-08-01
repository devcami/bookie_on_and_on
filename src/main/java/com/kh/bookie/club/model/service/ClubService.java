package com.kh.bookie.club.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.club.model.dto.Chat;
import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.Mission;

public interface ClubService {

	int enrollClub(Club club);

	List<Club> selectClubList(int cPage, int numPerPage);

	int selectTotalClub();

	Club selectOneClub(Map<String, Object> param);

	List<Mission> getMissions(Map<String, Object> param);

	List<String> getClubWishListbyMemberId(String username);

	List<String> getClubLikesListbyMemberId(String username);

	int insertClubLike(Map<String, Object> map);

	int insertClubWishList(Map<String, Object> map);

	int deleteClubLike(Map<String, Object> map);

	int deleteClubWishList(Map<String, Object> map);

	int checkMyPoint(String memberId);

	int joinClub(Map<String, Object> map);

	int insertClubBoard(Chat clubBoard);

	Chat selectOneBoardCollection(int chatNo);

	List<Chat> selectClubBoardList(int clubNo);

}
