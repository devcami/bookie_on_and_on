package com.kh.bookie.club.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatComment {

	private int commentNo;
	private int chatNo;
	private String nickname;
	private int commentRef;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate createdAt;
	
}
