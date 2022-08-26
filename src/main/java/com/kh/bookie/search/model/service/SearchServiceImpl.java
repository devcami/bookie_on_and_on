package com.kh.bookie.search.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.member.model.dto.Follower;
import com.kh.bookie.member.model.dto.Member;
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
		Book book = searchDao.getMyBook(map);
		if(book != null) {
			book.setIngNo(searchDao.selectBookIngNo(map));
		}
		return book;
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
			if(status.equals("읽는 중")) {
				result = searchDao.bookIngEnroll(book);
				break;
			}
			if(status.equals("읽음")) {
				result = searchDao.bookIngUpdate(book);
				break;
			}
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
	
	@Override
	public int moreReadEnroll(Book book) {
		// 완독일 추가 - book_ing에만 새로 추가. book의 상태에는 변경 없다 
		return searchDao.moreReadEnroll(book);
	}
	
	@Override
	public int moreReadDelete(Book book) {
		// 완독일 삭제 - list 가져와서 1개일 경우 book에서도 삭제
		int totalBook = searchDao.totalBook(book);
		if(totalBook == 1) {
			searchDao.bookDelete(book);
		}
		return searchDao.moreReadDelete(book.getIngNo());
	}
	
	@Override
	public int moreReadUpdate(Book book) {
		// 완독일 수정 - book-ing 날짜만 수정
		return searchDao.moreReadUpdate(book);
	}
	
	@Override
	public Member selectOneMember(String memberId) {
		return searchDao.selectOneMember(memberId);
	}
	
	@Override
	public int updateMypick(Book book) {
		return searchDao.updateMypick(book);
	}
	
	@Override
	public List<Member> selectMemberListByInterest(Map<String, Object> map) {
		return searchDao.selectMemberListByInterest(map);
	}
	
	@Override
	public List<Follower> selectFollowerList(String memberId) {
		return searchDao.selectFollowerList(memberId);
	}
	
	@Override
	public int deleteFollower(Map<String, Object> map) {
		return searchDao.deleteFollower(map);
	}
	
	@Override
	public int insertFollower(Map<String, Object> map) {
		return searchDao.insertFollower(map);
	}

	@Override
	public List<String> selectBooKItemIdByStatus(Map<String, Object> param) {
		return searchDao.selectBooKItemIdByStatus(param);
	}

	@Override
	public List<String> selectBooKItemId(Map<String, Object> param) {
		return searchDao.selectBooKItemId(param);
	}

	@Override
	public List<String> selectMyPickItemId(Map<String, Object> param) {
		return searchDao.selectMyPickItemId(param);
	}

	@Override
	public List<String> selectMyBookAllItemId(String memberId) {
		return searchDao.selectMyBookAllItemId(memberId);
	}

	
	
}
