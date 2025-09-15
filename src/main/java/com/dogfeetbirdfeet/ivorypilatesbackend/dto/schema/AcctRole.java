package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

/**
 * @author nks
 * @apiNote 계정-역할 매핑 schema
 */
@Data
public class AcctRole {

	private String acctId;
	private Long roleId;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
