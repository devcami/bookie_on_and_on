package com.kh.bookie.dokoo.model.dto;

import com.kh.bookie.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Dokoo extends DokooEntity {
	Member member;
}
