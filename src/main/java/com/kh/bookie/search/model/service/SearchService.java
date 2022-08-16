package com.kh.bookie.search.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.member.model.dto.Follower;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dto.Book;

import lombok.NonNull;

public interface SearchService {

	int bookEnroll(Book book);

	Book getMyBook(Map<String, Object> map);

	int bookUpdate(Book book);

	List<Book> selectReadList(Map<String, Object> map);

	int bookDelete(Book book);

	int moreReadEnroll(Book book);

	int moreReadDelete(Book book);

	int moreReadUpdate(Book book);

	Member selectOneMember(String memberId);

	int updateMypick(Book book);

	List<Member> selectMemberListByInterest(Map<String, Object> map);

	List<Follower> selectFollowerList(String memberId);

	int insertFollower(Map<String, Object> map);

	int deleteFollower(Map<String, Object> map);

	List<String> selectBooKItemIdByStatus(Map<String, Object> param);

	List<String> selectBooKItemId(Map<String, Object> param);

	List<String> selectMyPickItemId(Map<String, Object> param);

	List<String> selectMyBookAllItemId(String memberId);


}
