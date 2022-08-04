package com.kh.bookie.point.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.point.model.dao.PointDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class PointServiceImpl implements PointService {
	
	@Autowired
	private PointDao pointDao;

	

}
