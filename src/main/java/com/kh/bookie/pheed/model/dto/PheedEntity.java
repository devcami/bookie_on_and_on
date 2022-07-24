package com.kh.bookie.pheed.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PheedEntity {
	protected int pheedNo;
	protected String memberId;
	protected String itemId;
	protected int page;
	protected String content;
	protected String isOpened;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDateTime enrollDate;
}
