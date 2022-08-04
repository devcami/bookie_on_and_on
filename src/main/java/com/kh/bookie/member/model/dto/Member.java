package com.kh.bookie.member.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member extends MemberEntity implements UserDetails{
	List<SimpleGrantedAuthority> authorities;
	String[] interests;
	String interest;
	
	private static final long serialVersionUID = 1L;

	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getUsername() {
		return memberId;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}


	public Member(@NonNull String memberId, @NonNull String password, @NonNull LocalDateTime enrollDate,
			@NonNull String nickname, @NonNull String phone, @NonNull Gender gender) {
		super(memberId, password, enrollDate, nickname, phone, gender);
		// TODO Auto-generated constructor stub
	}

	public Member(@NonNull String memberId, @NonNull String password, @NonNull LocalDateTime enrollDate,
			@NonNull String nickname, @NonNull String phone, @NonNull Gender gender, LocalDate birthday,
			String introduce, String renamedFilename, String originalFilename, String sns, int point, String email) {
		super(memberId, password, enrollDate, nickname, phone, gender, birthday, introduce, renamedFilename, originalFilename,
				sns, point, email);
		// TODO Auto-generated constructor stub
	}


	
}
