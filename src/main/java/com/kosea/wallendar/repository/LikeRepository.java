package com.kosea.wallendar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.LikeVo;

@Repository
public interface LikeRepository extends JpaRepository<LikeVo, Integer> {

}
