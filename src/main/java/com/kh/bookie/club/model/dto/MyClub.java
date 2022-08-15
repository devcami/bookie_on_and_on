package com.kh.bookie.club.model.dto;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.kh.bookie.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class MyClub {
	
	private int clubNo;
	private String memberId;
	private int deposit;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate clubEnd;
	
	private int missionCnt;
	private String clubStatus;
}
