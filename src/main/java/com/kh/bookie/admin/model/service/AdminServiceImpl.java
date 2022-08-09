package com.kh.bookie.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.admin.model.dao.AdminDao;
import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;
import com.kh.bookie.club.model.dto.MissionStatus;
import com.kh.bookie.member.model.dto.Member;

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
	
	@Override
	public List<MissionStatus> selectMissionStatusListByAdmin(Map<String, Object> map) {
		return adminDao.selectMissionStatusListByAdmin(map);
	}
	
	@Override
	public int selectTotalMissionByAdmin() {
		return adminDao.selectTotalMissionByAdmin();
	}
	
	@Override
	public int missionAgain(Map<String, Object> map) {
		return adminDao.missionAgain(map);
	}

	@Override
	public int missionPass(Map<String, Object> map) {
		return adminDao.missionPass(map);
	}
	
	@Override
	public List<Report> selectReportList() {
		return adminDao.selectReportList();
	}
	
	@Override
	public List<Report> selectReportListByCategory(String category) {
		return adminDao.selectReportListByCategory(category);
	}
	
	@Override
	public List<Report> selectReportListByStatus(String status) {
		return adminDao.selectReportListByStatus(status);
	}
	
	@Override
	public List<Report> selectReportListByBoth(Map<String, Object> map) {
		return adminDao.selectReportListByBoth(map);
	}
	
	@Override
	public Report selectOneReport(int reportNo) {
		return adminDao.selectOneReport(reportNo);
	}
	
	@Override
	public int reportUpdate(Map<String, Object> map) {
		return adminDao.reportUpdate(map);
	}


}
