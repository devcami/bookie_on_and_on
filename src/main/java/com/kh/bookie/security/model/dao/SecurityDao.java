package com.kh.bookie.security.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.member.model.dto.Member;

@Mapper
public interface SecurityDao {

	Member loadUserByUsername(String username);

}
