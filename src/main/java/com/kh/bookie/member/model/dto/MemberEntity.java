package com.kh.bookie.member.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class MemberEntity {
	@NonNull
	protected String memberId;
	@NonNull
	protected String password;
	@NonNull
	protected LocalDateTime enrollDate;
	@NonNull
	protected String nickname;
	@NonNull
	protected String phone;
	@NonNull
	protected Gender gender;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate birthday;
	protected String introduce;
	protected String renamedFilename;
	protected String originalFilename;
	protected String sns;
	protected int point;
	protected String email;
}
