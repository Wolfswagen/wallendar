package com.kosea.wallendar.utilities;

import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.PBEConfig;
import org.jasypt.encryption.pbe.config.SimplePBEConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JasyptConfig {
	private static final String ENCRYPT_KEY = "kosea";

	@Bean("jasyptStringEncryptor")
	public StringEncryptor stringEncryptor() {
		PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();
		SimplePBEConfig config = new SimplePBEConfig();
		config.setPassword(ENCRYPT_KEY);
		config.setAlgorithm("PBEwithMD5AndDes");
		config.setPoolSize(1);
		config.setSaltGeneratorClassName("org.jasypt.salt.RandomSaltGenerator");

		encryptor.setConfig(config);

		return encryptor;
	}

}
