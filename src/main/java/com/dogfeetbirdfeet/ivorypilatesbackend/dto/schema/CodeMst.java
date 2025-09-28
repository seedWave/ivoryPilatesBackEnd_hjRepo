package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 공통코드관리 schema
 */
@Data
public class CodeMst {

	private Long codeMstId;
	private String classCd;
	private String classNm;
	private String comment;
	private YN useYn;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
