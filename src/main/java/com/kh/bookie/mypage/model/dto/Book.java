package com.kh.bookie.mypage.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {
	private String itemId;
	private String memberId;
	private String status;
	private int score;
	private String content;
	private int my_pick;
}
