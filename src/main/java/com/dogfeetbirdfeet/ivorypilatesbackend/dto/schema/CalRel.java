package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import lombok.Data;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.CalType;

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
