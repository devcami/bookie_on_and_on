package com.kh.bookie.pheed.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bookie.pheed.model.dao.PheedDao;

@Service
public class PheedServiceImpl implements PheedService{
	@Autowired
	private PheedDao pheedDao;
}
