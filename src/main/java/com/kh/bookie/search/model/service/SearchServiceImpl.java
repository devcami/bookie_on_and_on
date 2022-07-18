package com.kh.bookie.search.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.search.model.dao.SearchDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	private SearchDao searchDao;

}
