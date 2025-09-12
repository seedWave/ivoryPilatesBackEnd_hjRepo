package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

/**
 * @author nks
 * @apiNote 공휴일 마스터 Schema
 */
@Data
public class HolidayMst {

	private String holiId;
	private String holiNm;
	private String schedDate;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
