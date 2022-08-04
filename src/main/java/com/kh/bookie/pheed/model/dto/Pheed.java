package com.kh.bookie.pheed.model.dto;

import com.kh.bookie.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Pheed extends PheedEntity{
	private PheedAttachment attach;
	Member member;
	private int likesCnt;
	
}
