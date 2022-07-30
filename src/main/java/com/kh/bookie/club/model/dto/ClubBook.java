package com.kh.bookie.club.model.dto;


import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ClubBook {
	
	private int clubNo;
	private String itemId;
	private String imgSrc;
	private String bookTitle;
	private List<Mission> missionList = new ArrayList<>();
}
