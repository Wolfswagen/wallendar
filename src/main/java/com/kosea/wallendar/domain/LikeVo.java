package com.kosea.wallendar.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "post_like")
public class LikeVo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int lno;

	private String usertag;

	private Date postdate;

	private String likeduser;

}
