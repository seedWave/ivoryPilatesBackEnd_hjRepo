package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.acct.AcctDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AcctMapper {

	/**
	 * 모든 계정 목록 조회
	 * 
	 * @author nks
	 * @return 모든 계정 목록
	 */
	List<AcctDto> getAllAccts();

	/**
	 * 대상 ID 일치하는 계정 조회
	 * 
	 * @author nks
	 * @param acctId 대상 ID
	 * @return 계정
	 */
    AcctDto getAcctById(@Param("acctId") String acctId);
}
