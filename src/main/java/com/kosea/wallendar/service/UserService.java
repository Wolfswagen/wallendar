package com.kosea.wallendar.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.repository.UserRepository;
import com.kosea.wallendar.utilities.SHA256Util;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

	@NonNull
	private final UserRepository userRepository;

	public void registerUser(UserVo user) {

		String salt = SHA256Util.generateSalt();
		user.setSalt(salt);

		String password = user.getPassword();
		password = SHA256Util.getEncrpyt(password, salt);

		user.setPassword(password);

		userRepository.save(user);

	}

	public Optional<UserVo> loginUser(String email, String inputPass) {

		Optional<UserVo> user = userRepository.findByEmail(email);

		if (user.isEmpty()) {
			return user;
		} else {
			String salt = user.get().getSalt();
			String password = SHA256Util.getEncrpyt(inputPass, salt);

			Optional<UserVo> login = userRepository.findByEmailAndPassword(email, password);

			return login;
		}
	}

}
