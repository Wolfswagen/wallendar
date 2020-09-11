package com.kosea.wallendar.domain;

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
@Entity(name = "user_follow")
public class FollowVo {
	
	@SequenceGenerator(name = "FNO_SEQ_GEN", sequenceName = "FNO_SEQ", initialValue = 1, allocationSize = 1)
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FNO_SEQ_GEN")
	private int fno;

	private String usertag;

	private String follow;

}
