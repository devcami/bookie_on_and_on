package com.kh.bookie.dokoo.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
@AllArgsConstructor
@Builder
public class DokooEntity {
	@NonNull
	protected int dokooNo;
	@NonNull
	protected String memberId;
	@NonNull
	protected String itemId;
	@NonNull
	protected String title;
	@NonNull
	protected String content;
	@NonNull
	protected String isOpened;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDateTime enrollDate;
}
