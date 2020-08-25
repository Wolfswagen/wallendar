package com.kosea.wallendar.service;

import static org.hamcrest.CoreMatchers.is;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;

import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

import com.kosea.wallendar.controller.WallendarController;

import com.kosea.wallendar.domain.PostVo;

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

		List<PostVo> posts = service.findAll("test");

		when(service.findAll("test")).thenReturn(posts);

		final ResultActions actions = mvc.perform(get("/test").contentType(MediaType.APPLICATION_JSON)).andDo(print());

		actions.andExpect(status().isOk()).andExpect(content().contentType(MediaType.APPLICATION_JSON))
				.andExpect(jsonPath("$usertag", is("test"))).andDo(print());

	}

}
