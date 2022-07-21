package com.kh.bookie.pheed.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.pheed.model.dao.PheedDao;
import com.kh.bookie.pheed.model.dto.Pheed;
import com.kh.bookie.pheed.model.dto.PheedAttachment;

@Service
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
	public List<Pheed> selectPheedCList() {
		List<Pheed> list = pheedDao.selectPheedCList();
		for(Pheed p : list) {
			PheedAttachment attach = pheedDao.selectAttachment(p.getPheedNo());
			p.setAttach(attach);
			Member member = pheedDao.selectMember(p.getMemberId());
			p.setMember(member);
		}
		return list;
	}
}
