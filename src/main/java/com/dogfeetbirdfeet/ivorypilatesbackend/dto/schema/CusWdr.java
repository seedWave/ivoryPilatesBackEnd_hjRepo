package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 탈퇴 고객 schema
 */
@Data
public class CusWdr {

	private String custId;
	private String mstId;
	private String acctId;
	private String grpCusId;
	private String clsPassId;
	private Integer height;
	private Integer weight;
	private String disease;
	private String surHist;
	private String bodyCheckImg;
	private String lastClsDate;
	private YN famCusYn;
	private String delDtm;
	private String remark;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;

}
