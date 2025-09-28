package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 회차별 상품 Schema
 */
@Data
public class ClsPkg {

	private Long clsPkgId;
	private String clsPkgNm;
	private Integer clsPkgCnt;
	private Integer price;
	private Integer discountAmt;
	private YN instYn;
	private Integer instMm;
	private YN useYn;
	private String expRate;
	private String remark;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
