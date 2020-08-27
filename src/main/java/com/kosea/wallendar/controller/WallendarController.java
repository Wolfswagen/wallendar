package com.kosea.wallendar.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.TagVo;
import com.kosea.wallendar.service.WallService;

@RestController
@RequestMapping("/wall/{usertag}")
public class WallendarController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	WallService service;

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	@GetMapping(produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelAndView getPosts(@PathVariable("usertag") String usertag) {
		ModelAndView mav = new ModelAndView("calendar");

		List<PostVo> posts = service.findAll(usertag);

		mav.addObject("posts", posts);

		return mav;
	}

	@GetMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ModelAndView getOnePost(@PathVariable("usertag") String usertag, @PathVariable("postdate") String postdate)
			throws Exception {

		ModelAndView mav = new ModelAndView("wall");

		PostVo post = service.findOne(usertag, df.parse(postdate)).get();

		List<TagVo> tags = service.findTags(usertag, df.parse(postdate));


		mav.addObject("post", post);

		mav.addObject("tags", tags);

		return mav;
	}

	@PostMapping(produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> savePost(@PathVariable("usertag") String usertag, String postdate, byte[] pic)
			throws Exception {

		PostVo post = PostVo.builder().usertag(usertag).postdate(df.parse(postdate)).build();

		service.savePost(post);
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@PutMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> updateTags(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate, List<TagVo> deleteTags, List<TagVo> saveTags) throws Exception {
		if (!deleteTags.isEmpty()) {
			service.deleteTags(deleteTags);
		}
		if (!saveTags.isEmpty()) {
			service.saveTags(saveTags);
		}
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@DeleteMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> deletePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate) throws Exception {
		service.deletePost(usertag, df.parse(postdate));
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}
}
