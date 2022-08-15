package com.kh.bookie.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.bookie.chat.model.dto.ChatLog;
import com.kh.bookie.chat.model.dto.ChatMember;
import com.kh.bookie.member.model.dto.Member;

@Mapper
public interface ChatDao {

	@Insert("insert into chat_member (chatroom_id, member_id, club_no) values (#{chatroomId}, #{memberId}, #{clubNo})")
	int insertChatMember(Map<String, Object> map);

	@Select("select * from chat_member where member_id = #{memberId} and club_no = #{clubNo}")
	ChatMember findChatMemberByMemberId(Map<String, Object> map);

	@Insert("insert into chat_log values (seq_chat_log_no.nextval, #{chatroomId}, #{memberId}, #{msg}, #{time}, #{nickname}, #{profile})")
	int insertChatLog(Map<String, Object> payload);

	@Select("select * from chat_log where chatroom_id = #{chatroomId} order by time")
	List<ChatLog> findChatLogByChatroomId(String chatroomId);

	
	List<ChatLog> findRecentChatLogList();

	@Update("update chat_member set last_check = #{lastCheck} where chatroom_id = #{chatroomId} and member_id = #{memberId}")
	int updateLastCheck(Map<String, Object> payload);

	
	int getUnreadCount(ChatMember chatMember);

	@Select("select member_id from my_club where club_no = #{clubNo}")
	List<String> getClubMemberId(int clubNo);

	@Select("select nickname, renamed_filename from member where member_id = #{memberId}")
	Member getProfileAndNickname(String memberId);





	
}
