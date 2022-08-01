package com.kh.bookie.mypage.model.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Book extends BookEntity {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate startedAt; 
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate endedAt; 
	private int ingNo;
}
