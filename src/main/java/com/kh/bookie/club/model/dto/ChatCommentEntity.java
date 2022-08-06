package com.kh.bookie.club.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatCommentEntity {

	@NonNull
	protected int commentNo;
	@NonNull
	protected int chatNo;
	@NonNull
	protected String nickname;
	
	protected int commentRef;
	
	@NonNull
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDateTime createdAt;
	
	@NonNull
	protected String commentContent;
	
	@NonNull
	protected int commentLevel;
	
}
