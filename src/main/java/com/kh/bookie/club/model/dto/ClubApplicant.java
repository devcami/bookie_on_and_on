package com.kh.bookie.club.model.dto;

import com.kh.bookie.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class ClubApplicant {
	
	private int clubNo;
	private String memberId;
	private int deposit;
	private String renamedFilename;
	private String nickname;
	private String introduce;
	
}
