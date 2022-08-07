package com.kh.bookie.ws;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.kh.bookie.ws.payload.Payload;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class StompController {

	
	/**
	 * 사용자가 /app/def로 메세지를 전송한 경우
	 * 
	 * /topic/abc 구독자에게 메세지 전송 (SimpleBroker)
	 *  
	 */
	@MessageMapping("/def")
	@SendTo("/app/def")
	public String app(String msg) {
		log.debug("/app/def : {}", msg);
		return msg;
	}
	
	/**
	 * 전체전송
	 * @param payload
	 * @return
	 */
	@MessageMapping("/admin/notice")
	@SendTo("/app/notice")
	public Payload adminNotice(Payload payload) {
		log.debug("payload = {}", payload);
		
		return payload;
	}
	
	/**
	 * 개별전송
	 */
	@MessageMapping("/admin/notice/{memberId}")
	@SendTo("/app/notice/{memberId}")
	public Payload adminNotice(Payload payload, @DestinationVariable String memberId) {
		log.debug("memberId = {}", memberId);
		log.debug("payload = {}", payload);
		return payload;
	}
	
}
