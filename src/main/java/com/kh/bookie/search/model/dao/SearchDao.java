package com.kh.bookie.search.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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

}
