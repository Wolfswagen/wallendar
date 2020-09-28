package com.kosea.wallendar.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.ReplyVo;

@Repository
public interface ReplyRepository extends JpaRepository<ReplyVo, Integer> {
	
}
