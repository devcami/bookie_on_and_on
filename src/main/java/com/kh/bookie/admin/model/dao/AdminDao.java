package com.kh.bookie.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.bookie.admin.model.dto.Alarm;
import com.kh.bookie.admin.model.dto.Report;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.mypage.model.dto.QnaComment;

import lombok.NonNull;

@Mapper
public interface AdminDao {

	int insertAlarm(Alarm alarm);

	int getUnreadCount(@NonNull String memberId);

	List<Report> selectReportList(RowBounds rowBounds);

	List<Report> selectReportListByCategory(Map<String, Object> map);

	List<Report> selectReportListByStatus(Map<String, Object> map);

	List<Report> selectReportListByBoth(Map<String, Object> map);

	Report selectOneReport(int reportNo);

	int reportUpdate(Map<String, Object> map);

	List<Qna> selectQnaList(RowBounds rowBounds);

	int qnaCommentEnroll(QnaComment qnaComment);

	int qnaUpdateStatus(int qnaNo);

	int selectTotalQnaContent();

	List<Qna> selectQnaListByStatus(Map<String, Object> map);

	int selectTotalQnaContentByStatus(String status);

	int selectTotalReportContent();

	int selectTotalReportByBoth(Map<String, Object> map);

	int selectTotalReportByCategory(String category);

	int selectTotalReportByStatus(String status);

}
