package com.kh.bookie.mypage.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaComment {
	private int commentNo;
	private int qnaNo;
	private String memberId;
	private String commentContent;
	private LocalDateTime createdAt;
}
