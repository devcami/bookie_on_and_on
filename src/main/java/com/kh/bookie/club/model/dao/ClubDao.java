package com.kh.bookie.club.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.club.model.dto.Mission;

@Mapper
public interface ClubDao {

	int enrollClub(Club club);

	@Insert("insert into club_book values (#{clubNo}, #{itemId}, #{imgSrc}, #{bookTitle})")
	int insertClubBook(ClubBook book);

	@Insert("insert into mission values (#{clubNo}, seq_mission_no.nextval, #{title}, #{content}, #{point}, #{mendDate}, #{itemId})")
	int insertMission(Mission mission);

	List<Club> selectClubList(RowBounds rowBounds);

	@Select("select count(*) from club")
	int selectTotalClub();

	Club selectOneClub(int clubNo);

	ClubBook selectBookMission(Map<String, Object> map);

	List<Mission> getMissions(Map<String, Object> param);

}
