package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.Day;

/**
 * @author nks
 * @apiNote 고정 스케쥴
 */
@Data
public class SchedFx {

	private Long fxSchedId;
	private String MstId;
	private String acctId;
	private Day fxDay;
	private String fxTime;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;

}
