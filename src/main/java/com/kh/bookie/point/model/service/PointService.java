package com.kh.bookie.point.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.point.model.dto.PointStatus;

public interface PointService {

	int insertPoint(PointStatus pointStatus);

	List<PointStatus> getMyPointStatusList(Map<String, Object> map);

	List<List<PointStatus>> getMyPointStatusListTemp(String memberId);

	

}
