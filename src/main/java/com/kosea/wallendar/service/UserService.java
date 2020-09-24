package com.kosea.wallendar.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.kosea.wallendar.domain.FollowVo;
import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.repository.FollowRepository;
import com.kosea.wallendar.repository.UserRepository;
import com.kosea.wallendar.utilities.SHA256Util;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

	private final UserRepository userRepository;

	private final FollowRepository followRepository;

	public void registerUser(UserVo user) {

		String salt = SHA256Util.generateSalt();

		user.setSalt(salt);

		String password = user.getPassword();

		password = SHA256Util.getEncrpyt(password, salt);

		user.setPassword(password);

		userRepository.save(user);

	}

	public void updateWithoutPassword(UserVo user) {

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

	public Optional<UserVo> findByUsertag(String usertag) {

		Optional<UserVo> user = userRepository.findByUsertag(usertag);

		return user;
	}

	public Optional<UserVo> findByEmail(String email) {

		Optional<UserVo> user = userRepository.findByEmail(email);

		return user;
	}

	public UserVo removeUser(String usertag) {

		Optional<UserVo> user = userRepository.findByUsertag(usertag);

		if (user.isPresent()) {
			userRepository.deleteById(user.get().getEmail());
		}
		return user.get();
	}

	public List<FollowVo> findFollowings(String usertag) {

		List<FollowVo> followings = new ArrayList<FollowVo>();

		followRepository.findByUsertag(usertag).forEach(e -> followings.add(e));

		return followings;
	}

	public List<FollowVo> findFollowers(String follow) {

		List<FollowVo> followers = new ArrayList<FollowVo>();

		followRepository.findByFollow(follow).forEach(e -> followers.add(e));

		return followers;
	}

	public void followUser(FollowVo follow) {

		followRepository.save(follow);
	}

	public void unFollowUser(String usertag, String follow) {

		followRepository.deleteByUsertagAndFollow(usertag, follow);
	}

}
