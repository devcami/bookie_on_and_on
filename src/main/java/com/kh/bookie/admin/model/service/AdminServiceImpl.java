package com.kh.bookie.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.admin.model.dao.AdminDao;
import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;
import com.kh.bookie.club.model.dto.MissionStatus;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.mypage.model.dto.QnaComment;

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
	public List<Report> selectReportList(int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return adminDao.selectReportList(rowBounds);
	}
	
	@Override
	public int selectTotalReportContent() {
		return adminDao.selectTotalReportContent();
	}
	
	@Override
	public List<Report> selectReportListByCategory(Map<String, Object> map) {
		int cPage = (int) map.get("cPage");
		int numPerPage = (int) map.get("numPerPage");
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		map.put("rowBounds", rowBounds);
		return adminDao.selectReportListByCategory(map);
	}
	
	@Override
	public List<Report> selectReportListByStatus(Map<String, Object> map) {
		int cPage = (int) map.get("cPage");
		int numPerPage = (int) map.get("numPerPage");
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		map.put("rowBounds", rowBounds);
		return adminDao.selectReportListByStatus(map);
	}
	
	@Override
	public List<Report> selectReportListByBoth(Map<String, Object> map) {
		int cPage = (int) map.get("cPage");
		int numPerPage = (int) map.get("numPerPage");
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		map.put("rowBounds", rowBounds);
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
	
	@Override
	public List<Qna> selectQnaList(int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return adminDao.selectQnaList(rowBounds);
	}
	
	@Override
	public int selectTotalQnaContent() {
		return adminDao.selectTotalQnaContent();
	}
	
	@Override
	public List<Qna> selectQnaListByStatus(Map<String, Object> map) {
		int cPage = (int) map.get("cPage");
		int numPerPage = (int) map.get("numPerPage");
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		map.put("rowBounds", rowBounds);
		return adminDao.selectQnaListByStatus(map);
	}
	
	@Override
	public int selectTotalQnaContentByStatus(String status) {
		return adminDao.selectTotalQnaContentByStatus(status);
	}
	
	@Override
	public int qnaCommentEnroll(QnaComment qnaComment) {
		// insert comment
		int result = adminDao.qnaCommentEnroll(qnaComment); 
		// update qna
		result = adminDao.qnaUpdateStatus(qnaComment.getQnaNo());
		return result;
	}
	
	@Override
	public int selectTotalReportByBoth(Map<String, Object> map) {
		return adminDao.selectTotalReportByBoth(map);
	}
	
	@Override
	public int selectTotalReportByCategory(String category) {
		return adminDao.selectTotalReportByCategory(category);
	}
	
	@Override
	public int selectTotalReportByStatus(String status) {
		return adminDao.selectTotalReportByStatus(status);
	}
}
