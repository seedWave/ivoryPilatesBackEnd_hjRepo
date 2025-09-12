package com.dogfeetbirdfeet.ivorypilatesbackend.service.holidayMst;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonMethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker.ServiceResult;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.ResponseMsg;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.HolidayMst;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.holidayMst.HolidayMstMapper;

@Service
public class HolidayMstService {

	private final HolidayMstMapper holidayMstMapper;
	private static final CommonMethod commonMethod = new CommonMethod();

	public HolidayMstService(HolidayMstMapper holidayMstMapper) {
		this.holidayMstMapper = holidayMstMapper;
	}

	/**
	 * 공휴일 입력, 공공데이터포털 API 통해 가져온다.
	 *
	 * @author nks
	 * @param holidayMsts 공휴일 목록
	 * @return 첫 번째 공휴일 반환한다.
	 */
	@Transactional
	public ServiceResult<HolidayMst> insertHolidayMst(List<HolidayMst> holidayMsts)
	{

		for (HolidayMst holidayMst : holidayMsts) {

			ResponseMsg fsMsg = commonMethod.returnResultByResponseMsg(
				holidayMstMapper.insertHoliday(holidayMst)
			);

			if (!(fsMsg.equals(ResponseMsg.ON_SUCCESS)) && !(fsMsg.equals(ResponseMsg.MULTI_AFFECTED))) {
				return ServiceResult.failure(fsMsg);
			}

		}

		return ServiceResult.success(holidayMsts::getFirst);
	}
}
