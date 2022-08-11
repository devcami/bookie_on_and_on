package com.kh.bookie.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.member.model.dto.Member;

import lombok.NonNull;

@Mapper
public interface MemberDao {

   Member selectOneMember(String memberId);

   Member selectOneMemberByNickname(String nickname);

   int memberEnroll(Member member);

   int insertAuthority(Map<String, Object> map);

   int insertInterest(Map<String, Object> map);

   int deleteMemberProfile(String nickname);

   int miniUpdateMember(Member logingMember);

   List<Member> selectMemberList();

   List<Member> selectMemberListByInterest(Member member);

   List<Alarm> selectAlarmList(@NonNull String memberId);

   int readAlarm(int alarmNo);

   Member selectPassword(@NonNull String memberId);

   int updatePassword(Map<String, Object> param);

   int deleteMember(String memberId);

}
