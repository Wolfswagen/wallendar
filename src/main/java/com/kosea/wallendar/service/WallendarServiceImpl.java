package com.kosea.wallendar.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.TagVo;
import com.kosea.wallendar.domain.UserVo;
import com.kosea.wallendar.mapper.WallendarMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class WallendarServiceImpl implements WallendarService {

	public WallendarMapper mapper;

	@Override
	public List<UserVo> getUserList() {
		return mapper.getUserList();
	}

	@Override
	public UserVo getUser(String email) {
		return mapper.getUser(email);
	}

	@Override
	public List<PostVo> getPostList(String email) {
		return mapper.getPostList(email);
	}

	@Override
	public PostVo getPost(String usertag) {
		return mapper.getPost(usertag);
	}

	@Override
	public List<TagVo> getTags(PostVo post) {
		return mapper.getTags(post);
	}

}
