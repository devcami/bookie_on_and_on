package com.kh.bookie.ws;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class EchoHandler extends TextWebSocketHandler {
	
	// multithreading 환경에서 동기화를 지원하는 ArrayList
	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
	
	
	public void log(String status) {
		log.debug("[{}] 현재 세션 수 : {}", status, sessions.size());
	}
	
	/**
	 * 오픈 시 호출되는 메소드
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		log("open");
	}

	/**
	 * message
	 */
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug("[message] {} : {}", session.getId(), message.getPayload());
		for(WebSocketSession sess : sessions) {
			sess.sendMessage(message);
		}
	}
	
	/**
	 * close 시 호출되는 메소드
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
		log("close");
	}
	
}
