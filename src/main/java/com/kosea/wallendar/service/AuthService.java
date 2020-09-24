package com.kosea.wallendar.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;


@Service
public class AuthService{
	@Autowired
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
