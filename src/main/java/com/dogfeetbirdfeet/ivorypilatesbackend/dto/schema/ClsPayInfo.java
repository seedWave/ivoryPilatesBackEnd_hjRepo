package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.PaidFlag;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.PayMethod;

import lombok.Data;

/**
 * @author nks
 * @apiNote 결제 정보 schema
 */
@Data
public class ClsPayInfo {

	private String payId;
	private String clsPkgId;
	private PaidFlag paidFlag;
	private Integer paidAmt;
	private PayMethod payMethod;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
