package com.kh.bookie.pheed.model.service;

import java.util.List;

import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedComment;

public interface PheedService {

	List<Pheed> selectPheedFList();

	List<Pheed> selectPheedCList();

	List<PheedComment> selectPheedCommentList(int pheedNo);

}
