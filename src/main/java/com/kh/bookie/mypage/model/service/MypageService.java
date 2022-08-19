package com.kh.bookie.mypage.model.service;

import java.util.List;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dto.BookIng;
import com.kh.bookie.mypage.model.dto.Qna;

public interface MypageService {

	List<Qna> selectMyQnaList(String memberId);

	int qnaEnroll(Qna qna);

	Qna selectOneQna(int qnaNo);

	List<BookIng> SelectMyBookIngList(String memberId);

}
