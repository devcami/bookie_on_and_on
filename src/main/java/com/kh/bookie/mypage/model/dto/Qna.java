package com.kh.bookie.mypage.model.dto;

import java.util.ArrayList;
import java.util.List;

import com.kh.bookie.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Qna extends QnaEntity {
	Member member;
	List<QnaComment> qnaCommentList = new ArrayList<>();
}
