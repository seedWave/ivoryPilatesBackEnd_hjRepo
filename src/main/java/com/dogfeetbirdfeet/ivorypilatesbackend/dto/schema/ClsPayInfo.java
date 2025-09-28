package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.PaidFlag;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.PayMethod;

/**
 * @author nks
 * @apiNote 결제 정보 schema
 */
@Data
public class ClsPayInfo {

	private Long payId;
	private Long clsPkgId;
	private PaidFlag paidFlag;
	private Integer paidAmt;
	private PayMethod payMethod;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
