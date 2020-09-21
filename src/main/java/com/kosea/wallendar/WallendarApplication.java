package com.kosea.wallendar;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;

@SpringBootApplication
@EnableEncryptableProperties
public class WallendarApplication {

	public static void main(String[] args) {
		SpringApplication.run(WallendarApplication.class, args);
	}
}