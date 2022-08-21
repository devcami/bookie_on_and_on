package com.kh.bookie.member.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FollowerEntity {
	private String memberId;
	private String followingMemberId;
}
