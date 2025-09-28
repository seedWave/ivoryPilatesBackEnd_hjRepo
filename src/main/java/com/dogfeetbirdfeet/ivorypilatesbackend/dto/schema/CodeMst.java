package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

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
