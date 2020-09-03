package com.kosea.wallendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {
	
	@RequestMapping("/calendar/{usertag}")
	public String calendarView() {
		return "calendar";
	}
	
	
	@RequestMapping("/wall/{keyword}")
	public String wallView() {
		return "wall";
	}

}
