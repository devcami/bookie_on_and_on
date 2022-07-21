package com.kh.bookie.pheed.model.dto;

import java.util.ArrayList;
import java.util.List;

import com.kh.bookie.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString
public class Pheed extends PheedEntity{
	private List<PheedAttachment> attachments = new ArrayList<>();
	private Member member;

	public void addPheedAttachment (@NonNull PheedAttachment attach) {
		attachments.add(attach);
	}
	
	
}
