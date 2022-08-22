package com.kh.bookie.mypage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.bookie.member.model.dto.Follower;
import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dto.BookIng;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.pheed.model.dto.Pheed;

@Mapper
public interface MypageDao {

	List<Qna> selectMyQnaList(String memberId);

	int qnaEnroll(Qna qna);

	Qna selectOneQna(int qnaNo);

	List<BookIng> SelectMyBookIngList(String memberId);

	int getFollowers(String memberId);

	int getFollowing(String memberId);

	List<Follower> selectFollowerList(String memberId);

	List<Follower> selectFollowingList(String memberId);
	
	List<Club> selectMyClubList(Map<String, Object> map);

	@Select("select count(*) from my_club where member_id = #{memberId}")
	int selectTotalMyClub(Map<String, Object> map);
	
	List<Pheed> selectMyPheedList(Map<String, Object> map);

	@Select("select count(*) from dokoo where member_id = #{memberId}")
	int selectTotalMyDokoo(String memberId);

	List<Dokoo> selectMyDokooList(Map<String, Object> map);

	List<Dokoo> selectWishMyDokooList(Map<String, Object> map);

	List<Pheed> selectWishMyPheedFList(Map<String, Object> map);

	List<Club> selectMyScrapClubList(Map<String, Object> map);

	@Select("select count(*) from wishlist_club where member_id = #{memberId}")
	int selectTotalMyWishClub(Map<String, Object> map);

	@Select("select count(*) from wishlist_dokoo where member_id = #{memberId}")
	int selectTotalMyWishDokoo(String memberId);

}
