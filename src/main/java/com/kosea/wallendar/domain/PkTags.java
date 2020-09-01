package com.kosea.wallendar.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PkTags implements Serializable {
	private static final long serialVersionUID = 1L;
	private String usertag;
	private Date postdate;
	private String tag;
}
