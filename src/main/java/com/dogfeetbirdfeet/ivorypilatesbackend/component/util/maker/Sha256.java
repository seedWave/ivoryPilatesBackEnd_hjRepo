package com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Value;

/**
 * @author nks
 * @apiNote SHA_256 암호화
 */
public class Sha256 {

	@Value("${salt}")
	private static String salt;

	/**
	 * 평문을 SHA-256 방식으로 암호화한다.
	 * @param plainTest 암호화할 평문
	 * @return 암호화된 텍스트
	 * @throws NoSuchAlgorithmException 암호화 안 될 경우 대비
	 */
	public String decData(String plainTest) throws NoSuchAlgorithmException {

		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update((plainTest + salt).getBytes());

		return bytesToHex(md.digest());
	}

	/**
	 * byte to String
	 * @param bytes 대상 바이트
	 * @return String 반환
	 */
	public String bytesToHex(byte[] bytes) {

		StringBuilder builder = new StringBuilder();

		for (byte b : bytes) {
			builder.append(String.format("%02x", b));
		}

		return builder.toString();
	}
}
