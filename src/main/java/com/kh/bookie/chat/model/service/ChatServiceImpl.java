package com.kh.bookie.chat.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.chat.model.dao.ChatDao;
import com.kh.bookie.chat.model.dto.ChatLog;
import com.kh.bookie.chat.model.dto.ChatMember;
import com.kh.bookie.member.model.dto.Member;

@Transactional(rollbackFor = Exception.class)
@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	ChatDao chatDao;

	@Override
	public int createChatroom(String chatroomId, int clubNo) {
		int result = 0;
		
		List<String> chatMemberIdList = chatDao.getClubMemberId(clubNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("clubNo", clubNo);
		map.put("chatroomId", chatroomId);
		
		for(String memberId : chatMemberIdList) {
			map.put("memberId", memberId);
			result = chatDao.insertChatMember(map);
		}
		
		return result;
	}

	@Override
	public ChatMember findChatMemberByMemberId(Map<String, Object> map) {
		return chatDao.findChatMemberByMemberId(map);
	}

	@Override
	public int insertChatLog(Map<String, Object> payload) {
		return chatDao.insertChatLog(payload);
	}

	@Override
	public List<ChatLog> findChatLogByChatroomId(String chatroomId) {
		return chatDao.findChatLogByChatroomId(chatroomId);
	}

	@Override
	public List<ChatLog> findRecentChatLogList() {
		return chatDao.findRecentChatLogList();
	}

	@Override
	public int updateLastCheck(Map<String, Object> payload) {
		return chatDao.updateLastCheck(payload);
	}

	@Override
	public int getUnreadCount(ChatMember chatMember) {
		return chatDao.getUnreadCount(chatMember);
	}

	@Override
	public Member getProfileAndNickname(String memberId) {
		return chatDao.getProfileAndNickname(memberId);
	}
}
