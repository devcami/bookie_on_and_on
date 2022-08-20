package com.kh.bookie.pheed.model.dto;

import com.kh.bookie.dokoo.model.dto.DokooComment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class PheedComment extends PheedCommentEntity {
	private String renamedFilename;
	private String memberId;
}
