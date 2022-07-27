package com.kh.bookie.club.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.Mission;

public interface ClubService {

	int enrollClub(Club club);

	List<Club> selectClubList(int cPage, int numPerPage);

	int selectTotalClub();

	Club selectOneClub(int clubNo);

	List<Mission> getMissions(Map<String, Object> param);

}
