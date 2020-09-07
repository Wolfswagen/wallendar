package com.kosea.wallendar.service;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;


import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.repository.UserRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UserSeviceTest {
	
	
	UserService userService;
	
	
	@Test
	public void addtest() {
		
		UserRepository repo = Mockito.mock(UserRepository.class);
		
		
		String email = "test@naver.com";
		String password = "test1";
		
		
		
		
		log.info(userService.loginUser(email, password).get().toString());
		
	}
}
