package com.kosea.wallendar.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.OneToMany;

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

	private String pic;

	private String tags;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumns({ @JoinColumn(name = "usertag", referencedColumnName = "usertag"),
			@JoinColumn(name = "postdate", referencedColumnName = "postdate") })
	private List<ReplyVo> reply;

	public void addReply(ReplyVo r) {
		if (reply == null) {
			reply = new ArrayList<ReplyVo>();
		}
		reply.add(r);
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumns({ @JoinColumn(name = "usertag", referencedColumnName = "usertag"),
			@JoinColumn(name = "postdate", referencedColumnName = "postdate") })
	private List<LikeVo> likes;

	public void addLike(LikeVo l) {
		if (likes == null) {
			likes = new ArrayList<LikeVo>();
		}
		likes.add(l);
	}
}
