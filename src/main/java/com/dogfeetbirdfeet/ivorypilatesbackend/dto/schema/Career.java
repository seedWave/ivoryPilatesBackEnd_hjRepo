package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

/**
 * @author nks
 * @apiNote 경력 schema
 */
@Data
public class Career {

	private Long careerId;
	private String acctId;
	private String careerNm;
	private String careerOrg;
	private String careerMemo;
	private String careerStrtDt;
	private String careerEndDt;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;

}
