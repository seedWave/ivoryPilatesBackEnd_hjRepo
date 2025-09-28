package com.dogfeetbirdfeet.ivorypilatesbackend.service.holidaymst;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonmethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker.ServiceResult;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.datadto.HolidayMstWithSchedDate;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.CalType;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.enums.ResponseMsg;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalMst;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalRel;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.holidaymst.HolidayMstMapper;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.calmst.CalMstService;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.calrel.CalRelService;

@Service
public class HolidayMstService {

	private final HolidayMstMapper holidayMstMapper;
	private final CalRelService calRelService;
	private static final CommonMethod commonMethod = new CommonMethod();
	private final CalMstService calMstService;

	public HolidayMstService(HolidayMstMapper holidayMstMapper, CalRelService calRelService,
		CalMstService calMstService) {
		this.holidayMstMapper = holidayMstMapper;
		this.calRelService = calRelService;
		this.calMstService = calMstService;
	}

	/**
	 * 공휴일 입력, 공공데이터포털 API 통해 가져온다.
	 *
	 * @author nks
	 * @param holidayMsts 공휴일 목록
	 * @return 첫 번째 공휴일 반환한다.
	 */
	@Transactional
	public ServiceResult<HolidayMstWithSchedDate> insertHolidayMst(
		List<HolidayMstWithSchedDate> holidayMsts) {

		for (HolidayMstWithSchedDate holidayMst : holidayMsts) {

			ResponseMsg fsMsg = commonMethod.returnResultByResponseMsg(
				holidayMstMapper.insertHoliday(holidayMst));

			if (!(fsMsg.equals(ResponseMsg.ON_SUCCESS)) && !(fsMsg.equals(ResponseMsg.MULTI_AFFECTED))) {
				return ServiceResult.failure(fsMsg);
			}

			List<CalMst> list = calMstService.findCalIdBySchedDate(holidayMst.getSchedDate());

			for (CalMst calMst : list) {

				CalRel calRel = new CalRel();
				calRel.setCalId(calMst.getCalId());
				calRel.setCalType(CalType.HOL_DAY);
				calRel.setTarId(holidayMst.getHoliId());

				ServiceResult<ResponseMsg> fsMsgByCalRel = calRelService.insertCalRel(calRel);

				if (!fsMsgByCalRel.status().equals(ResponseMsg.ON_SUCCESS)) {
					return ServiceResult.failure(ResponseMsg.BAD_REQUEST);
				}
			}

		}

		return ServiceResult.success(holidayMsts::getFirst);
	}
}
