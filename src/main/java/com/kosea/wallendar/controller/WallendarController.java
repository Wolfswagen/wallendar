package com.kosea.wallendar.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.TagVo;
import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.service.WallendarService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class WallendarController {

	WallendarService service;

	@RequestMapping("/home")
	public String home() {
		return "home";
	}

	@RequestMapping("/wall")
	public ModelAndView testview() throws Exception {
		ModelAndView mav = new ModelAndView("wall");
		
		

		PostVo post = service.getPost(service.getUser("test@email.com").getUsertag());

		List<TagVo> tags = service.getTags(post);

		mav.addObject("post", post);

		mav.addObject("tags", tags);

		return mav;
	}
}
