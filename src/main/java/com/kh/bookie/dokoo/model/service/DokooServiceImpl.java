package com.kh.bookie.dokoo.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.dokoo.model.dao.DokooDao;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;
import com.kh.bookie.dokoo.model.dto.DokooSns;
import com.kh.bookie.dokoo.model.dto.SnsType;
import com.kh.bookie.mypage.model.dto.Book;

@Service
@Transactional(rollbackFor = Exception.class)
public class DokooServiceImpl implements DokooService {

	@Autowired
	DokooDao dokooDao;
	
	@Override
	public List<Dokoo> selectDokooList(int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return dokooDao.selectDokooList(rowBounds);
	}
	
	@Override
	public int selectTotalContent() {
		return dokooDao.selectTotalContent();
	}
	
	@Override
	public Dokoo selectOneDokoo(int dokooNo) {
		Dokoo dokoo = dokooDao.selectOneDokoo(dokooNo); 
		dokoo.setDokooComments(dokooDao.selectDokooComments(dokooNo));
		return dokoo;
	}
	
	@Override
	public List<Book> getReadBookList(String memberId) {
		return dokooDao.getReadBookList(memberId);
	}
	
	@Override
	public int dokooEnroll(Dokoo dokoo) {
		return dokooDao.dokooEnroll(dokoo);
	}
	
	@Override
	public int commentEnroll(DokooComment dc) {
		return dokooDao.commentEnroll(dc);
	}
	
	@Override
	public int commentDel(int dokooCNo) {
		return dokooDao.commentDel(dokooCNo);
	}
	
	@Override
	public int commentUpdate(DokooComment dokooComment) {
		return dokooDao.commentUpdate(dokooComment);
	}
	
	@Override
	public List<DokooSns> getDokooSns(Map<String, Object> map) {
		List<DokooSns> dokooSnsList = new ArrayList<>();
		List<DokooSns> dokooSnsLikes = dokooDao.getDokooLikes(map);
		for(DokooSns dokooSnsLike : dokooSnsLikes) {
			dokooSnsLike.setSnsType(SnsType.LIKE);
			dokooSnsList.add(dokooSnsLike); // 이 dokooNo에 해당하는 좋아요몇개냐 
		}
		
		DokooSns dokooSnsBookmark = dokooDao.getDokooBookmark(map);
		if(dokooSnsBookmark != null) {
			dokooSnsBookmark.setSnsType(SnsType.BOOKMARK);
		}

		dokooSnsList.add(dokooSnsBookmark); // 이 dokoo loginMember가 북마킹 했냐
		return dokooSnsList;
	}
	
	@Override
	public int insertDokooLike(Map<String, Object> map) {
		return dokooDao.insertDokooLike(map);
	}
	
	@Override
	public int insertDokooWishList(Map<String, Object> map) {
		return dokooDao.insertDokooWishList(map);
	}
	
	@Override
	public int deleteDokooLike(Map<String, Object> map) {
		return dokooDao.deleteDokooLike(map);
	}
	
	@Override
	public int deleteDokooWishList(Map<String, Object> map) {
		return dokooDao.deleteDokooWishList(map);
	}
	
	@Override
	public int deleteDokoo(int dokooNo) {
		// dokoo 삭제될 때 likes_pheed column도 삭제
		int result = dokooDao.deleteDokooLikes(dokooNo);
		// dokoo 삭제될 때 wishlist_pheed column도 삭제
		result = dokooDao.deleteDokooWishlists(dokooNo);
		result = dokooDao.deleteDokoo(dokooNo); 
		return result;
	}
	
	@Override
	public int updateDokoo(Dokoo dokoo) {
		return dokooDao.updateDokoo(dokoo);
	}
	
	@Override
	public int commentRefEnroll(DokooComment dc) {
		return dokooDao.commentRefEnroll(dc);
	}
	
	@Override
	public DokooComment selectOneDokooComment(int dokooCNo) {
		return dokooDao.selectOneDokooComment(dokooCNo);
	}
}
