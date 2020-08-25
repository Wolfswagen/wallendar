package com.kosea.wallendar.domain;

import static org.assertj.core.api.Assertions.assertThat;
import java.util.Date;

import org.junit.jupiter.api.Test;

public class PkTest {

	@Test
	public void pkTest() {
		PostVo post = PostVo.builder().usertag("test").postdate(new Date()).build();
		
		TagVo tag = TagVo.builder().usertag("test").postdate(post.getPostdate()).tag("tag").build();
		
		
	}
}
