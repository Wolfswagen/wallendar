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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kosea.wallendar.domain.FollowVo;
import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.service.AuthService;
import com.kosea.wallendar.service.S3UploadService;
import com.kosea.wallendar.service.UserService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
public class UserRestController {

	private final UserService userService;

	private final AuthService authService;

	private final S3UploadService upService;

	@GetMapping(value = "/{usertag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<UserVo> getUser(@PathVariable("usertag") String usertag) {

		Optional<UserVo> user = userService.findByUsertag(usertag);

		user.get().setPassword("");

		user.get().setSalt("");

		return new ResponseEntity<UserVo>(user.get(), HttpStatus.OK);
	}

	@PostMapping(value = "/mail", produces = { MediaType.APPLICATION_JSON_VALUE }, consumes = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, String>> sendEmail(@RequestBody Map<String, String> email) {
		Map<String, String> result = new HashMap<>();
		Optional<UserVo> user = userService.findByEmail(email.get("email"));
		if (user.isPresent()) {
			result.put("code", authService.sendMail(email.get("email")));
			result.put("usertag", user.get().getUsertag());
		}
		return new ResponseEntity<Map<String, String>>(result, HttpStatus.ACCEPTED);
	}

	@PostMapping(value = "/register", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> addUser(@RequestParam String userinfo,
			@RequestParam(required = false) MultipartFile upload) throws Exception {

		ObjectMapper objectMapper = new ObjectMapper();

		UserVo user = objectMapper.readValue(userinfo, UserVo.class);

		Optional<UserVo> userbyemail = userService.findByEmail(user.getEmail());

		Optional<UserVo> userbytag = userService.findByUsertag(user.getUsertag());

		Map<String, Object> userCheck = new HashMap<String, Object>();

		if (userbyemail.isPresent()) {
			userCheck.put("email", true);
		} else if (userbytag.isPresent()) {
			userCheck.put("usertag", true);
		} else {
			if (upload != null) {
				String key = user.getUsertag() + "_profile_";
				user.setProfileimg(upService.upload(upload, key));
			}
			userService.registerUser(user);
		}

		return new ResponseEntity<Map<String, Object>>(userCheck, HttpStatus.OK);
	}

	@PostMapping(value = "/login", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<UserVo> loginUser(@RequestBody HashMap<String, String> userInfo) {

		Optional<UserVo> user = userService.loginUser(userInfo.get("email"), userInfo.get("password"));

		if (user.isPresent()) {
			user.get().setPassword("");
			user.get().setSalt("");
			return new ResponseEntity<UserVo>(user.get(), HttpStatus.OK);
		} else {
			return new ResponseEntity<UserVo>(HttpStatus.NO_CONTENT);
		}
	}

	@PutMapping(value = "/{usertag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Boolean> updateUser(@PathVariable("usertag") String usertag,
			@RequestParam(required = false) String userinfo, @RequestParam(required = false) MultipartFile upload)
			throws Exception {

		ObjectMapper objectMapper = new ObjectMapper();

		UserVo user = objectMapper.readValue(userinfo, UserVo.class);

		Optional<UserVo> getuser = userService.findByUsertag(usertag);

		if (getuser.isPresent()) {
			if (user.getUsertag() != null) {
				if (userService.findByUsertag(user.getUsertag()).isEmpty()) {
					getuser.get().setUsertag(user.getUsertag());
				} else {
					return new ResponseEntity<Boolean>(false, HttpStatus.OK);
				}
			}

			if (user.getUsername() != null) {
				getuser.get().setUsername(user.getUsername());
			}

			if (upload != null) {
				String key = getuser.get().getUsertag() + "_profile_";
				getuser.get().setProfileimg(upService.upload(upload, key));
			}
			if (user.getPassword() != null) {
				getuser.get().setPassword(user.getPassword());
				userService.registerUser(getuser.get());
			} else {
				userService.updateWithoutPassword(getuser.get());
			}
		}

		return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	}

	@PutMapping(value = "/{usertag}/backimg", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> setBackground(@PathVariable("usertag") String usertag,
			@RequestParam(required = false) MultipartFile upload) throws Exception {

		UserVo user = userService.findByUsertag(usertag).get();
		if (upload != null) {
			String key = user.getUsertag() + "_back_";
			user.setBackimg(upService.upload(upload, key));
			userService.updateWithoutPassword(user);
		} else {
			user.setBackimg(null);
			userService.updateWithoutPassword(user);
		}

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@DeleteMapping(value = "/delete/{usertag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> deleteUser(@PathVariable("usertag") String usertag) {

		UserVo user = userService.removeUser(usertag);

		upService.delete(user.getBackimg());
		upService.delete(user.getProfileimg());

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

//	follow control

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

		userService.unFollowUser(follow.getUsertag(), follow.getFollow());

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

}
