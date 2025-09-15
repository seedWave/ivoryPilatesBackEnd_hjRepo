package com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum CalType {

    SCH_MST("SCH_MST", "스케쥴 마스터"),
    SCH_HIS("SCH_HIST", "스케쥴 히스토리"),
    SCH_FIX("SCH_FIX", "고정 스케쥴"),
    OFF_DAY("OFF_DAY", "휴무일"),
    HOL_DAY("HOL_DAY", "휴무일");

    private final String key;
    private final String value;
}
