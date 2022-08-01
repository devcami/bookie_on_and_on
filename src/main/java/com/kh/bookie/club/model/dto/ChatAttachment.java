package com.kh.bookie.club.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ChatAttachment {

	private int attachNo;
	private int chatNo;
	private String originalFilename;
	private String renamedFilename;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate createdAt;
}
