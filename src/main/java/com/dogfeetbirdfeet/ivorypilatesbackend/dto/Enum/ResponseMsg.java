package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Map;

/**
 * @author nks
 * @apiNote Response Message 관리를 위한 Enum 타입
 */
@Getter
@RequiredArgsConstructor
public enum ResponseMsg {

    NOT_FOUND("NOT_FOUND", "요청하신 리소스를 찾을 수 없습니다.", null),
    BAD_REQUEST("BAD_REQUEST", "잘못 된 요청입니다.", null),
    ON_SUCCESS("ON_SUCCESS", "요청이 성공했습니다", null);

    private final String key;
    private final String msg;
    private final Map<String, Object> details;

}
