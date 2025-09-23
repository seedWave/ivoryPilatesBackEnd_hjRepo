package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.holidayMst;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.dataDTO.HolidayMstWithSchedDate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface HolidayMstMapper {

	/**
	 * 공휴일 생성
	 * @author nks
	 * @param holidayMst ApiService의 getHolidayExplorer 통해 확인한
	 *                   공공데이터포털의 공휴일을 입력한다.
	 * @return 결과값
	 */
	int insertHoliday(@Param("holi") HolidayMstWithSchedDate holidayMst);

}
