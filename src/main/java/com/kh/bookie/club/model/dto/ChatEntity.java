package com.kh.bookie.club.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ChatEntity {

	protected int chatNo;
	protected String nickname;
	protected int clubNo;
	protected String title;
	protected String content;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDateTime enrollDate;
		
}
