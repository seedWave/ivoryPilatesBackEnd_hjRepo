package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.Acct;

@Mapper
public interface AcctMapper {

	/**
	 * 모든 계정 목록 조회
	 *
	 * @author nks
	 * @return 모든 계정 목록
	 */
	List<Acct> getAllAccts();

	/**
	 * 대상 ID 일치하는 계정 조회
	 *
	 * @author nks
	 * @param acctId 대상 ID
	 * @return 계정
	 */
	Acct getAcctById(@Param("acctId")
	String acctId);

	int insertAcct(@Param("acct")
	Acct acct, @Param("userId")
	String userId);
}
