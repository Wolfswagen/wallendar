package com.kosea.wallendar.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.TagVo;

@Repository
public interface TagRepository extends JpaRepository<TagVo, PkPost> {
	
}
