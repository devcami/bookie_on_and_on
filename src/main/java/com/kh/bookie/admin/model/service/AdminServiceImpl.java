package com.kh.bookie.admin.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.admin.model.dao.AdminDao;
import com.kh.bookie.admin.model.dto.Alarm;

import lombok.NonNull;

@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDao adminDao;
	
	@Override
	public int insertAlarm(Alarm alarm) {
		return adminDao.insertAlarm(alarm);
	}
	
	@Override
	public int getUnreadCount(@NonNull String memberId) {
		return adminDao.getUnreadCount(memberId);
	}
}
