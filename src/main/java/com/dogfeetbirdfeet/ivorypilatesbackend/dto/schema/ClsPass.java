package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.PayMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 결제 수강권 schema
 */
@Data
public class ClsPass {

	private Long clsPassId;
	private Long clsPkgId;
	private String mstId;
	private String grpCusId;
	private Integer discountAmt;
	private Integer paidAmt;
	private String payDate;
	private Integer totalCnt;
	private Integer instNm;
	private PayMethod payMethod;
	private Integer remainCnt;
	private String staDtm;
	private String endDtm;
	private YN finYn;
	private YN refundYn;
	private Integer refundAmt;
	private String refundDtm;
	private String remark;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;

}
