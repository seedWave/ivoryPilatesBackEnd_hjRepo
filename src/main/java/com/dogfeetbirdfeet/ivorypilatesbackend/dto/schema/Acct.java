package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.Gender;

import lombok.Data;

/**
 * @author nks
 * @apiNote 계정 테이블 Schema
 */
@Data
public class Acct {

    private String acctId;
    private String acctPw;
    private String name;
    private String contact;
    private String birthDate;
    private Gender gender;
    private YN activeYn;
    private String regDtm;
    private String regId;
    private String modDtm;
    private String modId;
}
