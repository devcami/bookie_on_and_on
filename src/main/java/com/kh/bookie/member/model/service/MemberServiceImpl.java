package com.kh.bookie.member.model.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kh.bookie.member.model.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDao memberDao;


}
