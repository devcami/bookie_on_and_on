package com.kh.bookie.member.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.member.model.dao.MemberDao;
import com.kh.bookie.member.model.dto.Member;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao memberDao;

	@Override
	public Member selectOneMember(String memberId) {
		return memberDao.selectOneMember(memberId);
	}
	
	@Override
	public Member selectOneMemberByNickname(String nickname) {
		return memberDao.selectOneMemberByNickname(nickname);
	}
	
	@Override
	public int memberEnroll(Member member) {
		int result = memberDao.memberEnroll(member);
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", member.getMemberId());
		map.put("auth", MemberService.ROLE_USER); // enum or interface에 상수처리
		result = memberDao.insertAuthority(map);
		map.clear();
		map.put("memberId", member.getMemberId());
		map.put("interest", member.getInterests());
		result = memberDao.insertInterest(map);
		return result;
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
	public Member selectInterests(String memberId) {
		return memberDao.selectInterests(memberId);
	}
}
