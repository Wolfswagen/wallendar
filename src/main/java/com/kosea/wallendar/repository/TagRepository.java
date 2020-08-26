package com.kosea.wallendar.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kosea.wallendar.domain.PkPost;
import com.kosea.wallendar.domain.PkTags;
import com.kosea.wallendar.domain.TagVo;

@Repository
public interface TagRepository extends JpaRepository<TagVo, PkTags> {

	public List<TagVo> findByUsertagAndPostdate(String usertag, Date postdate);

}
