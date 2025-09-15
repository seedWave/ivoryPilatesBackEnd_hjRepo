package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

/**
 * @author nks
 * @apiNote 자격증 schema
 */
@Data
public class Certificate {

	private Long certId;
	private String acctId;
	private String certName;
	private String certIssueDate;
	private String certExpDate;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;


}
