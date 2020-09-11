package com.kosea.wallendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kosea.wallendar.domain.FollowVo;
import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.service.UserService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
public class UserRestController {

	@NonNull
	private final UserService userService;

	@GetMapping(value = "/follow/{usertag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> getFollow(@PathVariable("usertag") String usertag) {

		Map<String, Object> follows = new HashMap<String, Object>();

		List<FollowVo> following = userService.findFollowings(usertag);

		List<FollowVo> follower = userService.findFollowers(usertag);

		follows.put("following", following);

		follows.put("follower", follower);

		return new ResponseEntity<Map<String, Object>>(follows, HttpStatus.OK);

	}

	@PostMapping(value = "/follow", produces = { MediaType.APPLICATION_JSON_VALUE }, consumes = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> followUser(@RequestBody FollowVo follow) {

		userService.followUser(follow);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@DeleteMapping(value = "/follow", produces = { MediaType.APPLICATION_JSON_VALUE }, consumes = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> unfollowUser(@RequestBody FollowVo follow) {

		System.out.println(follow);

		userService.unFollowUser(follow.getUsertag(), follow.getFollow());

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@PostMapping(value = "/register", produces = { MediaType.APPLICATION_JSON_VALUE }, consumes = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> addUser(@RequestBody UserVo user) {

		userService.registerUser(user);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@PostMapping(value = "/login", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> loginUser(@RequestBody HashMap<String, String> userInfo) {

		Map<String, Object> result = new HashMap<String, Object>();

		Optional<UserVo> user = userService.loginUser(userInfo.get("email"), userInfo.get("password"));

		if (user.isPresent()) {
			result.put("usertag", user.get().getUsertag());
		}

		return new ResponseEntity<Map<String, Object>>(result, HttpStatus.OK);

	}

}
