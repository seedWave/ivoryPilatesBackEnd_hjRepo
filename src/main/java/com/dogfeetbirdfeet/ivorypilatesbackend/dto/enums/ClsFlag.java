package com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ClsFlag {

	G("G", "그룹"),
	S("S", "공유");

	private final String key;
	private final String value;
}
