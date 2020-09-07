package com.kosea.wallendar.utilities;

import java.security.MessageDigest;
import java.util.Random;

public class SHA256Util {

	public static String getEncrpyt(String source, String salt) {

		return getEncrypt(source, salt.getBytes());
	}

	public static String getEncrypt(String source, byte[] salt) {
		String result = "";

		byte[] src = source.getBytes();
		byte[] bytes = new byte[src.length + salt.length];

		System.arraycopy(src, 0, bytes, 0, src.length);
		System.arraycopy(salt, 0, bytes, src.length, salt.length);

		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(bytes);

			byte[] byteData = md.digest();

			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));

			}
			result = sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String generateSalt() {
		Random random = new Random();

		byte[] salt = new byte[8];
		random.nextBytes(salt);

		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < salt.length; i++) {
			sb.append(String.format("%02x", salt[i]));
		}

		return sb.toString();
	}

}
