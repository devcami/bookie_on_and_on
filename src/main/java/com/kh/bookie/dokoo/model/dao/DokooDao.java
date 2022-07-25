package com.kh.bookie.dokoo.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.dokoo.model.dto.Dokoo;

@Mapper
public interface DokooDao {

	List<Dokoo> selectDokooList();

}
