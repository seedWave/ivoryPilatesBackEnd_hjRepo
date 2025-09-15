package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.Role;

import lombok.Data;

/**
 * @author nks
 * @apiNote Role Schema
 */
@Data
public class Roles {

	private Long roleId;
	private Role roleNm;
	private String roleDesc;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
