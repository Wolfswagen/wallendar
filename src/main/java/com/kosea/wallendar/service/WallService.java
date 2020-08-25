package com.kosea.wallendar.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.TagVo;
import com.kosea.wallendar.repository.PostRepository;
import com.kosea.wallendar.repository.TagRepository;

@Service
public class WallService {

	@Autowired
	private PostRepository postRepository;

	@Autowired
	TagRepository tagRepository;

	public List<PostVo> findAll(String usertag) {
		List<PostVo> posts = new ArrayList<PostVo>();

		postRepository.findByUsertag(usertag).forEach(e -> posts.add(e));

		return posts;
	}

	public Optional<PostVo> findOne(String usertag, Date postdate) {

		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();
		
		Optional<PostVo> post = postRepository.findById(pk);

		return post;
	}

	public List<TagVo> findByPk(String usertag, Date postdate) {
		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();
		
		List<TagVo> tags = new ArrayList<TagVo>();

		tagRepository.findById(pk);
		return tags;
	}

}
