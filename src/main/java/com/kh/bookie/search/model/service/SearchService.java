package com.kh.bookie.search.model.service;

import java.util.Map;

import com.kh.bookie.mypage.model.dto.Book;

import lombok.NonNull;

public interface SearchService {

	int bookEnroll(Book book);

	Book getMyBook(Map<String, Object> map);


}
