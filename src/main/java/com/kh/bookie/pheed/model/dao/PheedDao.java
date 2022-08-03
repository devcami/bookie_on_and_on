package com.kh.bookie.pheed.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedAttachment;
import com.kh.bookie.pheed.model.dto.PheedComment;

@Mapper
public interface PheedDao {

	List<Pheed> selectPheedFList();

	List<Pheed> selectPheedCList(Map<String, Object> map);

	PheedAttachment selectAttachment(int pheedNo);

	Member selectMember(String memberId);

	List<PheedComment> selectPheedCommentList(int pheedNo);

	int pheedEnroll(Pheed pheed);

	int pheedAttachmentEnroll(PheedAttachment attach);

	int report(Map<String, Object> map);

	@Select("select * from likes_pheed where member_id = #{username}")
	List<String> getPheedLikesListbyMemberId(String username);

	@Select("select * from wishlist_pheed where member_id = #{username}")
	List<String> getPheedWishListbyMemberId(String username);

	@Insert("insert into likes_pheed values (#{pheedNo}, #{memberId})")
	int insertPheedLike(Map<String, Object> map);

	@Insert("insert into wishlist_pheed values (#{pheedNo}, #{memberId})")
	int insertPheedWishList(Map<String, Object> map);

	@Delete("delete from likes_pheed where pheed_no = #{pheedNo} and member_id = #{memberId}")	
	int deletePheedLike(Map<String, Object> map);

	@Delete("delete from wishlist_pheed where pheed_no = #{pheedNo} and member_id = #{memberId}")	
	int deletePheedWishList(Map<String, Object> map);
	
}
