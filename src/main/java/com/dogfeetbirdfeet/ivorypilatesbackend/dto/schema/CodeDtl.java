package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 공통코드 세부관리 schema
 */
@Data
public class CodeDtl {

	private String codeMstId;
	private String codeId;
	private String classCd;
	private String dtlCd;
	private String dtlNm;
	private String clsComment;
	private YN useYn;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
