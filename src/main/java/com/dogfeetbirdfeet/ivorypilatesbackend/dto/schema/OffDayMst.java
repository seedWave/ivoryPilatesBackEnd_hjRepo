package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

/**
 * @author nks
 * @apiNote 휴무일 관리 schema
 */
@Data
public class OffDayMst {

	private Long offId;
	private String acctId;
	private String trainerNm;
	private YN restYn;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
