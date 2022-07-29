package com.kh.bookie.search.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.mypage.model.dto.Book;
import com.kh.bookie.search.model.dao.SearchDao;

import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	private SearchDao searchDao;

	@Override
	public int bookEnroll(Book book) {
		int result = searchDao.bookEnroll(book);
		// status가 읽음, 읽는 중 일때만 book_ing에 추가
		if(book.getStatus().equals("읽음") || book.getStatus().equals("읽는 중")) {
			result = searchDao.bookIngEnroll(book);
		}
		// 중단, 읽고싶은, 잠시 멈춘은 추가 안해
		return result;
	}

	@Override
	public Book getMyBook(Map<String, Object> map) {
		return searchDao.getMyBook(map);
	}
}
