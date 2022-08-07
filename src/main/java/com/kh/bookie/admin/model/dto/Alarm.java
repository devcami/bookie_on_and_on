package com.kh.bookie.admin.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Alarm {
	private int alarmNo;
	private String memberId;
	private String alarmContent;
	private int lastCheck;
	private LocalDateTime createdAt;
}
