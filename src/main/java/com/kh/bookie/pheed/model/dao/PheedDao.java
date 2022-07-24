package com.kh.bookie.pheed.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedAttachment;
import com.kh.bookie.pheed.model.dto.PheedComment;

@Mapper
public interface PheedDao {

	List<Pheed> selectPheedFList();

	List<Pheed> selectPheedCList();

	PheedAttachment selectAttachment(int pheedNo);

	Member selectMember(String memberId);

	List<PheedComment> selectPheedCommentList(int pheedNo);
	
}
