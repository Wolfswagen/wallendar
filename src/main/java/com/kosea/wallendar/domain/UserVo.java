package com.kosea.wallendar.domain;


import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = "user_tbl")
public class UserVo {

	@Id
	private String email;
	private String password;
	private String username;
	private String usertag;
}
