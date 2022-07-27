package com.kh.bookie.member.model.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kh.bookie.member.dto.Memberdto;
import com.kh.bookie.member.model.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDao memberDao;

	@Override
	public String loginCheck(Memberdto dto, HttpSession session) {
		String name = memberDao.loginCheck(dto);
		if(name != null) { // 새션 변수 저장
			session.setAttribute("member_id", dto.getUserid());
			 session.setAttribute("name", name);
		}
		return null;
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();// 세션 초기화 
		
	}

}
