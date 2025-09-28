package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 공통코드 세부관리 schema
 */
@Data
public class CodeDtl {

	private Long codeId;
	private Long codeMstId;
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
