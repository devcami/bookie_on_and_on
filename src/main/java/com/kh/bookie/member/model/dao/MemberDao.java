package com.kh.bookie.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.member.model.dto.Interest;
import com.kh.bookie.member.model.dto.Member;

import lombok.NonNull;

@Mapper
public interface MemberDao {

   Member selectOneMember(String memberId);

   Member selectOneMemberByNickname(String nickname);

   int memberEnroll(Member member);

   int insertAuthority(Map<String, Object> map);

   int insertInterest(Map<String, Object> map);

   int deleteMemberProfile(String memberId);

   int miniUpdateMember(Member logingMember);

   List<Member> selectMemberList();

   List<Member> selectMemberListByInterest(Member member);

   List<Alarm> selectAlarmList(@NonNull String memberId);

   int readAlarm(int alarmNo);

   Member selectPassword(@NonNull String memberId);

   int updatePassword(Map<String, Object> param);

   int deleteMember(String memberId);

   // snsId로 회원정보가져오기 
   @Select("select member_id, email, phone from member where sns_id = #{snsId}")
   Member kakaoSelect(String snsId);

   @Insert("insert into member values (#{memberId}, #{password}, default, #{nickname}, null, null, null, null, null, null, null, default, #{email}, #{snsId})")
   int kakaoInsert(Member member);

   int authorize(Member member); //회원 권한?

   @Select("select member_id from member where sns_id = #{snsId}")
   String findUserIdBySnsId(String snsId);

   Interest selectInterestBymemberId(String memberId);

   int mainUpdateMember(Member newMember);

   int updateInterests(Map<String, Object> param);
   
}
