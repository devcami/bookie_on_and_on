package com.kh.bookie.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.mypage.model.dto.QnaComment;

import lombok.NonNull;

public interface AdminService {

	int insertAlarm(Alarm alarm);

	int getUnreadCount(@NonNull String memberId);

	List<Report> selectReportList(int cPage, int numPerPage);
	
	int selectTotalReportContent();

	List<Report> selectReportListByCategory(Map<String, Object> map);

	List<Report> selectReportListByStatus(Map<String, Object> map);

	List<Report> selectReportListByBoth(Map<String, Object> map);

	Report selectOneReport(int reportNo);

	int reportUpdate(Map<String, Object> map);

	List<Qna> selectQnaList(int cPage, int numPerPage);

	int qnaCommentEnroll(QnaComment qnaComment);

	int selectTotalQnaContent();

	List<Qna> selectQnaListByStatus(Map<String, Object> map);

	int selectTotalQnaContentByStatus(String status);

	int selectTotalReportByStatus(String status);

	int selectTotalReportByCategory(String category);

	int selectTotalReportByBoth(Map<String, Object> map);


}
