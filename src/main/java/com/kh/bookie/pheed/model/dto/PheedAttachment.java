package com.kh.bookie.pheed.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PheedAttachment {
	private int attachNo;
	private int pheedNo;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
}
