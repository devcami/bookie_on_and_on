package com.kh.bookie.club.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
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

	List<ClubBook> selectClubBook(int clubNo);

	@Select("select * from wishlist_club where member_id = #{username}")
	List<String> getgetClubWishListbyMemberId(String username);

	@Select("select * from likes_club where member_id = #{username}")
	List<String> getClubLikesListbyMemberId(String username);

	@Insert("insert into likes_club values (#{clubNo}, #{memberId})")
	int insertClubLike(Map<String, Object> map);

	@Insert("insert into wishlist_club values (#{clubNo}, #{memberId})")
	int insertClubWishList(Map<String, Object> map);

	@Delete("delete from likes_club where club_no = #{clubNo} and member_id = #{memberId}")
	int deleteClubLike(Map<String, Object> map);

	@Delete("delete from wishList_club where club_no = #{clubNo} and member_id = #{memberId}")
	int deleteClubWishList(Map<String, Object> map);

}
