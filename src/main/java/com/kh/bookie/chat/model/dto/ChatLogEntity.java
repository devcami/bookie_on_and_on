package com.kh.bookie.chat.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatLogEntity {
	
	protected int no;
	protected String chatroomId;
	protected String memberId;
	protected String msg;
	protected long time;
	
	protected String nickname;
	protected String renamedFilename;
	
}
