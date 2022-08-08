package com.kh.bookie.admin.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report {
	private int reportNo;
	private String memberId;
	private String category;
	private int beenziNo; //해당 글 번호
	private String status;
	private String content;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
}
