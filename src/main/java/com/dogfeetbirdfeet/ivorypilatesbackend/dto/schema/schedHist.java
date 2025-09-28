package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

/**
 * @author nks
 * @apiNote 스케쥴 히스토리 schema
 */
@Data
public class schedHist {

	private Long schedHistId;
	private Long schedId;
	private String acctId;
	private String mstId;
	private YN clsDoneYn;
	private String modCnt;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
