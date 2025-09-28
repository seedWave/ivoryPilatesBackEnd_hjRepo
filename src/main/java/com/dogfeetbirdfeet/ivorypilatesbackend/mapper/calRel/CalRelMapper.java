package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calRel;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CalRel;

@Mapper
public interface CalRelMapper {

	int insertCalRel(@Param("calRel") CalRel calRel);
}
