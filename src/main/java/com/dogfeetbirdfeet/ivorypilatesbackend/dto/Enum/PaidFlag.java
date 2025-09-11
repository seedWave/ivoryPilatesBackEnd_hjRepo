package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum PaidFlag {

	PAY("PAY", "결제"),
	DIS("DIS", "할인"),
	REF("REF", "환불");
	
	private final String key;
	private final String value;
}
