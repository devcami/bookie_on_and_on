package com.kh.bookie.club.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MissionStatus {
	
	private int missionNo;
	private String memberId;
	private String status;
	private String answer;
	private String renamedFilename;
	private String originalFilename;
	
	
}
