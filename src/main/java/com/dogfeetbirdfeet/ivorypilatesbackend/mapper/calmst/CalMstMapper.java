package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calmst;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalMst;

@Mapper
public interface CalMstMapper {

	List<CalMst> findCalIdBySchedDate(@Param("schedDate") String schedDate);

	/**
	 * 달력 마스터 데이터 생성
	 * @author nks
	 * @param staYmd 시작일자 (yyyyMMdd)
	 * @param endYmd 종료일자 (yyyyMMdd)
	 * @return 영향받은 행 수
	 */
	int makeCalMst(@Param("staYmd") String staYmd, @Param("endYmd") String endYmd);

}
