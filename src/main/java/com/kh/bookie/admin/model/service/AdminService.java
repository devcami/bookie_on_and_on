package com.kh.bookie.admin.model.service;

import com.kh.bookie.admin.model.dto.Alarm;

import lombok.NonNull;

public interface AdminService {

	int insertAlarm(Alarm alarm);

	int getUnreadCount(@NonNull String memberId);

}
