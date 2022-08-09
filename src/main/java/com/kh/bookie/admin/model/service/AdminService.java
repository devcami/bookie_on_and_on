package com.kh.bookie.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;
import com.kh.bookie.club.model.dto.MissionStatus;

import lombok.NonNull;

public interface AdminService {

	int insertAlarm(Alarm alarm);

	int getUnreadCount(@NonNull String memberId);
	
	List<MissionStatus> selectMissionStatusListByAdmin(Map<String, Object> map);
	
	int selectTotalMissionByAdmin();
	
	int missionAgain(Map<String, Object> map);

	int missionPass(Map<String, Object> map);

	List<Report> selectReportList();

	List<Report> selectReportListByCategory(String category);

	List<Report> selectReportListByStatus(String status);

	List<Report> selectReportListByBoth(Map<String, Object> map);

	Report selectOneReport(int reportNo);

	int reportUpdate(Map<String, Object> map);




}
