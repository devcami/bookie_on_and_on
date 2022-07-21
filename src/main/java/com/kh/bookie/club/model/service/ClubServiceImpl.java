package com.kh.bookie.club.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.club.model.dao.ClubDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class ClubServiceImpl implements ClubService {
	
	@Autowired
	private ClubDao clubDao;

}
