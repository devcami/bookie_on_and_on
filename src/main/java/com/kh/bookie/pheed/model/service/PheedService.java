package com.kh.bookie.pheed.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedComment;

public interface PheedService {

	List<Pheed> selectPheedFList();

	List<Pheed> selectPheedCList(Map<String, Object> map);

	List<PheedComment> selectPheedCommentList(int pheedNo);

	int pheedEnroll(Pheed pheed);

	int report(Map<String, Object> map);

	List<String> getPheedWishListbyMemberId(String username);

	List<String> getPheedLikesListbyMemberId(String username);

	int insertPheedLike(Map<String, Object> map);

	int insertPheedWishList(Map<String, Object> map);

	int deletePheedLike(Map<String, Object> map);

	int deletePheedWishList(Map<String, Object> map);

	int deletePheed(int pheedNo);

	Pheed selectOnePheed(int pheedNo);

}
