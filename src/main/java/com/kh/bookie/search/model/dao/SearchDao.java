package com.kh.bookie.search.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.member.model.dto.Follower;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dto.Book;

@Mapper
public interface SearchDao {

	int bookEnroll(Book book);

	int bookIngEnroll(Book book);

	Book getMyBook(Map<String, Object> map);

	int bookUpdate(Book book);

	int bookIngUpdate(Book book);

	int bookIngDelete(Book book);

	List<Book> selectReadList(Map<String, Object> map);

	int bookDelete(Book book);

	int totalBook(Book book);

	int recentBookIngDelete(Book book);

	int bookStatusUpdate(Book book);

	int bookIngDeleteByNo(int ingNo);

	int moreReadEnroll(Book book);

	int moreReadDelete(int ingNo);

	int moreReadUpdate(Book book);

	Member selectOneMember(String memberId);

	int updateMypick(Book book);

	List<Member> selectMemberListByInterest(Map<String, Object> map);

	List<Follower> selectFollowerList(String memberId);

	int deleteFollower(Map<String, Object> map);

	int insertFollower(Map<String, Object> map);

	List<String> selectBooKItemIdByStatus(Map<String, Object> param);

	List<String> selectBooKItemId(Map<String, Object> param);

	List<String> selectMyPickItemId(Map<String, Object> param);

	List<String> selectMyBookAllItemId(String memberId);

	int selectBookIngNo(Map<String, Object> map);

}
