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
public class PheedComment {
	@NonNull
	private int pheedCNo;
	@NonNull
	private int pheedNo;
	@NonNull
	private String nickname;
	@NonNull
	private String content;
	private int commentRef;
	@NonNull
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDateTime createdAt;
	
}
