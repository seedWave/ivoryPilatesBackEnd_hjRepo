package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 스케쥴 히스토리 schema
 */
@Data
public class schedHist {

	private String schedHistId;
	private String schedId;
	private String acctId;
	private String mstId;
	private String schedDate;
	private String schedTime;
	private YN clsDoneYn;
	private String modCnt;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
