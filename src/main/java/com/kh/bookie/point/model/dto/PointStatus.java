package com.kh.bookie.point.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PointStatus {

	private int pointNo;
	private String memberId;
	private String content;
	private int point;
	private int totalPoint;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDateTime updatedAt;
	private String impUid;
	private String status;
	
}
