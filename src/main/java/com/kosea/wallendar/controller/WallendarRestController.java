package com.kosea.wallendar.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kosea.wallendar.domain.LikeVo;
import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.ReplyVo;
import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.service.UserService;
import com.kosea.wallendar.service.PostService;
import com.kosea.wallendar.service.S3UploadService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/post")
@RequiredArgsConstructor
public class WallendarRestController {

	private final PostService postService;

	private final UserService userService;

	private final S3UploadService upService;

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	@GetMapping(value = "/{tag}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Map<String, Object>> searchTag(@PathVariable("tag") String tag) {

		Optional<UserVo> user = userService.findByUsertag(tag);

		List<PostVo> userPost = postService.findAll(tag);

		List<PostVo> tagPost = postService.searchByTag(tag);

		Map<String, Object> posts = new HashMap<String, Object>();

		if (user.isPresent()) {
			user.get().setPassword("");
			user.get().setSalt("");
			posts.put("user", user.get());
		} else {
			posts.put("user", "");
		}

		posts.put("userpost", userPost);

		posts.put("tagpost", tagPost);

		return new ResponseEntity<Map<String, Object>>(posts, HttpStatus.OK);

	}

	@GetMapping(value = "/date/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<PostVo>> searchPostdate(@PathVariable("postdate") String postdate) throws Exception {

		List<PostVo> posts = postService.SearchByPostDate(df.parse(postdate));

		return new ResponseEntity<List<PostVo>>(posts, HttpStatus.OK);
	}

	@GetMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<PostVo> getOnePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate) throws Exception {

		Optional<PostVo> post = postService.findOne(usertag, df.parse(postdate));

		if (post.isPresent()) {
			return new ResponseEntity<PostVo>(post.get(), HttpStatus.OK);
		} else {
			return new ResponseEntity<PostVo>(HttpStatus.NO_CONTENT);
		}

	}

	@PostMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> savePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate, @RequestParam MultipartFile upload, @RequestParam String tags)
			throws Exception {

		String key = usertag + "_" + postdate + "_";

		PostVo post = PostVo.builder().usertag(usertag).postdate(df.parse(postdate)).tags(tags)
				.pic(upService.upload(upload, key)).build();

		postService.savePost(post);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@PutMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> updatePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate, @RequestParam(required = false) MultipartFile upload,
			@RequestParam String tags) throws Exception {

		PostVo post = PostVo.builder().usertag(usertag).postdate(df.parse(postdate)).tags(tags).build();

		if (upload != null) {
			upService.delete(post.getPic());
			String key = usertag + "_" + postdate + "_";
			post.setPic(upService.upload(upload, key));
		}

		postService.updateById(usertag, df.parse(postdate), post);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@DeleteMapping(value = "/{usertag}/{postdate}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> deletePost(@PathVariable("usertag") String usertag,
			@PathVariable("postdate") String postdate) throws Exception {

		PostVo post = postService.deletePost(usertag, df.parse(postdate));

		upService.delete(post.getPic());

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

//	comments

	@PostMapping(value = "/comment", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> addComments(@RequestBody ReplyVo reply) throws Exception {

		String postdate = df.format(reply.getPostdate());

		reply.setPostdate(df.parse(postdate));

		postService.saveComment(reply);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

	@DeleteMapping(value = "/comment/{rno}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> deleteComment(@PathVariable("rno") int rno) throws Exception {

		postService.deleteComment(rno);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}

//	likes

	@PostMapping(value = "/like", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> addLike(@RequestBody LikeVo like) throws Exception {

		String postdate = df.format(like.getPostdate());

		like.setPostdate(df.parse(postdate));

		postService.likePost(like);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);

	}

	@DeleteMapping(value = "/like/{lno}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Void> addDelete(@PathVariable("lno") int lno) {

		postService.unlikePost(lno);

		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);

	}
}
