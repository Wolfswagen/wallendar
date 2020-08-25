package com.kosea.wallendar.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Lob;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = "post_tbl")
@IdClass(PkPost.class)
public class PostVo {

	@Id
	private String usertag;
	@Id
	private Date postdate;
	@Lob
	private byte[] pic;

}
