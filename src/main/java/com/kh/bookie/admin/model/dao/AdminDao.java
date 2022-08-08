package com.kh.bookie.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;

import lombok.NonNull;

@Mapper
public interface AdminDao {

	int insertAlarm(Alarm alarm);

	int getUnreadCount(@NonNull String memberId);

	List<Report> selectReportList();

	List<Report> selectReportListByCategory(String category);

	List<Report> selectReportListByStatus(String status);

	List<Report> selectReportListByBoth(Map<String, Object> map);

	Report selectOneReport(int reportNo);

	int reportUpdate(Map<String, Object> map);

}
