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

	List<Pheed> selectPheedFList(Map<String, Object> map);

	List<Pheed> selectPheedCList(Map<String, Object> map);
	
	List<Pheed> selectMyPheedList(Map<String, Object> map);

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
	
	@Select("select * from pheed_attachment where attach_no = #{attachNo}")
	PheedAttachment selectOnePheedAttachment(int attachNo);

	@Delete("delete from pheed_attachment where attach_no = #{attachNo}")
	int deleteAttachment(int attachNo);

	int pheedUpdate(Pheed pheed);

	@Delete("delete from pheed where pheed_no = #{pheedNo}")
	int deletePheed(int pheedNo);

	Pheed selectOnePheed(int pheedNo);

	int commentEnroll(PheedComment pc);

	int commentDel(int pheedCNo);

	int commentUpdate(PheedComment pheedComment);

	int commentRefEnroll(PheedComment pc);

	@Select("select * from pheed_comment where pheedc_no = #{pheedCNo}")
	PheedComment selectOnePheedComment(int pheedCNo);

	@Delete("delete from likes_pheed where pheed_no = #{pheedNo}")
	int deletePheedLikes(int pheedNo);

	@Delete("delete from wishlist_pheed where pheed_no = #{pheedNo}")
	int deletePheedWishlists(int pheedNo);

	List<Pheed> getMyPheedWishList(Map<String, Object> map);
	

}
