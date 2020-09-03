package com.kosea.wallendar.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
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
@RequestMapping("/{usertag}")
public class CalendarRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	WallendarService service;

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	@GetMapping(produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<PostVo>> getPosts(@PathVariable("usertag") String usertag) {

		List<PostVo> posts = service.findAll(usertag);

		return new ResponseEntity<List<PostVo>>(posts, HttpStatus.OK);
	}

	@GetMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<PostVo> getOnePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate) throws Exception {

		Optional<PostVo> post = service.findOne(usertag, df.parse(postdate));

		if (post.isPresent()) {
			return new ResponseEntity<PostVo>(post.get(), HttpStatus.OK);
		} else {
			return new ResponseEntity<PostVo>(HttpStatus.NO_CONTENT);
		}

	}

	@PostMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
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

	@PutMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> updatePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate, @RequestParam MultipartFile upload, @RequestParam String tags)
			throws Exception {

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

		PostVo post = PostVo.builder().usertag(usertag).postdate(df.parse(postdate)).pic(picPath).tags(tags).build();

		service.updateById(usertag, df.parse(postdate), post);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@DeleteMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> deletePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate) throws Exception {
		service.deletePost(usertag, df.parse(postdate));
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

}
