package com.kosea.wallendar.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

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

	@SequenceGenerator(name = "LNO_SEQ_GEN", sequenceName = "LNO_SEQ", initialValue = 1, allocationSize = 1)

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "LNO_SEQ_GEN")
	private int lno;

	private String usertag;

	private Date postdate;

	private String likeduser;

}
