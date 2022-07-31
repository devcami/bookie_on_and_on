package com.kh.bookie.club.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.bookie.club.model.dto.Chat;
import com.kh.bookie.club.model.dto.ChatAttachment;
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

	Club selectOneClub(Object clubNo);

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

	@Select("select point from member where member_id = #{memberId}")
	int checkMyPoint(String memberId);

	@Select("select count(*) from my_club where club_no = #{clubNo} and member_id = #{memberId}")
	int checkClubJoined(Map<String, Object> param);

	@Insert("insert into my_club values(#{clubNo}, #{memberId}, #{deposit})")
	int joinClub(Map<String, Object> map);

	@Update("update member set point = #{restPoint} where member_id = #{memberId}")
	int updateMyPoint(Map<String, Object> map);

	int insertClubBoard(Chat clubBoard);

	@Insert("insert into chat_attachment values(seq_chat_attachment_no.nextval, #{chatNo}, #{originalFilename}, #{renamedFilename}, sysdate)")
	int insertClubBoardAttachment(ChatAttachment attach);

	Chat selectOneBoardCollection(int chatNo);

	@Select("select * from club_chat where club_no = #{clubNo} order by enroll_date desc")
	List<Chat> selectClubBoardList(int clubNo);

}
