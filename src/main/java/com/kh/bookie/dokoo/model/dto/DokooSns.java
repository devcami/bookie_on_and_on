package com.kh.bookie.dokoo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DokooSns {
	private int dokooNo;
	private String memberId;
	private SnsType snsType;
}
