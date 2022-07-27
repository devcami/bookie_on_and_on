package com.kh.bookie.member.model.service;

import javax.servlet.http.HttpSession;

import com.kh.bookie.member.model.dao.MemberDao;

public interface MemberService {
	 public String loginCheck(MemberDao dto, HttpSession session);
	 public void logout(HttpSession session);

}
