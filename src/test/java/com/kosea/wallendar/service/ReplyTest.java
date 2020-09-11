package com.kosea.wallendar.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.ReplyVo;
import com.kosea.wallendar.repository.PostRepository;
import com.kosea.wallendar.repository.ReplyRepository;

@SpringBootTest
@Transactional
public class ReplyTest {

	@Autowired
	private PostRepository pr;

	@Autowired
	private ReplyRepository mr;

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	@Test
	public void run() throws Exception {

		String usertag = "test";
		Date postdate = df.parse("2020-09-08");
		PostVo post = PostVo.builder().usertag(usertag).postdate(postdate).tags("test").pic("test").build();

		post.addReply(ReplyVo.builder().contents("test1").writer("test1").build());

		post.addReply(ReplyVo.builder().contents("test2").writer("test2").build());

		PkPost id = PkPost.builder().usertag(usertag).postdate(postdate).build();

		Optional<PostVo> p = pr.findById(id);

		System.out.println(p.get());
	}
}
