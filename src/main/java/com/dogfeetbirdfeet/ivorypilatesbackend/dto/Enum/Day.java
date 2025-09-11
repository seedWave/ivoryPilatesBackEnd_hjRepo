package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Day {

	ONE(1, "월요일"),
	TWO(2, "화요일"),
	THR(3, "수요일"),
	FOR(4, "목요일"),
	FIV(5, "금요일"),
	SIX(6, "토요일"),
	SEV(7, "일요일");

	private final int key;
	private final String value;
}
