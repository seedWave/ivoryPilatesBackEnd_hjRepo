package com.dogfeetbirdfeet.ivorypilatesbackend.service.calrel;

import org.springframework.stereotype.Service;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonmethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker.ServiceResult;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.ResponseMsg;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalRel;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calrel.CalRelMapper;

@Service
public class CalRelService {

	private final CalRelMapper calRelMapper;
	private static final CommonMethod commonMethod = new CommonMethod();

	public CalRelService(CalRelMapper calRelMapper) {
		this.calRelMapper = calRelMapper;
	}

	/**
	 * 캘린더 관계 테이블 Insert
	 *
	 * @author : nks
	 * @param calRel 대상 오브젝트 정보
	 * @return 결과 메세지
	 */
	public ServiceResult<ResponseMsg> insertCalRel(CalRel calRel) {

		ResponseMsg fsMsg = commonMethod.returnResultByResponseMsg(
			calRelMapper.insertCalRel(calRel));

		if (!fsMsg.equals(ResponseMsg.ON_SUCCESS)) {
			return ServiceResult.failure(fsMsg);
		}

		return ServiceResult.success(() -> fsMsg);
	}
}
