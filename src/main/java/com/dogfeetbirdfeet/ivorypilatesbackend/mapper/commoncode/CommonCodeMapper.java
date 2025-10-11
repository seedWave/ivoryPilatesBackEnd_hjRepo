package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.commoncode;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CodeDtl;

/**
 * @author nks
 * 공통 코드 조회를 위한 Mapper
 */
@Mapper
public interface CommonCodeMapper {

	List<CodeDtl> selectCommonCode(@Param("codeMstId") int codeMstId);
}
