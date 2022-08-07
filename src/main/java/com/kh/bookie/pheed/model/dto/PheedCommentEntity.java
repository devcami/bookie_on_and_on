package com.kh.bookie.pheed.model.dto;

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
@AllArgsConstructor
@ToString
@Builder
public class PheedCommentEntity {
	@NonNull
	protected int pheedCNo;
	@NonNull
	protected int pheedNo;
	@NonNull
	protected String nickname;
	@NonNull
	protected String content;
	protected int commentRef;
	protected int commentLevel;
	@NonNull
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDateTime createdAt;
	
}
