package com.kh.bookie.mypage.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dao.MypageDao;
import com.kh.bookie.mypage.model.dto.Qna;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	MypageDao mypageDao;
	
	@Override
	public List<Qna> selectMyQnaList(String memberId) {
		return mypageDao.selectMyQnaList(memberId);
	}
	
	@Override
	public int qnaEnroll(Qna qna) {
		return mypageDao.qnaEnroll(qna);
	}
	
	@Override
	public Qna selectOneQna(int qnaNo) {
		return mypageDao.selectOneQna(qnaNo);
	}
}
