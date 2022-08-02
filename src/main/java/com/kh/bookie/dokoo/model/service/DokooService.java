package com.kh.bookie.dokoo.model.service;

import java.util.List;

import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;
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

}
