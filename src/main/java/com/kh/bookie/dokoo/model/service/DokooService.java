package com.kh.bookie.dokoo.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;
import com.kh.bookie.dokoo.model.dto.DokooSns;
import com.kh.bookie.mypage.model.dto.Book;

public interface DokooService {

	List<Dokoo> selectDokooList(int cPage, int numPerPage);

	int selectTotalContent();

	Dokoo selectOneDokoo(int dokooNo);

	List<Book> getReadBookList(String memberId);

	int dokooEnroll(Dokoo dokoo);

	int commentEnroll(DokooComment dc);

	int commentDel(int dokooCNo);

	int commentUpdate(DokooComment dokooComment);

	List<DokooSns> getDokooSns(Map<String, Object> map);

	int insertDokooLike(Map<String, Object> map);

	int insertDokooWishList(Map<String, Object> map);

	int deleteDokooLike(Map<String, Object> map);

	int deleteDokooWishList(Map<String, Object> map);

	int deleteDokoo(int dokooNo);

	int updateDokoo(Dokoo dokoo);

	int commentRefEnroll(DokooComment dc);

	DokooComment selectOneDokooComment(int dokooCNo);

}
