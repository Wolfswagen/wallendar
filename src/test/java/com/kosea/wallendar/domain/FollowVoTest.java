package com.kosea.wallendar.domain;

import java.util.Optional;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kosea.wallendar.repository.FollowRepository;
import com.kosea.wallendar.repository.UserRepository;

@SpringBootTest
@Transactional
public class FollowVoTest {

	@Autowired
	FollowRepository followRepository;

	@Autowired
	UserRepository userRepository;

	@Test
	public void run() {

		Optional<UserVo> user = userRepository.findByEmail("regtest@naver.com");

		String usertag = user.get().getUsertag();		
		
		 userRepository.save(user.get()); 
		 
		 System.out.println(userRepository.findByEmail("regtest@naver.com").get());

		

	}

}
