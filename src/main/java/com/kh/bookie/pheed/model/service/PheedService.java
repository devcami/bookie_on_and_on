package com.kh.bookie.pheed.model.service;

import java.util.List;

import com.kh.bookie.pheed.model.dto.Pheed;

public interface PheedService {

	List<Pheed> selectPheedFList();

	List<Pheed> selectPheedCList();

}
