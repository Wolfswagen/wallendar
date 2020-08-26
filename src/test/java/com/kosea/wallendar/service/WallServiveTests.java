package com.kosea.wallendar.service;


import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;


import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;

import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;

import org.springframework.test.web.servlet.MockMvc;

import com.kosea.wallendar.controller.WallendarController;


import lombok.extern.slf4j.Slf4j;

@WebMvcTest(WallendarController.class)
@Slf4j
public class WallServiveTests {

	@Autowired
	MockMvc mvc;

	@MockBean
	private WallService service;

	@Test
	public void getPosts() throws Exception {


		mvc.perform(get("/wall/kosea").contentType(MediaType.APPLICATION_JSON)).andDo(print());


	}

}
