package com.dogfeetbirdfeet.ivorypilatesbackend.service.test;

import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Service;

import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.test.TestMapper;

/**
 * @author nks
 * 테스트용 모든 테이블 반환
 */
@Service
public class TestService {

	private final TestMapper testMapper;

	public TestService(TestMapper testMapper) {
		this.testMapper = testMapper;
	}

	public List<?> getTableInfo(String tableName) {

		return testMapper.findAnythingByTableName(returnCamelCaseByTableName(tableName));
	}

	private String returnCamelCaseByTableName(String input) {

		if (input == null) {
			return null;
		}
		String str = input.trim();
		if (str.isEmpty()) {
			return str;
		}

		// 1) 이상한 구분자 정리
		str = str.replaceAll("[^A-Za-z0-9]+", "_");

		// 2) 단어 경계 삽입 (약어/연속 대문자 보존)
		// ...ABCDef -> ABC_Def (약어 + 일반 단어)
		str = str.replaceAll("([A-Z]+)([A-Z][a-z])", "$1_$2");
		// ...aB -> a_B (소문자/숫자 + 대문자)
		str = str.replaceAll("([a-z\\d])([A-Z])", "$1_$2");
		// 문자/숫자 경계
		str = str.replaceAll("([A-Za-z])(\\d)", "$1_$2")
			.replaceAll("(\\d)([A-Za-z])", "$1_$2");

		// 3) 언더스코어 정리
		str = str.replaceAll("_+", "_")
			.replaceAll("^_+|_+$", "");

		return str.toUpperCase(Locale.ROOT);

	}
}
