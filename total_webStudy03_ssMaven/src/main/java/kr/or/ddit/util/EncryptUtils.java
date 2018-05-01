package kr.or.ddit.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;

public class EncryptUtils {
	public static String oneWayEncryptWithSha256(String plain) throws NoSuchAlgorithmException{
		//단방향암호화 (SHA2-256)
		MessageDigest md = MessageDigest.getInstance("sha-256");
		//암호화
		byte[] encrtyped = md.digest(plain.getBytes()); // 웹이 인식할 수있는 인코딩. // 암호화 방식이 접목되어 암호화됨 (256비트로)
		System.out.println(encrtyped.length);
		//부호화
		String encoded = Base64.encodeBase64String(encrtyped); //이것과 db에 저장된 암호화를 비교
		
		return encoded;
		
	}
}
