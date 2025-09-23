package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calMst;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalMst;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CalMstMapper {

    List<CalMst> findCalIdBySchedDate(@Param("schedDate") String schedDate);

    int makeCalmst(@Param("staYmd") String staYmd, @Param("endYmd") String endYmd);

}
