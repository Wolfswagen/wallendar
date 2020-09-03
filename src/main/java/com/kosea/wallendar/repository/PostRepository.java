package com.kosea.wallendar.repository;

import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.PostVo;

@Repository
public interface PostRepository extends JpaRepository<PostVo, PkPost> {

	public List<PostVo> findByUsertag(String usertag);

	public List<PostVo> findByPostdate(Date postdate);

	public List<PostVo> findByTagsLike(String tags);

}
