package com.kh.bookie.search.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.mypage.model.dto.Book;
import com.kh.bookie.search.model.dao.SearchDao;

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
	
	@Override
	public List<Book> selectReadList(Map<String, Object> map) {
		return searchDao.selectReadList(map);
	}
	
	@Override
	public int bookUpdate(Book book) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", book.getMemberId());
		map.put("itemId", book.getItemId());
		Book beforeBook = searchDao.getMyBook(map); 

		// 일단 book 테이블먼저 바꿔
		int result = searchDao.bookUpdate(book);
		
		// book_ing
		
		String status = book.getStatus();
		switch(beforeBook.getStatus()) {
		case "읽고 싶은" : 
			// 에서 읽음 , 읽고싶은 
			if(status.equals("읽음") || status.equals("읽는 중"))
				result = searchDao.bookIngEnroll(book);
			break;
		case "읽는 중" : 
			// 에서 읽고싶은, 잠시멈춘, 중단 : ing에서 삭제
			if(!status.equals("읽음")) {
				result = searchDao.bookIngDelete(book);
				break;
			}
			// 읽음 : ing에서 수정
			if(status.equals("읽음")) {
				result = searchDao.bookIngUpdate(book);
				break;
			}
		case "읽음" : 
			// 읽는 중
			if(status.equals("읽는 중"))
				result = searchDao.bookIngEnroll(book);
			break;
		case "잠시 멈춘" : 
			// -> 읽음, 읽는 중
			if(status.equals("읽음") || status.equals("읽는 중"))
				result = searchDao.bookIngEnroll(book);
			break;
		case "중단" : 
			if(status.equals("읽음") || status.equals("읽는 중"))
				result = searchDao.bookIngEnroll(book);
			break;
		}
		
		return result; 
	}
	
	@Override
	public int bookDelete(Book book) {
		int totalBook = searchDao.totalBook(book);
		int result = 0;
		// ing 테이블에 행이 하나인경우
		if(totalBook < 2) {
			if(book.getStatus().equals("읽는 중")) {
				result = searchDao.bookIngDelete(book);
			}
			// 책 바로 삭제
			result = searchDao.bookDelete(book);
		} 
		
		// ing 테이블에 행이 두개 이상인 경우
		// 읽는중인 애만 삭제됨
		else {
			// ing에서 현재 no로 행 삭제  
			result = searchDao.bookIngDeleteByNo(book.getIngNo());
			book.setStatus("읽음");
			result = searchDao.bookStatusUpdate(book);
		}
		return result;
	}
}
