package com.kh.bookie.search.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.mypage.model.dto.Book;

@Mapper
public interface SearchDao {

	int bookEnroll(Book book);

	int bookIngEnroll(Book book);

	Book getMyBook(Map<String, Object> map);

}
