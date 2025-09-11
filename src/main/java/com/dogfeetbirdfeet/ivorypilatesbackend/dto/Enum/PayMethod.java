package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum PayMethod {

	CARD("CARD", "카드"),
	CASH("CASH", "현금");

	private final String key;
	private final String value;
}
