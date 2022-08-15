package com.kh.bookie.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.chat.model.dto.ChatLog;
import com.kh.bookie.chat.model.dto.ChatMember;
import com.kh.bookie.member.model.dto.Member;

public interface ChatService {

	int createChatroom(String chatroomId, int clubNo);

	ChatMember findChatMemberByMemberId(Map<String, Object> map);

	int insertChatLog(Map<String, Object> payload);

	List<ChatLog> findChatLogByChatroomId(String chatroomId);

	List<ChatLog> findRecentChatLogList();

	int updateLastCheck(Map<String, Object> payload);

	int getUnreadCount(ChatMember chatMember);

	Member getProfileAndNickname(String memberId);

}
