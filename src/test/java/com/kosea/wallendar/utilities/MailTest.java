package com.kosea.wallendar.utilities;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kosea.wallendar.service.AuthService;

@SpringBootTest
public class MailTest {
	@Autowired
	AuthService mail;
	
	@Test
	public void sendMail() {
		System.out.println(mail.sendMail("asy8000@naver.com"));
	}
}
