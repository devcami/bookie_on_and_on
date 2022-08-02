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
@AllArgsConstructor
@ToString
@Builder
public class DokooComment {
	@NonNull
	private int dokooCNo;
	@NonNull
	private int dokooNo;
	@NonNull
	private String nickname;
	@NonNull
	private String content;
	private int commentRef;
	private int commentLevel;
	@NonNull
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDateTime createdAt;
	
}
