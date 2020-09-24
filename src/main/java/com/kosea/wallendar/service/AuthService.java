package com.kosea.wallendar.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;


@Service
@AllArgsConstructor
public class AuthService{
	public JavaMailSender sender;

	public String sendMail(String email) {
		
		String code = String.format("%06d", (int) (Math.random() * 10000));
		SimpleMailMessage simpleMessage = new SimpleMailMessage();
		simpleMessage.setTo(email);
		simpleMessage.setSubject("Wallendar : Verify Your Account");
		simpleMessage.setText("Verification Code : " + code);
		sender.send(simpleMessage);

		return code;
	}
}
