package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calRel;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalRel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CalRelMapper {

    int insertCalRel(@Param("calRel")CalRel calRel);
}
