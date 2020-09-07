package com.kosea.wallendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {

	@RequestMapping("/calendar/{usertag}")
	public String calendarView() {
		return "calendar";
	}

	@RequestMapping("/search/{keyword}")
	public String searchView() {
		return "search";
	}

	@RequestMapping("/wall/{postdate}")
	public String wallView() {
		return "wall";
	}

	@RequestMapping()
	public String loginView() {
		return "login";
	}

	@RequestMapping("/register")
	public String registerView() {
		return "register";
	}

}
