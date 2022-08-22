package com.kh.bookie.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.member.model.dto.Interest;
import com.kh.bookie.member.model.dto.Member;

import lombok.NonNull;

public interface MemberService {
   
	String ROLE_USER = "ROLE_USER";
	String ROLE_ADMIN = "ROLE_ADMIN";

	Member selectOneMember(String memberId);

	Member selectOneMemberByNickname(String nickname);

	int memberEnroll(Member member);

	int deleteMemberProfile(String memberId);

	int miniUpdateMember(Member logingMember);

	List<Member> selectMemberList();

	List<Member> selectMemberListByInterest(Member member);

	List<Alarm> selectAlarmList(@NonNull String memberId);

	int readAlarm(int alarmNo);

	Member selectPassword(@NonNull String memberId);

	int updatePassword(Map<String, Object> param);

	int deleteMember(String memberId);

	Member kakaoLogin(String snsId);

	int KakaoJoin(Member member);

	String findUserIdBySnsId(String snsId);

	Interest selectInterestBymemberId(String memberId);

	int mainUpdateMember(Member newMember);

	int updateInterests(Map<String, Object> param);

}