package com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.ClsStatus;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;

import lombok.Data;

/**
 * @author nks
 * @apiNote 스케쥴 마스터 schema
 */
@Data
public class SchedMst {

	private Long schedId;
	private String acctId;
	private String mstId;
	private String trainerNm;
	private String cusNm;
	private ClsStatus clsStatus;
	private String clsSession;
	private String injury;
	private String homework;
	private YN videoRecYn;
	private YN restYn;
	private YN fxYn;
	private String clsNote;
	private YN clsNoteYn;
	private String regDtm;
	private String regId;
	private String modDtm;
	private String modId;
}
