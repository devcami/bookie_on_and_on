package com.kh.bookie.club.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Club extends ClubEntity {

	private List<ClubBook> bookList = new ArrayList<>();
	private List<Mission> missionList = new ArrayList<>();
	private List<String> imgSrcList = new ArrayList<>(); 
	private int currentNop;
	
	
	public Club(int clubNo, String title, String content, LocalDate recruitStart, LocalDate recruitEnd, LocalDate clubStart,
			LocalDate clubEnd, int bookCount, int maximunNop, int minimunNop, int deposit, String interest) {
		super(clubNo, title, content, recruitStart, recruitEnd, clubStart, clubEnd, bookCount, maximunNop, minimunNop, deposit, interest);
		
		this.bookList = bookList;
		this.missionList = missionList;
		this.imgSrcList = imgSrcList;
		this.currentNop = currentNop;
		
	}

	@Override
	public int getBookCount() {
		// TODO Auto-generated method stub
		return super.getBookCount();
	}

	@Override
	public LocalDate getClubEnd() {
		// TODO Auto-generated method stub
		return super.getClubEnd();
	}

	@Override
	public int getClubNo() {
		// TODO Auto-generated method stub
		return super.getClubNo();
	}

	@Override
	public LocalDate getClubStart() {
		// TODO Auto-generated method stub
		return super.getClubStart();
	}

	@Override
	public String getContent() {
		// TODO Auto-generated method stub
		return super.getContent();
	}

	@Override
	public int getDeposit() {
		// TODO Auto-generated method stub
		return super.getDeposit();
	}

	@Override
	public int getMaximumNop() {
		// TODO Auto-generated method stub
		return super.getMaximumNop();
	}

	@Override
	public int getMinimumNop() {
		// TODO Auto-generated method stub
		return super.getMinimumNop();
	}

	@Override
	public LocalDate getRecruitEnd() {
		// TODO Auto-generated method stub
		return super.getRecruitEnd();
	}

	@Override
	public LocalDate getRecruitStart() {
		// TODO Auto-generated method stub
		return super.getRecruitStart();
	}

	@Override
	public String getTitle() {
		// TODO Auto-generated method stub
		return super.getTitle();
	}
	
	@Override
	public String getInterest() {
		// TODO Auto-generated method stub
		return super.getInterest();
	}

	@Override
	public void setBookCount(int bookCount) {
		// TODO Auto-generated method stub
		super.setBookCount(bookCount);
	}

	@Override
	public void setClubEnd(LocalDate clubEnd) {
		// TODO Auto-generated method stub
		super.setClubEnd(clubEnd);
	}

	@Override
	public void setClubNo(int clubNo) {
		// TODO Auto-generated method stub
		super.setClubNo(clubNo);
	}

	@Override
	public void setClubStart(LocalDate clubStart) {
		// TODO Auto-generated method stub
		super.setClubStart(clubStart);
	}

	@Override
	public void setContent(String content) {
		// TODO Auto-generated method stub
		super.setContent(content);
	}

	@Override
	public void setDeposit(int deposit) {
		// TODO Auto-generated method stub
		super.setDeposit(deposit);
	}

	@Override
	public void setMaximumNop(int maximumNop) {
		// TODO Auto-generated method stub
		super.setMaximumNop(maximumNop);
	}

	@Override
	public void setMinimumNop(int minimumNop) {
		// TODO Auto-generated method stub
		super.setMinimumNop(minimumNop);
	}

	@Override
	public void setRecruitEnd(LocalDate recruitEnd) {
		// TODO Auto-generated method stub
		super.setRecruitEnd(recruitEnd);
	}

	@Override
	public void setRecruitStart(LocalDate recruitStart) {
		// TODO Auto-generated method stub
		super.setRecruitStart(recruitStart);
	}

	@Override
	public void setTitle(String title) {
		// TODO Auto-generated method stub
		super.setTitle(title);
	}

	@Override
	public void setInterest(String interest) {
		// TODO Auto-generated method stub
		super.setInterest(interest);
	}
	
	
}


