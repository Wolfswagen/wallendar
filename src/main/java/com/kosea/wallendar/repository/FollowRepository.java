package com.kosea.wallendar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kosea.wallendar.domain.FollowVo;

@Repository
public interface FollowRepository extends JpaRepository<FollowVo, Integer> {

	public List<FollowVo> findByUsertag(String usertag);

	public List<FollowVo> findByFollow(String follow);

	@Transactional
	public void deleteByUsertagAndFollow(String usertag, String follow);
}
