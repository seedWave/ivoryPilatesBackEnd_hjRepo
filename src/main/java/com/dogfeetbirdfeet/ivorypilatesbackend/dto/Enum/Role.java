package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * @author nks
 * @apiNote Role Enum, 권한 관리를 위한 Enum 타입
 */
@Getter
@RequiredArgsConstructor
public enum Role {

    ADMIN("01","ADMIN","관리자"),
    USER("02","USER","사용자"),
    TRAINER("03","TRAINER","강사"),
    TIME_TRAINER("04","TIME_TRAINER","시간 강사");

    private final String key;
    private final String title;
    private final String description;
}
