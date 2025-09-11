package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 공통코드관리 schema
 */
@Data
public class CodeMst {

	private String codeMstId;
	private String classCd;
	private String classNm;
	private String comment;
	private YN useYn;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
