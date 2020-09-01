package com.kosea.wallendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WallendarController {
	
	@RequestMapping("/wall")
	public String calendarView() {
		return "calendar";
	}
	
	@RequestMapping("/wall/post")
	public String wallView() {
		return "wall";
	}


}
