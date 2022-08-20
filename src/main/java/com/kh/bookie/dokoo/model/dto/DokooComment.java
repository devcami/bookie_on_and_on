package com.kh.bookie.dokoo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class DokooComment extends DokooCommentEntity {
	private String renamedFilename;
	private String memberId;
}
