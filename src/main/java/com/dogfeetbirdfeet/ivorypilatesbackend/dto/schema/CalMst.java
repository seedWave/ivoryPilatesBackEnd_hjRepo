package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

/**
 * @author nks
 * @apiNote Calendar Master Schema
 */
@Data
public class CalMst {

	private Long calId;
	private String year;
	private String month;
	private String day;
	private String korDate;
	private String schedDate;
	private String schedTime;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;

}
