package com.dogfeetbirdfeet.ivorypilatesbackend.dto.searchdto;

import lombok.Data;

@Data
public class TestSearchDto {

	private int userId;
	private int acctId;
	private String payMethod;
	private String useYn;
	private String refundYn;
	private String payDateFrom;
	private String payDateTo;
	private String refundDateFrom;
	private String refundDateTo;
	private String schDate;
	private String staDate;
	private String endDate;
	private String schMonth;
	private String searchUserNm;
}
