package com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Gender {

	M("M", "남성"),
	W("W", "여성");

	private final String key;
	private final String value;
}
