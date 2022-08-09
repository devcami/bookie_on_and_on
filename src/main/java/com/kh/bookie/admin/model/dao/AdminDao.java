package com.kh.bookie.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;
import com.kh.bookie.club.model.dto.MissionStatus;

import lombok.NonNull;

@Mapper
public interface AdminDao {

	int insertAlarm(Alarm alarm);

	int getUnreadCount(@NonNull String memberId);
	
	List<MissionStatus> selectMissionStatusListByAdmin(Map<String, Object> map);

	@Select("select count(*) from mission_status where status = 'I'")
	int selectTotalMissionByAdmin();
	
	@Update("update mission_status set status = 'A' where mission_no = #{missionNo} and member_id = #{memberId}")
	int missionAgain(Map<String, Object> map);

	@Update("update mission_status set status = 'P' where mission_no = #{missionNo} and member_id = #{memberId}")
	int missionPass(Map<String, Object> map);

	List<Report> selectReportList();

	List<Report> selectReportListByCategory(String category);

	List<Report> selectReportListByStatus(String status);

	List<Report> selectReportListByBoth(Map<String, Object> map);

	Report selectOneReport(int reportNo);

	int reportUpdate(Map<String, Object> map);

	

}
