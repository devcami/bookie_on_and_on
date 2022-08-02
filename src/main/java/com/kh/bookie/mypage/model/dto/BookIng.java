package com.kh.bookie.mypage.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookIng {
	private int ingNo;
	private String itemId;
	private String memberId;
	private LocalDateTime startedAt;
	private LocalDateTime EndedAt;
}
