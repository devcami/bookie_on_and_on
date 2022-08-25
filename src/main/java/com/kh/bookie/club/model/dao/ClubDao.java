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
import com.kh.bookie.club.model.dto.ChatComment;
import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubApplicant;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.club.model.dto.Mission;
import com.kh.bookie.club.model.dto.MissionStatus;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.point.model.dto.PointStatus;

@Mapper
public interface ClubDao {

	int enrollClub(Club club);

	@Insert("insert into club_book values (#{clubNo}, #{itemId}, #{imgSrc}, #{bookTitle})")
	int insertClubBook(ClubBook book);

	@Insert("insert into mission values (#{clubNo}, seq_mission_no.nextval, #{title}, #{content}, #{point}, #{mendDate}, #{itemId})")
	int insertMission(Mission mission);

	List<Club> selectClubList(Map<String, Object> map);
	
	List<Club> selectClubOldList(Map<String, Object> map);

	@Select("select count(*) from club where recruit_end > sysdate")
	int selectTotalClub();
	
	@Select("select count(*) from club where club_end < sysdate")
	int selectTotalOldClub();
	
	Club selectOneClub(Object clubNo);

	ClubBook selectBookMission(Map<String, Object> map);

	List<Mission> getMissions(Map<String, Object> param);

	List<ClubBook> selectClubBook(int clubNo);

	@Select("select * from wishlist_club where member_id = #{username}")
	List<String> getClubWishListbyMemberId(String username);

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
	
	@Select("select count(*) from likes_club where club_no = #{clubNo} and member_id = #{memberId}")
	int checkClubLiked(Map<String, Object> param);

	@Select("select count(*) from wishlist_club where club_no = #{clubNo} and member_id = #{memberId}")
	int checkClubWished(Map<String, Object> param);

	@Insert("insert into my_club values(#{clubNo}, #{memberId}, #{deposit}, #{clubEnd}, #{missionCnt}, 'I')")
	int joinClub(Map<String, Object> map);

	@Update("update member set point = #{restPoint} where member_id = #{memberId}")
	int updateMyPoint(Map<String, Object> map);

	int insertClubBoard(Chat clubBoard);

	@Insert("insert into chat_attachment values(seq_chat_attachment_no.nextval, #{chatNo}, #{originalFilename}, #{renamedFilename}, sysdate)")
	int insertClubBoardAttachment(ChatAttachment attach);

	Chat selectOneBoardCollection(int chatNo);

	List<Chat> selectClubBoardList(Map<String, Object> map);
	
	@Select("select * from chat_attachment where chat_no = #{chatNo}")
	List<ChatAttachment> findAllClubBoardAttachByChatNo(int chatNo);

	@Delete("delete from club_chat where chat_no = #{chatNo}")
	int deleteClubBoard(int chatNo);

	@Delete("delete from chat_attachment where attach_no = #{attachNo}")
	int deleteAttachment(int attachNo);

	@Select("select * from chat_attachment where attach_no = #{attachNo}")
	ChatAttachment findOneClubBoardAttachByAttachNo(int attachNo);

	@Update("update club_chat set title = #{title}, content = #{content} where chat_no = #{chatNo}")
	int updateClubBoard(Chat clubBoard);

	@Insert("insert into chat_attachment values (seq_chat_attachment_no.nextval, #{chatNo}, #{originalFilename}, #{renamedFilename}, #{createdAt})")
	int insertClubChatAttach(ChatAttachment attach);

	int commentEnroll(ChatComment cc);

	List<ChatComment> selectChatComments(int chatNo);

	@Delete("delete from chat_comment where comment_no = #{commentNo}")
	int commentDelete(int commentNo);

	@Update("update chat_comment set comment_content = #{commentContent} where comment_no = #{commentNo}")
	int commentUpdate(ChatComment cc);

	int commentRefEnroll(ChatComment cc);

	@Select("select count(*) from club_chat where club_no = #{clubNo}")
	int selectTotalClubBoard(int clubNo);

	@Insert("insert into point_status values (seq_point_no.nextval, #{memberId}, #{content}, #{point}, #{totalPoint}, default, null, #{status})")
	int insertPointStatus(PointStatus ps);

	List<Club> selectClubListMonth(RowBounds rowBounds);

	@Select("select count(*) from club where to_char(club_start, 'MM') = to_char(sysdate, 'MM')")
	int selectTotalClubMonth();

	List<ClubApplicant> selectClubApplicants(int clubNo);

	List<Mission> getMissionsForOneMember(int clubNo);

	@Update("update mission_status set status = #{status}, answer = #{answer}, renamed_filename = #{renamedFilename}, original_filename = #{originalFilename}, updated_at = sysdate where mission_no = #{missionNo} and member_id = #{memberId}")
	int missionStatusUpdate(MissionStatus ms);

	@Insert("insert into mission_status values(#{missionNo}, #{memberId}, #{status}, #{answer}, #{renamedFilename}, #{originalFilename}, sysdate, #{clubNo})")
	int missionStatusInsert(MissionStatus ms);

	@Select("select * from mission_status where mission_no = #{missionNo} and member_id = #{memberId}")
	MissionStatus selectOneMissionStatus(MissionStatus ms);

	@Select("select * from mission_status where mission_no = #{missionNo} and member_id = #{memberId}")
	MissionStatus getMissionStatus(Map<String, Object> map);

	Club getClubDetailInfo(int clubNo);
	
	@Select("select * from (select row_number() over (order by enroll_date desc) rnum, cc.chat_no, cc.nickname, cc.title, cc.enroll_date from club_chat cc where club_no = #{clubNo}) where rnum between 1 and 5")
	List<Chat> getFiveRecentClubBoard(int clubNo);

	@Select("select item_id, img_src, book_title from club_book where club_no = #{clubNo}")
	List<ClubBook> getClubBookList(int clubNo);

	@Select("select m.member_id, m.nickname, m.renamed_filename from my_club mc left join member m on mc.member_id = m.member_id where mc.club_no = #{clubNo}")
	List<Member> getClubMemberList(int clubNo);

	@Insert("insert into mission_status values(#{missionNo}, #{memberId}, #{status}, null, null, null, sysdate, #{clubNo})")
	int insertFailMissionStatus(MissionStatus ms);

	@Delete("delete from club where club_no = #{clubNo}")
	int deleteClub(int clubNo);

	@Delete("delete from my_club where club_no = #{clubNo} and member_id = #{memberId}")
	int cancelClubJoin(Map<String, Object> param);

	@Update("update member set point = point + #{deposit} where member_id = #{memberId}")
	int refundDeposit(Map<String, Object> param);
	
	int addPointStatusRefundDeposit(Map<String, Object> param);




}
