package com.kh.bookie.search.model.service;

import java.util.List;
import java.util.Map;

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


}
