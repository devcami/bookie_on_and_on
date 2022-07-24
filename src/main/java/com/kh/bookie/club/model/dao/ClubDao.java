package com.kh.bookie.club.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.club.model.dto.Mission;

@Mapper
public interface ClubDao {

	int enrollClub(Club club);

	@Insert("insert into club_book values (#{clubNo}, #{itemId}, #{imgSrc})")
	int insertClubBook(ClubBook book);

	@Insert("insert into mission values (#{clubNo}, seq_mission_no.nextval, #{title}, #{content}, #{point}, #{mEndDate}, #{itemId})")
	int insertMission(Mission mission);

	List<Club> selectClubList(RowBounds rowBounds);

}
