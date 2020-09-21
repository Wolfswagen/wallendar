package com.kosea.wallendar;

import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimplePBEConfig;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class WallendarApplicationTests {

	@Test
	void contextLoads() {
		
		PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();
		SimplePBEConfig config = new SimplePBEConfig();
		config.setPassword("kosea");
		config.setAlgorithm("PBEwithMD5AndDes");
		config.setPoolSize(1);
		config.setSaltGeneratorClassName("org.jasypt.salt.RandomSaltGenerator");
		encryptor.setConfig(config);
		
		System.out.println(encryptor.decrypt("RkSP/lDWjQ4Yqu9EXjZpoJSjArfTHm8iCzl+SGcQsIY="));
		System.out.println(encryptor.decrypt("MwB4lBC3Sidf6a6c33G1sHxaDR0J6mMH"));
	}
}
