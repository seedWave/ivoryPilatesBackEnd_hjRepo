package com.dogfeetbirdfeet.ivorypilatesbackend.service.calMst;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalMst;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calMst.CalMstMapper;

@Service
public class CalMstService {

	private final CalMstMapper calMstMapper;

	public CalMstService(CalMstMapper calMstMapper) {
		this.calMstMapper = calMstMapper;
	}

	/**
	 * 특정 일자의 ID들을 모두 구해온다.
	 *
	 * @author nks
	 * @param schedDate 대상 일자 (String)
	 * @return 대상 일자의 ID 목록
	 */
	public List<CalMst> findCalIdBySchedDate(@Param("schedDate")
	String schedDate) {
		return calMstMapper.findCalIdBySchedDate(schedDate);
	}
}
