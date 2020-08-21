package com.kosea.wallendar.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Embeddable;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
@Embeddable
public class PkPost implements Serializable {
	private static final long serialVersionUID = 1L;
	private String usertag;
	private Date post_date;
}
