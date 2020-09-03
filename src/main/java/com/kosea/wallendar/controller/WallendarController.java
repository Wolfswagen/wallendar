package com.kosea.wallendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WallendarController {
	
	@RequestMapping("/calendar/{usertag}")
	public String calendarView() {
		return "calendar";
	}
	
	
	@RequestMapping("/wall/")
	public void wallView() {
		
	}

}
