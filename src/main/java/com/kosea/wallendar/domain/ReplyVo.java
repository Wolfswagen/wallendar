package com.kosea.wallendar.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = "post_reply")
public class ReplyVo {

	@SequenceGenerator(name = "RNO_SEQ_GEN", sequenceName = "RNO_SEQ", initialValue = 1, allocationSize = 1)
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "RNO_SEQ_GEN")
	private int rno;
	private String usertag;
	private Date postdate;
	private String writer;
	private String contents;
}
