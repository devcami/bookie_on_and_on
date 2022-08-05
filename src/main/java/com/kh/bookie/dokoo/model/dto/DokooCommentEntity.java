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
public class DokooCommentEntity {
	@NonNull
	protected int dokooCNo;
	@NonNull
	protected int dokooNo;
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
