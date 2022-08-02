package com.kh.bookie.dokoo.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.dokoo.model.dao.DokooDao;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;
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
}
