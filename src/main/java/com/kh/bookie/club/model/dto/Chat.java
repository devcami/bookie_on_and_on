package com.kh.bookie.club.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.bookie.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Chat extends ChatEntity {

	private List<ChatAttachment> chatAttachments = new ArrayList<>();
	private Member member;
	private List<ChatComment> chatComments;
	
	public Chat(int chatNo, String nickname, int clubNo, String title, String content, LocalDateTime enrollDate) {
		super(chatNo, nickname, clubNo, title, content, enrollDate);
		// TODO Auto-generated constructor stub
	}
	
	public void addAttachment(@NonNull ChatAttachment attach) {
		// if(attach != null) -> @NonNull이 대신해줌
		chatAttachments.add(attach);
	}
	
	
}
