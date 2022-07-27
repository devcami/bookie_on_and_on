package com.kh.bookie.member.model.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.bookie.member.model.dao.MemberDao;
import com.kh.bookie.member.model.dto.Member;

public interface MemberService {
	String ROLE_USER = "ROLE_USER";
	String ROLE_ADMIN = "ROLE_ADMIN";

	int insertMember(Member member);
	
	Member selectOneMember(String memberId);

	int updateMember(Member member);

	List<Member> selectMemberList();

	int updateMemberRole(String memberId, List<String> authorities);

}
