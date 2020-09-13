package com.kosea.wallendar.controller;

import java.io.File;
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

	@PostMapping(value = "/register", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> addUser(@RequestParam String email, @RequestParam String password,
			@RequestParam String username, @RequestParam String usertag,
			@RequestParam(required = false) MultipartFile upload) {

		UserVo user = UserVo.builder().email(email).username(username).usertag(usertag).password(password).build();

		Optional<UserVo> userbyemail = userService.findByEmail(email);

		Optional<UserVo> userbytag = userService.findByUsertag(usertag);

		Map<String, Object> userCheck = new HashMap<String, Object>();

		if (upload != null) {
			String upPath = "C:/Users/K-joon/git/wallendar/src/main/resources/static/upload/" + usertag;

			String pic = upload.getOriginalFilename().replaceAll(" ", "_");

			pic = "userimg_" + pic.substring(pic.lastIndexOf("\\") + 1);

			File saveDir = new File(upPath);

			File savePic = new File(upPath, pic);

			if (saveDir.exists()) {
				try {
					upload.transferTo(savePic);
				} catch (Exception e) {
					log.info(e.getMessage());
				}
			} else {
				saveDir.mkdir();
				log.info("mkdir : " + String.valueOf(saveDir.exists()));
				try {
					upload.transferTo(savePic);
				} catch (Exception e) {
					log.info(e.getMessage());
				}
			}
			String picPath = "upload/" + usertag + "/" + pic;
			user.setUserimg(picPath);
		}

		if (userbyemail.isPresent()) {
			userCheck.put("email", true);
		} else if (userbytag.isPresent()) {
			userCheck.put("usertag", true);
		} else {
			userService.registerUser(user);
		}

		return new ResponseEntity<Map<String, Object>>(userCheck, HttpStatus.OK);
	}

	@PostMapping(value = "/login", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> loginUser(@RequestBody HashMap<String, String> userInfo) {

		Map<String, Object> result = new HashMap<String, Object>();

		Optional<UserVo> user = userService.loginUser(userInfo.get("email"), userInfo.get("password"));

		if (user.isPresent()) {
			result.put("usertag", user.get().getUsertag());
			result.put("userimg", user.get().getUserimg());
		}

		return new ResponseEntity<Map<String, Object>>(result, HttpStatus.OK);

	}

	@GetMapping(value = "/{usertag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<UserVo> getUser(@PathVariable("usertag") String usertag) {

		Optional<UserVo> user = userService.findByUsertag(usertag);

		UserVo result = UserVo.builder().userimg(user.get().getUserimg()).bgimg(user.get().getBgimg()).build();

		return new ResponseEntity<UserVo>(result, HttpStatus.OK);
	}

	@PutMapping(value = "/{usertag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> updateUser(@RequestParam String password, @RequestParam String username,
			@PathVariable("usertag") String usertag, @RequestParam(required = false) MultipartFile upload) {

		Optional<UserVo> user = userService.findByUsertag(usertag);

		if (user.isPresent()) {
			user.get().setPassword(password);
			user.get().setUsername(username);
			user.get().setUsertag(usertag);
			if (upload != null) {
				String upPath = "C:/Users/K-joon/git/wallendar/src/main/resources/static/upload/" + usertag;

				String pic = upload.getOriginalFilename().replaceAll(" ", "_");

				pic = "userimg_" + pic.substring(pic.lastIndexOf("\\") + 1);

				File saveDir = new File(upPath);

				File savePic = new File(upPath, pic);

				if (saveDir.exists()) {
					try {
						upload.transferTo(savePic);
					} catch (Exception e) {
						log.info(e.getMessage());
					}
				} else {
					saveDir.mkdir();
					log.info("mkdir : " + String.valueOf(saveDir.exists()));
					try {
						upload.transferTo(savePic);
					} catch (Exception e) {
						log.info(e.getMessage());
					}
				}
				String picPath = "upload/" + usertag + "/" + pic;
				user.get().setUserimg(picPath);
			}
			userService.registerUser(user.get());
		}

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@PutMapping(value = "/background/{usertag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> setBackground(@PathVariable("usertag") String usertag,
			@RequestParam MultipartFile upload) {
		Optional<UserVo> user = userService.findByUsertag(usertag);

		if (user.isPresent()) {
			String upPath = "C:/Users/K-joon/git/wallendar/src/main/resources/static/upload/" + usertag;

			String pic = upload.getOriginalFilename().replaceAll(" ", "_");

			pic = "bgimg_" + pic.substring(pic.lastIndexOf("\\") + 1);

			File saveDir = new File(upPath);

			File savePic = new File(upPath, pic);

			if (saveDir.exists()) {
				try {
					upload.transferTo(savePic);
				} catch (Exception e) {
					log.info(e.getMessage());
				}
			} else {
				saveDir.mkdir();
				log.info("mkdir : " + String.valueOf(saveDir.exists()));
				try {
					upload.transferTo(savePic);
				} catch (Exception e) {
					log.info(e.getMessage());
				}
			}
			String picPath = "upload/" + usertag + "/" + pic;
			user.get().setBgimg(picPath);
			userService.registerUser(user.get());
		}

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

}
