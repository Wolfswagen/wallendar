package com.kosea.wallendar.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.PkTags;
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

	public PostVo savePost(PostVo post) {
		postRepository.save(post);

		return post;
	}

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

	public void updatePost(String usertag, Date postdate, byte[] pic) {
		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();
		Optional<PostVo> e = postRepository.findById(pk);

		if (e.isPresent()) {
			PostVo post = PostVo.builder().usertag(usertag).postdate(postdate).pic(pic).build();

			postRepository.save(post);
		}
	}

	public void deletePost(String usertag, Date postdate) {
		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();
		postRepository.deleteById(pk);
	}

//	tags crud

	public List<TagVo> saveTag(List<TagVo> tags) {
		tagRepository.saveAll(tags);

		return tags;
	}

	public List<TagVo> findTags(String usertag, Date postdate) {

		List<TagVo> tags = new ArrayList<TagVo>();

		tagRepository.findByUsertagAndPostdate(usertag, postdate).forEach(e -> tags.add(e));

		return tags;
	}

	public void updateTag(String usertag, Date postdate, String original, String target) {
		PkTags pk = PkTags.builder().usertag(usertag).postdate(postdate).tag(original).build();
		Optional<TagVo> e = tagRepository.findById(pk);

		if (e.isPresent()) {
			TagVo tag = TagVo.builder().usertag(usertag).postdate(postdate).tag(target).build();
			tagRepository.deleteById(pk);
			tagRepository.save(tag);
		}
	}

	public void voidTag(String usertag, Date postdate, String tag) {
		PkTags pk = PkTags.builder().usertag(usertag).postdate(postdate).tag(tag).build();

		tagRepository.deleteById(pk);
	}

}
