package com.dogfeetbirdfeet.ivorypilatesbackend.dto.dataDTO;

import lombok.Data;

/**
 * @author nks
 * @apiNote HolidayMst Insert 시 편의를 위한 schedDate 추가 버전 DTO
 */
@Data
public class HolidayMstWithSchedDate {

    private Long holiId;
    private String holiNm;
    private String schedDate;
    private String regDtm;
    private String regId;
    private String modDtm;
    private String modId;
}
