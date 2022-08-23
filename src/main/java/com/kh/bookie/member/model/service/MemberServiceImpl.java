package com.kh.bookie.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.member.model.dao.MemberDao;
import com.kh.bookie.member.model.dto.Interest;
import com.kh.bookie.member.model.dto.Member;

import lombok.NonNull;

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
      map.put("interestEnroll", member.getInterestEnroll());
      result = memberDao.insertInterest(map);
      return result;
   }

   @Override
   public int deleteMemberProfile(String memberId) {
      return memberDao.deleteMemberProfile(memberId);
   }

   @Override
   public int miniUpdateMember(Member logingMember) {
      return memberDao.miniUpdateMember(logingMember);
   }
   
   @Override
	public List<Member> selectMemberList() {
		return memberDao.selectMemberList();
	}

   @Override
	public List<Member> selectMemberListByInterest(Member member) {
		return memberDao.selectMemberListByInterest(member);
	}
   
   @Override
	public List<Alarm> selectAlarmList(@NonNull String memberId) {
		return memberDao.selectAlarmList(memberId);
	}
   
   @Override
	public int readAlarm(int alarmNo) {
		return memberDao.readAlarm(alarmNo);
	}

	@Override
	public Member selectPassword(@NonNull String memberId) {
		return memberDao.selectPassword(memberId);
	}
	
	@Override
	public int updatePassword(Map<String, Object> param) {
		return memberDao.updatePassword(param);
	}

	@Override
	public int deleteMember(String memberId) {
		return memberDao.deleteMember(memberId);
	}

	// 카카오 로그인
	@Override
	public Member kakaoLogin(String snsId) {
		return memberDao.kakaoSelect(snsId);
	}
	
	// 카카오 가입
	@Override
	public int KakaoJoin(Member member) {
		int result = memberDao.kakaoInsert(member);
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", member.getMemberId());
		map.put("auth", MemberService.ROLE_USER); // enum or interface에 상수처리
		result = memberDao.insertAuthority(map);
		return result;
	}
	
	@Override
	public String findUserIdBySnsId(String snsId) {
		return memberDao.findUserIdBySnsId(snsId);
	}

	@Override
	public Interest selectInterestBymemberId(String memberId) {
		return memberDao.selectInterestBymemberId(memberId);
	}

	@Override
	public int mainUpdateMember(Member newMember) {
		return memberDao.mainUpdateMember(newMember);
	}

	@Override
	public int updateInterests(Map<String, Object> param) {
		return memberDao.updateInterests(param);
	}
}
