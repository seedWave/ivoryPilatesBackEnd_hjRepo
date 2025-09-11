package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum YN {

	Y("Y", "사용 중"),
	N("N", "사용 불가");

	private final String key;
	private final String value;
}
