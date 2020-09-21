package com.kosea.wallendar.domain;

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
@Entity(name = "user_follow")
public class FollowVo {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int fno;

	private String usertag;

	private String follow;

}
