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
public class ChatComment {

	@NonNull
	private int commentNo;
	@NonNull
	private int chatNo;
	@NonNull
	private String nickname;
	
	private int commentRef;
	
	@NonNull
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDateTime createdAt;
	
	@NonNull
	private String commentContent;
	
	@NonNull
	private int commentLevel;
	
}
