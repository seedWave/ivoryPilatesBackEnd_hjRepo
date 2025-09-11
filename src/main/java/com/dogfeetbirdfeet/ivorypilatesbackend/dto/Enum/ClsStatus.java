package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ClsStatus {

	SCH("SCH", "수업 예정"),
	COM("COM", "수업 완료"),
	NOS("NOS", "노쇼");

	private final String key;
	private final String value;
}
