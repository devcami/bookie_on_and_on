package com.kh.bookie.club.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ClubEntity {
	protected int clubNo;
	protected String title;
	protected String content;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate recruitStart;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate recruitEnd;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate clubStart;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate clubEnd;
	
	protected int bookCount;
	protected int maximumNop;
	protected int minimumNop;
	protected int deposit;
	protected String interest;
	protected String missionCnt;
	
}
