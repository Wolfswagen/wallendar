package com.kosea.wallendar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.UserVo;

@Repository
public interface UserRepository extends JpaRepository<UserVo, String> {
	List<UserVo> findByEmail(String email);
	
}
