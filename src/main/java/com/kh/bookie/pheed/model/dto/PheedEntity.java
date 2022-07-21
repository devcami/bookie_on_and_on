package com.kh.bookie.pheed.model.dto;

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
}
