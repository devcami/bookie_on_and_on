package com.kh.bookie.mypage.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dto.Qna;

@Mapper
public interface MypageDao {

	List<Qna> selectMyQnaList(String memberId);

	int qnaEnroll(Qna qna);

	Qna selectOneQna(int qnaNo);

}
