package com.kh.bookie.dokoo.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.dokoo.model.dao.DokooDao;
import com.kh.bookie.dokoo.model.dto.Dokoo;

@Service
@Transactional(rollbackFor = Exception.class)
public class DokooServiceImpl implements DokooService {

	@Autowired
	DokooDao dokooDao;
	
	@Override
	public List<Dokoo> selectDokooList() {
		return dokooDao.selectDokooList();
	}
}
