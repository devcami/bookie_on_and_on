package com.kh.bookie.member.model.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.bookie.member.model.dao.MemberDao;
import com.kh.bookie.member.model.dto.Member;

public interface MemberService {
<<<<<<< HEAD
	String ROLE_USER = "ROLE_USER";
	String ROLE_ADMIN = "ROLE_ADMIN";

	int insertMember(Member member);
	
	Member selectOneMember(String memberId);

	int updateMember(Member member);

	List<Member> selectMemberList();

	int updateMemberRole(String memberId, List<String> authorities);
=======
	
	String ROLE_USER = "ROLE_USER";
	String ROLE_ADMIN = "ROLE_ADMIN";
	
	Member selectOneMember(String memberId);

	Member selectOneMemberByNickname(String nickname);

	int memberEnroll(Member member);
>>>>>>> branch 'master' of https://github.com/devcami/bookie_on_and_on.git

}
