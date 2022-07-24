package com.kh.bookie.club.model.service;

import java.util.List;

import com.kh.bookie.club.model.dto.Club;

public interface ClubService {

	int enrollClub(Club club);

	List<Club> selectClubList(int cPage, int numPerPage);

}
