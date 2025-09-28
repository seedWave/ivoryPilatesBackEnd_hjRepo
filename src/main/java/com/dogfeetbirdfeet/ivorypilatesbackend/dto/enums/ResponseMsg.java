package com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * @author nks
 * @apiNote Response Message 관리를 위한 Enum 타입
 */
@Getter
@RequiredArgsConstructor
public enum ResponseMsg {

	CAN_NOT_FIND_USER("CAN_NOT_FIND_USER", "유저 정보가 없습니다"),
	NOT_FOUND("NOT_FOUND", "요청하신 리소스를 찾을 수 없습니다."),
	BAD_REQUEST("BAD_REQUEST", "잘못 된 요청입니다."),
	ON_SUCCESS("ON_SUCCESS", "요청이 성공했습니다"),
	MULTI_AFFECTED("MULTI_AFFECTED", "다중 건 변경되었습니다.");

	private final String key;
	private final String msg;

}
