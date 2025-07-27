package com.dogfeetbirdfeet.ivorypilatesbackend.dto.acct;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AcctDto {

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

    public AcctDto() {}

    public AcctDto(String acctId, String acctPw, String name, String contact, String birthDate, String gender,
        String activeYn, String regDtm, String regId, String modDtm, String modId) {
        this.acctId = acctId;
        this.acctPw = acctPw;
        this.name = name;
        this.contact = contact;
        this.birthDate = birthDate;
        this.gender = gender;
        this.activeYn = activeYn;
        this.regDtm = regDtm;
        this.regId = regId;
        this.modDtm = modDtm;
        this.modId = modId;
    }
}
