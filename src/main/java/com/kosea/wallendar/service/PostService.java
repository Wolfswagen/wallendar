package com.kosea.wallendar.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.kosea.wallendar.domain.LikeVo;
import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.ReplyVo;
import com.kosea.wallendar.repository.LikeRepository;
import com.kosea.wallendar.repository.PostRepository;
import com.kosea.wallendar.repository.ReplyRepository;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PostService {

	@NonNull
	private final PostRepository postRepository;

	@NonNull
	private final ReplyRepository replyRepository;

	@NonNull
	private final LikeRepository likeRepository;

	public PostVo savePost(PostVo post) {
		postRepository.save(post);

		return post;
	}

	public void likePost(LikeVo like) {
		likeRepository.save(like);
	}

	public void unlikePost(int lno) {
		likeRepository.deleteById(lno);
	}

	public ReplyVo saveComment(ReplyVo comment) {
		replyRepository.save(comment);

		return comment;
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

	public List<PostVo> SearchByPostDate(Date postdate) {

		List<PostVo> posts = new ArrayList<PostVo>();

		postRepository.findByPostdate(postdate).forEach(e -> posts.add(e));

		return posts;

	}

	public List<PostVo> searchByTag(String tag) {

		List<PostVo> posts = new ArrayList<PostVo>();

		postRepository.findByTagsContaining("#" + tag + "#").forEach(e -> posts.add(e));

		return posts;

	}

	public void updateById(String usertag, Date postdate, PostVo post) {

		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();

		Optional<PostVo> e = postRepository.findById(pk);

		System.out.println(e.get() + "/" + post);

		if (e.isPresent()) {
			if (post.getPic() == null) {
				post.setPic(e.get().getPic());
			}

			post.setLikes(e.get().getLikes());
			post.setReply(e.get().getReply());

			postRepository.save(post);
		}
	}

	public void deletePost(String usertag, Date postdate) {
		PkPost pk = PkPost.builder().usertag(usertag).postdate(postdate).build();
		postRepository.deleteById(pk);
	}

	public void deleteComment(int rno) {

		replyRepository.deleteById(rno);
	}

}
