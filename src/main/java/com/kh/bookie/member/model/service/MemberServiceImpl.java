package com.kh.bookie.member.model.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.member.model.dao.MemberDao;
import com.kh.bookie.member.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDao memberDao;



	@Override
	public Member selectOneMember(String memberId) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override

	public int deleteMemberProfile(String nickname) {
		return memberDao.deleteMemberProfile(nickname);
	}

	@Override
	public int miniUpdateMember(Member logingMember) {
		return memberDao.miniUpdateMember(logingMember);
	}

	
	@Override
	public Member selectOneMemberByNickname(String nickname) {
		// TODO Auto-generated method stub
		return null;
	}
	//구현체 회원가입 
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int memberEnroll(Member member) {
		int result = memberDao. memberEnroll(member);
		result = memberDao.insertAuthority(member); // ROLE_USER
		return result;
	}

	@Override
	public Member selectOneMemberByTel(String telNum) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public List<Member> selectMemberList(){
		return memberDao.selectMemberList;
		
	}

}
