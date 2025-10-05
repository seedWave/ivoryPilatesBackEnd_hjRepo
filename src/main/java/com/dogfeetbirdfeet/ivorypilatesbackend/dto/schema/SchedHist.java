package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 스케쥴 히스토리 schema
 */
@Data
public class SchedHist {

	private Long schedHistId;
	private Long schedId;
	private String acctId;
	private Long mstId;
	private YN clsDoneYn;
	private String modCnt;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
