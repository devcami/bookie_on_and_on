package com.kh.bookie.mypage.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bookie.member.model.dto.Follower;
import com.kh.bookie.club.model.dao.ClubDao;
import com.kh.bookie.club.model.dto.Club;
import com.kh.bookie.club.model.dto.ClubBook;
import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.mypage.model.dao.MypageDao;
import com.kh.bookie.mypage.model.dto.BookIng;
import com.kh.bookie.mypage.model.dto.Qna;
import com.kh.bookie.pheed.model.dao.PheedDao;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedAttachment;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	MypageDao mypageDao;
	
	@Autowired
	ClubDao clubDao;
	
	@Autowired
	PheedDao pheedDao;
	
	@Override
	public List<Qna> selectMyQnaList(String memberId) {
		return mypageDao.selectMyQnaList(memberId);
	}
	
	@Override
	public int getFollowers(String memberId) {
		return mypageDao.getFollowers(memberId);
	}
	
	@Override
	public int getFollowing(String memberId) {
		return mypageDao.getFollowing(memberId);
	}
	
	@Override
	public List<Follower> selectFollowerList(String memberId) {
		return mypageDao.selectFollowerList(memberId);
	}
	
	@Override
	public List<Follower> selectFollowingList(String memberId) {
		return mypageDao.selectFollowingList(memberId);
	}
	
	@Override
	public int qnaEnroll(Qna qna) {
		return mypageDao.qnaEnroll(qna);
	}
	
	@Override
	public Qna selectOneQna(int qnaNo) {
		return mypageDao.selectOneQna(qnaNo);
	}

	@Override
	public List<BookIng> SelectMyBookIngList(String memberId) {
		return mypageDao.SelectMyBookIngList(memberId);
	}

	@Override
	public List<Club> selectMyClubList(Map<String, Object> map) {

		
		// 1. club 찾아와
		List<Club> list = mypageDao.selectMyClubList(map);

		// 2. club에 사진 할당해
		for(Club club : list) {
			List<ClubBook> bookList = clubDao.selectClubBook(club.getClubNo());
			club.setBookList(bookList);
		}
		
		return list;
	}
	
	@Override
	public int selectTotalMyClub(Map<String, Object> map) {
		return mypageDao.selectTotalMyClub(map);
	}
	
	@Override
	public List<Pheed> selectMyPheedList(Map<String, Object> map) {
		List<Pheed> list = mypageDao.selectMyPheedList(map);
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}

	@Override
	public int selectTotalMyDokoo(String memberId) {
		return mypageDao.selectTotalMyDokoo(memberId);
	}
	
	@Override
	public List<Dokoo> selectMyDokooList(Map<String, Object> map) {	
		return mypageDao.selectMyDokooList(map);
	}

	@Override
	public List<Dokoo> selectWishMyDokooList(Map<String, Object> map) {
		return mypageDao.selectWishMyDokooList(map);
	}

	@Override
	public List<Pheed> selectWishMyPheedFList(Map<String, Object> map) {
		List<Pheed> list = mypageDao.selectWishMyPheedFList(map);
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}

	@Override
	public List<Club> selectMyScrapClubList(Map<String, Object> map) {
		// 1. club 찾아와
		List<Club> list = mypageDao.selectMyScrapClubList(map);

		// 2. club에 사진 할당해
		for(Club club : list) {
			List<ClubBook> bookList = clubDao.selectClubBook(club.getClubNo());
			club.setBookList(bookList);
		}
		return list;
	}

	@Override
	public int selectTotalMyWishClub(Map<String, Object> map) {
		return mypageDao.selectTotalMyWishClub(map);
	}

	@Override
	public int selectTotalMyWishDokoo(String memberId) {
		return mypageDao.selectTotalMyWishDokoo(memberId);
	}
}
