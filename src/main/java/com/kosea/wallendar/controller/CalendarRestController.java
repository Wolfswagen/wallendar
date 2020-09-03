package com.kosea.wallendar.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.service.WallendarService;

@RestController
@RequestMapping("/post")
public class CalendarRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	WallendarService service;

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	@GetMapping(value = "{tag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> searchTag(@PathVariable("tag") String tag) {

		logger.info(tag);

		List<PostVo> userPost = service.findAll(tag);

		List<PostVo> tagPost = service.searchByTag(tag);

		Map<String, Object> posts = new HashMap<String, Object>();

		posts.put("userpost", userPost);

		posts.put("tagpost", tagPost);

		return new ResponseEntity<Map<String, Object>>(posts, HttpStatus.OK);
	}

	@GetMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<PostVo> getOnePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate) throws Exception {

		Optional<PostVo> post = service.findOne(usertag, df.parse(postdate));

		if (post.isPresent()) {
			return new ResponseEntity<PostVo>(post.get(), HttpStatus.OK);
		} else {
			return new ResponseEntity<PostVo>(HttpStatus.NO_CONTENT);
		}

	}

	@PostMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> savePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate, @RequestParam MultipartFile upload, @RequestParam String tags)
			throws Exception {

		String upPath = "C:/Users/K-joon/git/wallendar/src/main/resources/static/upload/" + usertag;

		String pic = upload.getOriginalFilename().replaceAll(" ", "_");

		pic = postdate + "_" + pic.substring(pic.lastIndexOf("\\") + 1);

		File saveDir = new File(upPath);

		File savePic = new File(upPath, pic);

		if (saveDir.exists()) {
			try {
				upload.transferTo(savePic);
			} catch (Exception e) {
				logger.info(e.getMessage());
			}
		} else {
			saveDir.mkdir();
			logger.info("mkdir : " + String.valueOf(saveDir.exists()));
			try {
				upload.transferTo(savePic);
			} catch (Exception e) {
				logger.info(e.getMessage());
			}
		}

		String picPath = "upload/" + usertag + "/" + pic;

		PostVo post = PostVo.builder().usertag(usertag).postdate(df.parse(postdate)).pic(picPath).tags(tags).build();
		service.savePost(post);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@PutMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> updatePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate, @RequestParam(required = false) MultipartFile upload,
			@RequestParam String tags) throws Exception {

		PostVo post = PostVo.builder().usertag(usertag).postdate(df.parse(postdate)).tags(tags).build();

		if (upload != null) {
			String upPath = "C:/Users/K-joon/git/wallendar/src/main/resources/static/upload/" + usertag;

			String pic = upload.getOriginalFilename();

			pic = postdate + "_" + upload.getOriginalFilename().replaceAll(" ", "_");

			File saveDir = new File(upPath);

			File savePic = new File(upPath, pic);

			if (saveDir.exists()) {
				try {
					upload.transferTo(savePic);
				} catch (Exception e) {
					logger.info(e.getMessage());
				}
			} else {
				saveDir.mkdir();
				logger.info("mkdir : " + String.valueOf(saveDir.exists()));
				try {
					upload.transferTo(savePic);
				} catch (Exception e) {
					logger.info(e.getMessage());
				}
			}

			String picPath = "upload/" + usertag + "/" + pic;
			post.setPic(picPath);
		}

		service.updateById(usertag, df.parse(postdate), post);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@DeleteMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> deletePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate) throws Exception {
		service.deletePost(usertag, df.parse(postdate));
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

}
