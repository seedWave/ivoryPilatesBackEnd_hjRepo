package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

/**
 * @author nks
 * @apiNote 상담 고객 scheme
 */
@Data
public class CusCons {

	private String cusId;
	private String mstId;
	private Integer height;
	private Integer weight;
	private String disease;
	private String surHist;
	private String bodyCheckImg;
	private String consDate;
	private String remark;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
