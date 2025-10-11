package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.test;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.searchdto.TestSearchDto;

/**
 * @author nks
 * 프론트 테스트를 위한 임시 Mapper
 */
@Mapper
public interface TestMapper {

	// TODO 테스트용으로 SQLInjection 되니까, 오픈 전 반드시 삭제
	List<Map<String, Object>> findAnythingByTableName(@Param("tableName") String tableName,
		@Param("dto") TestSearchDto dto);
}
