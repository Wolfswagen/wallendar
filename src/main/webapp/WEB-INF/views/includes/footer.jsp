

<!-- Footer -->
<footer class="sticky-footer bg-white">
	<div class="container my-auto">
		<div class="copyright text-center my-auto">
			<span>Copyright &copy; Wallendar 2020</span>
		</div>
	</div>
</footer>
<!-- End of Footer -->

<!-- read modal -->
<div class="modal fade" id="readModal" role="dialog">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="readModalLabel">Wallendar</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h5 class="input-group-prepend" id="user-tag"></h5>
				<div class="text-center">
					<img class="img-fluid" id="pic">
				</div>
				<div class="dropdown float-right pt-2" id="udmenu" hidden="true">
					<button class="btn btn-secondary dropdown-toggle btn-sm" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item" id="deletea">Delete</a>
						<a class="dropdown-item" id="updatea">Update</a>
					</div>
				</div>

				<div class="pl-5 pt-5">


					<h5>Tags</h5>
					<p class="form-control-plaintext text-left" id="tags"></p>
					<hr>
					<div>
						<button class="btn btn-light btn-sm" id="likebtn">
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-calendar-check" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  								<path fill-rule="evenodd" d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z" />
  								<path fill-rule="evenodd" d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z" />
							</svg>
						</button>
						<button class="btn btn-light btn-sm" id="unlikebtn">
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-calendar-check-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  								<path fill-rule="evenodd" d="M4 .5a.5.5 0 0 0-1 0V1H2a2 2 0 0 0-2 2v1h16V3a2 2 0 0 0-2-2h-1V.5a.5.5 0 0 0-1 0V1H4V.5zM16 14V5H0v9a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2zm-5.146-5.146a.5.5 0 0 0-.708-.708L7.5 10.793 6.354 9.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z" />
							</svg>
						</button>

						<a data-toggle="collapse" data-target="#collapseLike" aria-expanded="false" aria-controls="collapseExample" id="likedusers">
							<span></span>
							Likes
						</a>
						<div class="collapse" id="collapseLike">
							<div class="card card-body border-0" id="likes"></div>
						</div>
					</div>

					<div>
						<h5>Comments</h5>
						<div class="form-control-plaintext text-left pl-2" id="comments"></div>
					</div>


				</div>

				<div class="input-group p-4 ">
					<input type="text" class="form-control" placeholder="Comments..." id="commentinput">
					<div class="input-group-append">
						<button class="btn btn-secondary" type="button" id="commentbtn">Comment</button>
					</div>
				</div>


			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- read modal end -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
	<i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Logout</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">Ã</span>
				</button>
			</div>
			<div class="modal-body">Ready To Leave?</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="#" id="logoutbtn">Logout</a>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Delete</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">Ã</span>
				</button>
			</div>
			<div class="modal-body">Are you Sure??</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="#" id="deletebtn">Delete</a>
			</div>
		</div>
	</div>
</div>






<script src='../fullcalendar/lib/main.js' charset="utf-8"></script>
<!-- Bootstrap core JavaScript-->
<!-- <script src="resources/static/vendor/jquery/jquery.min.js"></script> -->
<script src="/theme/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/theme/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/theme/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="/theme/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/theme/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->

<script src="/jquery-ui/jquery-ui.js"></script>

<script>
	if (sessionStorage.getItem("loginuser")) {
		$('#logged-on-user').text(sessionStorage.getItem("loginuser"));
		$("#profile").attr("href", "/profile/" + sessionStorage.getItem("loginuser"));
	} else {
		$('#userdropdownmenu').hide();
	}
	
	if (sessionStorage.getItem("userimg")) {
		$('#profileimg').attr("src", "data:image/jpeg;base64," + sessionStorage.getItem("userimg"));
	}

	$('#search-btn').on('click', function(e) {

		if ($('#search').val().length > 0) {
			document.location.href = "/search/" + $('#search').val();
		}
	});

	$('#search-btn-xs').on('click', function(e) {
		if ($('#search-xs').val().length > 0) {
			document.location.href = "/search/" + $('#search-xs').val();
		}
	});
	
	$('#search-xs').keypress(function(event) {
		if (event.which == 13) {
			$('#search-btn-xs').click();
			return false;
		}
	});
	
	$('#search').keypress(function(event) {
		if (event.which == 13) {
			$('#search-btn').click();
			return false;
		}
	});

	$('#calbtn').on('click', function() {
		window.location.href = "/calendar/" + sessionStorage.getItem("loginuser");
	});

	$('#wallbtn').on('click', function() {
		var date = formDate(new Date());
		window.location.href = "/wall/" + date;
	});

	$('#logoutbtn').on('click', function() {
		sessionStorage.clear();
		window.location.href = "/";
	});

	$('#commentbtn').on('click', function() {
		var data = new Object();
		data.usertag = $('#readModal #user-tag').text().substring(1);
		data.postdate = $('#readModal .modal-title').text();
		data.writer = sessionStorage.getItem("loginuser");
		data.contents = $('#commentinput').val();

		$.ajax({
			url : "/post/comment/",
			contentType : "application/json",
			data : JSON.stringify(data),
			type : "POST",
			success : function(result) {
				setReadModal(regetPost(data.usertag, data.postdate));
				$('#commentinput').val("");
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});

	function setReadModal(post) {
	
		
		var likes = post.likes;
		var comments = post.reply;
		var tags = post.tags.substr(0, post.tags.length - 1).split("#");
		
		$('#likedusers span').text(likes.length);
		$('#likebtn').show();
		$('#unlikebtn').hide();
		$('#readModal .modal-title').text(formDate(post.postdate).substring(0, 10));
		$('#readModal #user-tag *').remove();
		$('#readModal #user-tag').append('<a class="text-secondary" href="/calendar/'+post.usertag+'">@' + post.usertag);
		$('#pic').attr("src", "data:image/jpeg;base64," + post.pic);
		$('#tags').text("");
		$('#readModal #comments *').remove();
		$('#readModal #likes *').remove();

		for (var i = 1; i < tags.length; i++) {
			$('#tags').append('<a class="text-secondary" href="/search/'+tags[i]+'">#' + tags[i] + '</a>');
		}

		for (var i = 0; i < likes.length; i++) {
			$('#likes').append('<div><a class="text-secondary" href="/calendar/'+likes[i].likeduser+'">@' + likes[i].likeduser + '</a></div>');
			if (likes[i].likeduser == sessionStorage.getItem("loginuser")) {
				$('#likebtn').hide();
				$('#unlikebtn').show();
				$('#unlikebtn').attr("data-lno", likes[i].lno);
			}
		}

		for (var i = 0; i < comments.length; i++) {
			var writer = comments[i]["writer"];
			if (writer == sessionStorage.getItem("loginuser")) {
				writer = "x " + writer;
			} else {
				writer = "@ " + writer;
			}
			$('#readModal #comments').append('<div> <a id="writer" onclick = "commentOnClick(this);" class="font-weight-bolder" data-rno = "' + comments[i]["rno"] + '">' + writer + '</a> : ' + comments[i]["contents"] + '</div>');
		}

	}

	$('#likebtn').on('click', function() {
		var data = new Object();
		data.usertag = $('#readModal #user-tag').text().substring(1);
		data.postdate = $('#readModal .modal-title').text();
		data.likeduser = sessionStorage.getItem("loginuser");

		$.ajax({
			url : "/post/like/",
			contentType : "application/json",
			data : JSON.stringify(data),
			type : "POST",
			success : function(result) {
				setReadModal(regetPost(data.usertag, data.postdate));
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});

	$('#unlikebtn').on('click', function() {
		var lno = $("#unlikebtn").attr("data-lno");
		var usertag = $('#readModal #user-tag').text().substring(1);
		var postdate = $('#readModal .modal-title').text();

		$.ajax({
			url : "/post/like/" + lno,
			type : "DELETE",
			success : function() {
				setReadModal(regetPost(usertag, postdate));
			},
			error : function(request, status, error) {
				alert("unlike error");
			}
		});
	});

	function commentOnClick(e) {
		if ($(e).text().substring(0, 1) == "x") {
			$('#deleteModal .modal-title').text("Delete Comment");
			$('#deletebtn').attr("data-rno", $(e).attr("data-rno"));
			$('#deleteModal').modal("show");
		} else {
			window.location.href = "/calendar/" + $(e).text().substring(2);
		}
	}

	function formDate(date) {
		date = FullCalendar.formatDate(date, {
			month : '2-digit',
			year : 'numeric',
			day : '2-digit',
			locale : "kr"
		});
		date = date.replace(/ /g, "");
		date = date.replace(/\./g, "-");
		date = date.substring(0, 10);

		return date;
	}

	$('#deletebtn').on('click', function(e) {

		var postdate = $('#readModal .modal-title').text();
		var usertag = $('#readModal #user-tag').text().substring(1);

		if ($('#deleteModal .modal-title').text() == "Delete Post") {

			$.ajax({
				url : "/post/" + usertag + "/" + postdate,
				type : "DELETE",
				success : function() {
					location.reload();
				},
				error : function(request, status, error) {
					alert("delete error");
				}
			});
		}

		if ($('#deleteModal .modal-title').text() == "Delete Comment") {
			var rno = $("#deletebtn").attr("data-rno");
			$.ajax({
				url : "/post/comment/" + rno,
				type : "DELETE",
				success : function() {
					$('#deleteModal').modal("hide");
					setReadModal(regetPost(usertag, postdate));
				},
				error : function(request, status, error) {
					alert("delete error");
				}
			});
		}
		
		if($('#deleteModal .modal-title').text() == "Delete Image"){
 			$.ajax({
				url : "/user/" + sessionStorage.getItem("loginuser") + "/backimg",
				type : "PUT",
				success : function(result) {
					window.location.reload();
				},
				error : function(request, status, error) {
					alert($('#post').text() + " Error");
				}
			}); 
		}

	});

	$('body').on('hidden.bs.modal', function() {
		if ($('.modal:visible').length > 0) {
			$('body').addClass('modal-open');
		}
	});

	$('#readModal').on("hide.bs.modal", function() {
		$('#collapseLike').collapse("hide");
	})

	function regetPost(usertag, postdate) {

		var post;

		$.ajax({
			url : "/post/" + usertag + "/" + postdate,
			contentType : "application/json",
			type : "GET",
			async : false,
			success : function(response) {
				post = response;
			}

		});
		
		$("[data-date="+postdate+"]").data("post", post) 

		return post;
	}
	

</script>
</body>
</html>