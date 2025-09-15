package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote cusReg schema
 */
@Data
public class cusReg {

	private String custId;
	private String mstId;
	private String acctId;
	private Long grpCusId;
	private Long clsPassId;
	private Integer height;
	private Integer weight;
	private String disease;
	private String surHist;
	private String bodyCheckImg;
	private YN fxClsYn;
	private String fxClsDay;
	private String fxClsTm;
	private String lastClsDate;
	private YN famCusYn;
	private YN restYn;
	private String restDtm;
	private String remark;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
