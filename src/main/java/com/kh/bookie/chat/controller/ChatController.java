package com.kh.bookie.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookie.chat.model.dto.ChatLog;
import com.kh.bookie.chat.model.dto.ChatMember;
import com.kh.bookie.chat.model.service.ChatService;
import com.kh.bookie.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	ChatService chatService;
	
	@GetMapping("/clubChat.do/{clubNo}")
	public ModelAndView chat(
			@AuthenticationPrincipal Member member, 
			HttpSession session, 
			ModelAndView mav,
			@PathVariable int clubNo) {
		
		String memberId = member.getMemberId();
		log.debug("memberId = {}", memberId);
		log.debug("clubNo = {}", clubNo);	
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("clubNo", clubNo);
		
		ChatMember chatMember = chatService.findChatMemberByMemberId(map);
		log.debug("chatMember = {}", chatMember);
		String chatroomId = null;
		
		if(chatMember != null) {
			// 기존 채팅방이 존재하는 경우 그거 불러와
			chatroomId = chatMember.getChatroomId();
			
			// 채팅내역 가져오기
			List<ChatLog> chatLogList = chatService.findChatLogByChatroomId(chatroomId);
			
			for(int i = 0; i < chatLogList.size(); i++) {
				long longvalue = chatLogList.get(i).getTime();
				java.util.Date dateValue = new java.util.Date(longvalue);
				chatLogList.get(i).setDateTime(dateValue);
			}
			
			log.debug("chatLogList = {}", chatLogList);
			mav.addObject("chatLogList", chatLogList);
			
			// session속성 unreadCount 제거
			session.removeAttribute("unreadCount");
		}
		else {
			// 채팅방에 처음 입장한 경우 새로운 채팅방을 하나 만들어 줘
			
			// chatroomId 생성
			chatroomId = "chatRoom" + clubNo;
			int result = chatService.createChatroom(chatroomId, clubNo);
		}

		log.debug("chatroomId = {}", chatroomId);
		mav.addObject("chatroomId", chatroomId);
		mav.setViewName("club/clubChat");
		return mav;
	}

	private String getChatroomId(int clubNo) {
		
		final int LEN = 8;
		
		Random rnd = new Random();
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < LEN; i++) {
			if(rnd.nextBoolean()) {
				if(rnd.nextBoolean())
					sb.append((char)(rnd.nextInt(26) + 'A'));
				else
					sb.append((char)(rnd.nextInt(26) + 'a'));
			}
			else {
				sb.append(rnd.nextInt(10));
			}
		}
		
		return sb.toString();
	}
	
	@GetMapping("/getProfileAndNickname.do/{memberId}")
	private ResponseEntity<?> getProfileAndNickname(
			@PathVariable String memberId 
			) {
		
		
		try {
			
			log.debug("memberId = {}", memberId);
			
			Member member = chatService.getProfileAndNickname(memberId);
			
			return ResponseEntity.ok(member);		
			
		} catch(Exception e) {
			log.error("채팅 멤버 프사, 닉넴 불러오기 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
		
	}
}

















