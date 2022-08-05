package com.kh.bookie.point.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.point.model.dao.PointDao;
import com.kh.bookie.point.model.dto.PointStatus;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class PointServiceImpl implements PointService {
	
	@Autowired
	private PointDao pointDao;

	@Override
	public int insertPoint(PointStatus pointStatus) {
		// 일단 pointStatus에 삽입해
		int result = pointDao.insertPoint(pointStatus);
		
		// 현재 해당 멤버의 포인트 가져와
		int nowPoint = pointDao.getMemberPoint(pointStatus.getMemberId());
		
		//해당 멤버의 포인트에서 충전된 내역 더해
		int totalPoint = nowPoint + pointStatus.getPoint();
		
		// 토탈포인트 세팅해
		pointStatus.setTotalPoint(totalPoint);
		
		log.debug("여기 pointStatus = {}", pointStatus);
		
		// 해당멤버의 point_status 테이블의 totalPoint 업데이트해
		result = pointDao.updateTotalPointInPointStatus(pointStatus);
		
		result = pointDao.updateTotalPointInMember(pointStatus);
		
		return result;

	}

	@Override
	public List<PointStatus> getMyPointStatusList(Map<String, Object> map) {
		
		return pointDao.getMyPointStatusList(map);
	}

	

}
