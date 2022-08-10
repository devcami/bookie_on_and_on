package com.kh.bookie.mypage.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaEntity {
	protected int qnaNo;
	protected String memberId;
	protected String title;
	protected String content;
	protected LocalDateTime enrollDate;
	protected String status;
}
