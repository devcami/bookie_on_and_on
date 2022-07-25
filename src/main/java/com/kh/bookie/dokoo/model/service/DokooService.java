package com.kh.bookie.dokoo.model.service;

import java.util.List;

import com.kh.bookie.dokoo.model.dto.Dokoo;

public interface DokooService {

	List<Dokoo> selectDokooList(int cPage, int numPerPage);

	int selectTotalContent();

	Dokoo selectOneDokoo(int dokooNo);

}
