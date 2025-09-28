package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.CalType;

import lombok.Data;

/**
 * @author nks
 * @apiNote Calendar Relation Schema
 */
@Data
public class CalRel {

	private Long calId;
	private CalType calType;
	private Long tarId;
}
