package com.kosea.wallendar.domain;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kosea.wallendar.repository.LikeRepository;
import com.kosea.wallendar.repository.PostRepository;

@SpringBootTest
@Transactional
public class LikeVoTest {

	@Autowired
	LikeRepository likeRepository;

	@Autowired
	PostRepository postRepository;

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	@Test
	public void run() throws ParseException {

		String usertag = "test";
		Date postdate = df.parse("2020-09-08");
		
		PkPost id = PkPost.builder().usertag(usertag).postdate(postdate).build();

		Optional<PostVo> p = postRepository.findById(id);

		p.get().addLike(LikeVo.builder().likeduser("kosea").build());
		
		p.get().addLike(LikeVo.builder().likeduser("kosea2020").build());
		
		postRepository.save(p.get());

		System.out.println(postRepository.findById(id).get());

	}

}
