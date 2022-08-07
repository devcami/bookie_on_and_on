package com.kh.bookie.member.model.service;

import java.util.List;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.member.model.dto.Member;

import lombok.NonNull;

public interface MemberService {
   
	String ROLE_USER = "ROLE_USER";
	String ROLE_ADMIN = "ROLE_ADMIN";

	Member selectOneMember(String memberId);

	Member selectOneMemberByNickname(String nickname);

	int memberEnroll(Member member);

	int deleteMemberProfile(String nickname);

	int miniUpdateMember(Member logingMember);

	List<Member> selectMemberList();

	List<Member> selectMemberListByInterest(Member member);

	List<Alarm> selectAlarmList(@NonNull String memberId);

	int readAlarm(int alarmNo);


}