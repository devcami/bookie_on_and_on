package com.kh.bookie.pheed.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.pheed.model.dao.PheedDao;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedAttachment;
import com.kh.bookie.pheed.model.dto.PheedComment;

@Service
@Transactional (rollbackFor = Exception.class)
public class PheedServiceImpl implements PheedService{
	@Autowired
	private PheedDao pheedDao;
	
	@Override
	public List<Pheed> selectPheedFList(Map<String, Object> map) {
		List<Pheed> list = pheedDao.selectPheedFList(map);
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}
	
	@Override
	public List<Pheed> selectPheedCList(Map<String, Object> map) {
		List<Pheed> list = pheedDao.selectPheedCList(map);
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}
	
	@Override
	public List<Pheed> selectMyPheedList(Map<String, Object> map) {
		List<Pheed> list = pheedDao.selectMyPheedList(map);
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}
	
	@Override
	public List<PheedComment> selectPheedCommentList(int pheedNo) {
		return pheedDao.selectPheedCommentList(pheedNo);
	}
	
	@Override
	public int pheedEnroll(Pheed pheed) {
		// pheed insert
		int result = pheedDao.pheedEnroll(pheed);
		
		// 첨부파일 insert
		PheedAttachment attach = pheed.getAttach();
		if(attach != null) {
			attach.setPheedNo(pheed.getPheedNo());
			result = pheedDao.pheedAttachmentEnroll(attach);
		}
		
		return result;
	}
	
	@Override
	public int report(Map<String, Object> map) {
		return pheedDao.report(map);
	}
	
	@Override
	public List<String> getPheedLikesListbyMemberId(String username) {
		return pheedDao.getPheedLikesListbyMemberId(username);
	}
	
	@Override
	public List<String> getPheedWishListbyMemberId(String username) {
		return pheedDao.getPheedWishListbyMemberId(username);
	}
	
	@Override
	public int insertPheedLike(Map<String, Object> map) {
		return pheedDao.insertPheedLike(map);
	}
	
	@Override
	public int insertPheedWishList(Map<String, Object> map) {
		return pheedDao.insertPheedWishList(map);
	}
	
	@Override
	public int deletePheedLike(Map<String, Object> map) {
		return pheedDao.deletePheedLike(map);
	}
	
	@Override
	public int deletePheedWishList(Map<String, Object> map) {
		return pheedDao.deletePheedWishList(map);
	}
	
	@Override
	public int deletePheed(int pheedNo) {
		// pheed 삭제될 때 likes_pheed column도 삭제
		int result = pheedDao.deletePheedLikes(pheedNo);
		// pheed 삭제될 때 wishlist_pheed column도 삭제
		result = pheedDao.deletePheedWishlists(pheedNo);
		result = pheedDao.deletePheed(pheedNo); 
		return result;
	}
	
	@Override
	public Pheed selectOnePheed(int pheedNo) {
		return pheedDao.selectOnePheed(pheedNo);
	}
	
	@Override
	public PheedAttachment selectOnePheedAttachment(int attachNo) {
		return pheedDao.selectOnePheedAttachment(attachNo);
	}
	
	@Override
	public int deleteAttachment(int attachNo) {
		return pheedDao.deleteAttachment(attachNo);
	}
	
	@Override
	public int pheedUpdate(Pheed pheed) {
		// pheed update
		int result = pheedDao.pheedUpdate(pheed);
		
		// 첨부파일 insert
		PheedAttachment attach = pheed.getAttach();
		if(attach != null) {
			attach.setPheedNo(pheed.getPheedNo());
			result = pheedDao.pheedAttachmentEnroll(attach);
		}
		
		return result;
	}
	
	@Override
	public int commentEnroll(PheedComment pc) {
		return pheedDao.commentEnroll(pc);
	}
	
	@Override
	public int commentDel(int pheedCNo) {
		return pheedDao.commentDel(pheedCNo);
	}
	
	@Override
	public int commentUpdate(PheedComment pheedComment) {
		return pheedDao.commentUpdate(pheedComment);
	}
	
	@Override
	public int commentRefEnroll(PheedComment pc) {
		return pheedDao.commentRefEnroll(pc);
	}
	
	@Override
	public PheedComment selectOnePheedComment(int pheedCNo) {
		return pheedDao.selectOnePheedComment(pheedCNo);
	}

	@Override
	public List<Pheed> getMyPheedWishList(Map<String, Object> map) {
		List<Pheed> list = pheedDao.getMyPheedWishList(map);
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}
	
	
	
}
