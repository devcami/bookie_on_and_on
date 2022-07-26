package com.kh.bookie.dokoo.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;

@Mapper
public interface DokooDao {

	List<Dokoo> selectDokooList(RowBounds rowBounds);

	int selectTotalContent();

	Dokoo selectOneDokoo(int dokooNo);

	List<DokooComment> selectDokooComments(int dokooNo);
	
	
}
