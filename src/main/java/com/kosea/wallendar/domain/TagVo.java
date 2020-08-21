package com.kosea.wallendar.domain;

import java.util.Date;

import javax.persistence.Entity;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = "post_tag")
public class TagVo {
	private String usertag;
	private Date post_date;
	private String tag;
}
