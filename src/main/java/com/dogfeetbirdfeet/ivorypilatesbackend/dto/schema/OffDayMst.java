package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 휴무일 관리 schema
 */
@Data
public class OffDayMst {

	private String offId;
	private String acctId;
	private String trainerNm;
	private String schedDate;
	private YN restYn;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
