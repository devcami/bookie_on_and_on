package com.kh.bookie.club.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Mission {
	
	private int clubNo;
	private int missionNo;
	private String title;
	private String content;
	private int point;
	private String itemId;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate mendDate;
	
	private String imgSrc;
	private MissionStatus missionStatus;
	private String clubTitle;

	
}
