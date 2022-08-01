package com.kh.bookie.club.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Chat extends ChatEntity {

	protected List<ChatAttachment> chatAttachments = new ArrayList<>();

	public Chat(int chatNo, String nickname, int clubNo, String title, String content, LocalDate enrollDate) {
		super(chatNo, nickname, clubNo, title, content, enrollDate);
		// TODO Auto-generated constructor stub
	}
	
	public void addAttachment(@NonNull ChatAttachment attach) {
		// if(attach != null) -> @NonNull이 대신해줌
		chatAttachments.add(attach);
	}
	
	
}
