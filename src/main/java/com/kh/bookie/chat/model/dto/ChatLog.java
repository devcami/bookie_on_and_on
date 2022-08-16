package com.kh.bookie.chat.model.dto;


import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class ChatLog extends ChatLogEntity {
	
	private int unreadCount;
	private Date dateTime;
	
}
