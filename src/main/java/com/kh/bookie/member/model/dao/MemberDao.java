package com.kh.bookie.member.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.member.model.dto.Member;

@Mapper
public interface MemberDao {

	Member selectOneMember(String memberId);

	Member selectOneMemberByNickname(String nickname);

	int memberEnroll(Member member);

	int insertAuthority(Map<String, Object> map);

	int insertInterest(Map<String, Object> map);

	int deleteMemberProfile(String nickname);

	int miniUpdateMember(Member logingMember);

}
