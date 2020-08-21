package com.kosea.wallendar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.PostVo;
import com.kosea.wallendar.domain.TagVo;
import com.kosea.wallendar.domain.UserVo;

@Repository
@Mapper
public interface WallendarMapper {
	
	public List<UserVo> getUserList();
	
	public UserVo getUser(String email);

	public List<PostVo> getPostList(String usertag);

	public PostVo getPost(String usertag);

	public List<TagVo> getTags(PostVo post);
}
