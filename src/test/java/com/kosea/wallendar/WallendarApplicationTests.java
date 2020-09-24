package com.kosea.wallendar;

import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimplePBEConfig;
import org.junit.jupiter.api.Test;

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
	}
}
