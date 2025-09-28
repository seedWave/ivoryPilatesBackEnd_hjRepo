package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.Role;

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
