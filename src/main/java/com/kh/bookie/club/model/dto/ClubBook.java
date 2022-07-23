package com.kh.bookie.club.model.dto;


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
}
