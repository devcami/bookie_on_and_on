package com.kh.bookie.pheed.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedAttachment;
import com.kh.bookie.pheed.model.dto.PheedComment;

public interface PheedService {

	List<Pheed> selectPheedFList(Map<String, Object> map);

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

	PheedAttachment selectOnePheedAttachment(int attachNo);

	int deleteAttachment(int attachNo);

	int pheedUpdate(Pheed pheed);

	int commentEnroll(PheedComment pc);

	int commentDel(int pheedCNo);

	int commentUpdate(PheedComment pheedComment);

	int commentRefEnroll(PheedComment pc);

	PheedComment selectOnePheedComment(int pheedCNo);

	List<Pheed> selectMyPheedList(Map<String, Object> map);

	List<Pheed> getMyPheedWishList(Map<String, Object> map);

}
