package com.kh.bookie.mypage.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookEntity {
	protected String itemId;
	protected String memberId;
	protected String status;
	protected int score;
	protected String content;
	protected int myPick;
	protected LocalDateTime enrollDate;
}
