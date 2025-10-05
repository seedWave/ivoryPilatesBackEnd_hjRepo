package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

/**
 * @author nks
 * @apiNote 등록 그룹 schema
 */
@Data
public class CusGrp {

	private Long grpCusId;
	private Long cusId1;
	private Long cusId2;
	private Long cusId3;
	private Long cusId4;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
