package com.kh.bookie.pheed.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bookie.pheed.model.dao.PheedDao;
import com.kh.bookie.pheed.model.dto.Pheed;

@Service
public class PheedServiceImpl implements PheedService{
	@Autowired
	private PheedDao pheedDao;
	
	@Override
	public List<Pheed> selectPheedFList() {
		return pheedDao.selectPheedFList();
	}
	
	@Override
	public List<Pheed> selectPheedCList() {
		return pheedDao.selectPheedCList();
	}
}
