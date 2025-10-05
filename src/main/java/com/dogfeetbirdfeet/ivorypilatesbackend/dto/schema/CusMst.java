package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.Gender;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 고객 마스터 schema
 */
@Data
public class CusMst {

	private Long mstId;
	private String name;
	private String contact;
	private Gender gender;
	private String birthDate;
	private YN activeYn;
	private String remark;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;

}
