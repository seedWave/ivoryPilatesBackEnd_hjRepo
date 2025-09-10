package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

@Data
public class Acct {

    private String acctId;
    private String acctPw;
    private String name;
    private String contact;
    private String birthDate;
    private String gender;
    private String activeYn;
    private String regDtm;
    private String regId;
    private String modDtm;
    private String modId;
}
