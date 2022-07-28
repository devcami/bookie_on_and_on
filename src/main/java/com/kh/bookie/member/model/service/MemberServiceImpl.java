package com.kh.bookie.member.model.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kh.bookie.member.model.dao.MemberDao;
import com.kh.bookie.member.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDao memberDao;

	@Override
	public int insertMember(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Member selectOneMember(String memberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateMember(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}0

	@Override
	public List<Member> selectMemberList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateMemberRole(String memberId, List<String> authorities) {
		// TODO Auto-generated method stub
		return 0;
	}


}
