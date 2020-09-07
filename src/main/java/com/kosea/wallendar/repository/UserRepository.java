package com.kosea.wallendar.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.UserVo;

@Repository
public interface UserRepository extends JpaRepository<UserVo, String> {

	public Optional<UserVo> findByEmail(String email);
	
	public Optional<UserVo> findByEmailAndPassword(String email, String password);

}
