package com.kh.bookie.admin.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookie.admin.model.dto.Alarm;

import lombok.NonNull;

@Mapper
public interface AdminDao {

	int insertAlarm(Alarm alarm);

	int getUnreadCount(@NonNull String memberId);

}
