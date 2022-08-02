package com.kh.bookie.pheed.model.service;

import java.util.List;

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
	public List<Pheed> selectPheedFList() {
		List<Pheed> list = pheedDao.selectPheedFList();
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}
	
	@Override
	public List<Pheed> selectPheedCList(int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		List<Pheed> list = pheedDao.selectPheedCList(rowBounds);
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
}
