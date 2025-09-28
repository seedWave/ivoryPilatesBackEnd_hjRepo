package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calmst;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalMst;

@Mapper
public interface CalMstMapper {

	List<CalMst> findCalIdBySchedDate(@Param("schedDate") String schedDate);

	int makeCalMst(@Param("staYmd") String staYmd, @Param("endYmd") String endYmd);

}
