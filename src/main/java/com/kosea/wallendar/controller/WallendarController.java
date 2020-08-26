package com.kosea.wallendar.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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
@RequestMapping("/{usertag}")
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

		logger.info(usertag);

		logger.info(tags.toString());

		mav.addObject("post", post);

		mav.addObject("tags", tags);

		return mav;
	}

	@PostMapping(produces = { MediaType.APPLICATION_JSON_VALUE })
	public String savePost(@PathVariable("usertag") String usertag, String postdate, byte[] pic) throws Exception {
		PostVo post = PostVo.builder().usertag(usertag).postdate(df.parse(postdate)).build();

		service.savePost(post);

		return "redirect:/" + usertag + "/" + postdate;
	}

	@PutMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public String updatePost(@PathVariable("usertag") String usertag, @PathVariable("postdate") String postdate,
			byte[] pic) throws Exception {

		service.updatePost(usertag, df.parse(postdate), pic);

		return "redirect:/" + usertag + "/" + postdate;
	}

	@DeleteMapping(value = "/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public String deletePost(@PathVariable("usertag") String usertag, @PathVariable("postdate") String postdate)
			throws Exception {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		service.deletePost(usertag, df.parse(postdate));

		return "redirect:/" + usertag;
	}
}
