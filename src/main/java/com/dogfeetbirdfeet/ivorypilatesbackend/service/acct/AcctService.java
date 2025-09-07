package com.dogfeetbirdfeet.ivorypilatesbackend.service.acct;

import java.util.List;
import java.util.function.Supplier;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonMethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.acct.AcctDto;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct.AcctMapper;

@Service
public class AcctService {

	private final AcctMapper acctMapper;
	private final CommonMethod commonMethod = new CommonMethod();

	public AcctService(final AcctMapper acctMapper) {
		this.acctMapper = acctMapper;
	}

	public List<AcctDto> getAllAccts() {
		return postProcessingAcctTables(acctMapper.getAllAccts());
	}
	/**
	 * 계정 ID와 일치하는 계정 반환한다.
	 *
	 * @author nks
	 * @param acctId 대상 계정 아이디
	 * @return 계정 정보
	 */
	public AcctDto getAcctById(@Param("acctId") String acctId) {

		return postProcessingAcctTable(acctMapper.getAcctById(acctId));
	}

	/**
	 * 계정 목록 반환 시 후처리 진행 한다.
	 * DTM(YYYYMMDD) -> YYYY년 MM월 DD일
	 * PictureId 있을 경우 -> PictureUrl Setting
	 *
	 * @author nks
	 * @param accts 대상 계정 리스트
	 * @return 후처리 후 대상 유저 리스트
	 */
	public List<AcctDto> postProcessingAcctTables(List<AcctDto> accts) {

		for (AcctDto acct : accts) {
			postProcessingAcctTable(acct);
		}

		return accts;
	}

	/**
	 * 유저 반환 시 후처리 진행 한다.
	 * DTM(YYYYMMDD) -> YYYY년 MM월 DD일
	 * PictureId 있을 경우 -> PictureUrl Setting
	 *
	 * @author nks
	 * @param user 대상 유저
	 * @return 후처리 후 대상 유저
	 */
	public AcctDto postProcessingAcctTable(AcctDto user) {

		if (null == user) return null;
		user.setBirthDate(null != user.getBirthDate()  ? commonMethod.translateDate(user.getBirthDate()) : null);
		user.setRegDtm(null != user.getRegDtm() ? commonMethod.translateDate(user.getRegDtm()) : null);
		user.setModDtm(null != user.getModDtm() ? commonMethod.translateDate(user.getModDtm()) : null);

		return user;
	}

	/**
	 * Transaction 결과 값을 반환 한다.
	 *
	 * @author nks
	 * @param result 결과값
	 * @return 결과값
	 */
	public <T> ResponseEntity<T> returnResultWhenTransaction(int result, Supplier<T> onSuccess)
	{
		if (result == 1) return ResponseEntity.ok(onSuccess.get());
		else if (result == 0) return ResponseEntity.notFound().build();
		else return ResponseEntity.badRequest().build();
	}
}
