package com.kh.bookie.pheed.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.pheed.model.dto.Pheed;

@Mapper
public interface PheedDao {

	List<Pheed> selectPheedFList();

	List<Pheed> selectPheedCList();
	
}
