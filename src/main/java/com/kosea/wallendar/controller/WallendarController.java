package com.kosea.wallendar.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.service.WallService;

@RestController
@RequestMapping("/wall")
public class WallendarController {

	@Autowired
	WallService service;


	@GetMapping(value = { "/{usertag}" })
	public ResponseEntity<List<PostVo>> getPosts(@PathVariable("usertag") String usertag) {
		
		
		List<PostVo> posts = service.findAll(usertag);

		return new ResponseEntity<List<PostVo>>(posts, HttpStatus.OK);
	} 
	
}
