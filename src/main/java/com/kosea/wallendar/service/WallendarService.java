package com.kosea.wallendar.service;

import java.util.Date;
import java.util.List;

import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.TagVo;
import com.kosea.wallendar.domain.UserVo;

public interface WallendarService {
	
	public List<UserVo> getUserList();

	public UserVo getUser(String email);

	public List<PostVo> getPostList(String email);

	public PostVo getPost(String usertag);
	
	public List<TagVo> getTags(PostVo post);

}
