package com.kh.bookie.point.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.club.model.dto.MyClub;
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
		
		// 먼저 내가 가입한 클럽에서 club_status가 I(진행중)이면서 club_end가 오늘보다 이전인 클럽 가져와
		List<MyClub> myClubs = pointDao.getMyClubStatus(map);
		
		if(!myClubs.isEmpty()) {
			
			for(int i = 0; i < myClubs.size(); i++) {
				MyClub myClub = myClubs.get(i);
				
				// 해당 클럽 미션중에서 내가 통과한 미션(status='P') 몇개인지 알아내
				int passMissionCnt = pointDao.getTotalPassMission(myClub);
				
				// 미션별 포인트 계산해 
				int missionPoint = myClub.getDeposit() / myClub.getMissionCnt();
				
				// 내가 받는 포인트 계산해 (미션별 포인트 * 내가 통과한 미션 수)
				int getBackPoint = passMissionCnt * missionPoint;
				
				// 현재 해당 멤버의 포인트 가져와
				int nowPoint = pointDao.getMemberPoint(myClub.getMemberId());
				
				//해당 멤버의 포인트에서 북클럽 포인트 환급된거 더해
				int totalPoint = nowPoint + getBackPoint;
				
				log.debug("myClub = {}", myClub);
				log.debug("passMissionCnt = {}", passMissionCnt);
				log.debug("missionPoint = {}", missionPoint);
				log.debug("getBackPoint = {}", getBackPoint);
				log.debug("nowPoint = {}", nowPoint);
				log.debug("totalPoint = {}", totalPoint);
				
				// 토탈포인트 세팅해
				PointStatus ps = new PointStatus();
				ps.setContent("북클럽 포인트 환급");
				ps.setMemberId(myClub.getMemberId());
				ps.setStatus("P");
				ps.setTotalPoint(totalPoint);
				ps.setPoint(getBackPoint);
				
				// point_status에 북클럽 포인트 환급 내역으로 삽입해
				int result = pointDao.insertClubEndpoint(ps);
				
				// 포인트 환급까지 다 끝냈으니 my_club 상태 'E'로 바꿔. 
				result = pointDao.updateMyClubStatus(myClub);
				
			}
				
		}
		
		List<PointStatus> ps = pointDao.getMyPointStatusList(map); 
		return ps;
	}

	

}
