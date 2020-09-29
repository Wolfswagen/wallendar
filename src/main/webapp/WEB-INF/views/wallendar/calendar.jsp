<%@include file="../includes/header.jsp"%>
<link href='../fullcalendar/lib/main.css' rel='stylesheet' />


<div class="card bg-dark text-white">
	<img src="/image/backimg.png" class="card-img" id="bgimg" style="max-height: 200px">
	<div class="card-img-overlay">
		<div>
			<div class="card-title font-weight-bolder">
				<img class="img-fluid rounded-circle border"
					style="width: 5%; min-width: 50px; background-color: white; background-size: cover;"
					src="../image/thumbnail.png" id="userimg"> <span id="usertag"></span>
			</div>
		</div>
	</div>
</div>


<div>
	<button id="followinfo" class="btn btn-sm btn-light" data-toggle="modal"
		data-target="#followModal">
		Follower : <span id="followernum"></span> / Following : <span id="followingnum"></span>
	</button>
	<button id="followbtn" class="btn btn-sm btn-light">+Follow</button>
	<button type="button" class="btn btn-sm btn-light float-right" id="bgbtn" data-toggle="modal"
		data-target="#bgModal" hidden="true">Update Wallpaper</button>
</div>

<hr>



<div id='calendar' class="m-auto"></div>
<!--calendar  -->

<!-- post modal -->
<div class="modal fade" id="postModal" role="dialog">
	<div class="modal-dialog  modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="postModalLabel">Post</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h5 class="input-group-prepend" id="user-tag"></h5>
				<div class="text-center p-3">
					<img class="img-fluid mw-25" id="preview">
				</div>
				<div class="input-group p-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="uploadgroup">Upload</span>
					</div>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="upload" aria-describedby="uploadgroup">
						<label class="custom-file-label" for="upload" id="uploadlabel">Choose file</label>
					</div>
				</div>
				<div class="form-group p-3">
					<label class="col-form-label">Tags</label>
					<div class="input-group flexnowrap">

						<div class="input-group-append btn-group" role="group" aria-label="tags-btn" id="added-tags"></div>

						<div class="input-group flexnowrap">
							<div class="input-group-prepend">
								<span class="input-group-text border-0" id="input-tags-label">#</span>
							</div>
							<input type="text" class="form-control border-0" id="input-tag">
							<div class="input-group-append">
								<button type="button" class="btn btn-secondary btn-sm" id="addtag">+</button>
							</div>
						</div>


					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="post">Post</button>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- post modal -->

<!-- follow modal -->
<div class="modal fade" id="followModal" role="dialog">
	<div class="modal-dialog  " role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="followModalLabel">@Usertag</h4>

				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<div class="container mb-3">
					<div class="row">
						<div class="col text-center font-weight-bold">Follower</div>
						<div class="col text-center font-weight-bold">Following</div>
					</div>
					<hr>
					<div class="row">
						<div class="col text-center">
							<div class="row row-cols-1 text-center" id="follower"></div>
						</div>

						<div class="col text-center">
							<div class="row row-cols-1 text-center" id="following"></div>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- follow modal -->

<!-- bg modal; -->
<div class="modal fade" id="bgModal" role="dialog">
	<div class="modal-dialog  modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="postModalLabel">Profile Background</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="text-center p-3">
					<img class="img-fluid mw-25" id="bgpreview">
				</div>
				<div class="input-group p-3" id="bginput">
					<div class="input-group-prepend">
						<span class="input-group-text" id="bguploadgroup">Upload</span>
					</div>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="bgupload" aria-describedby="bguploadgroup">
						<label class="custom-file-label" for="bgupload" id="bguploadlabel">Choose file</label>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-danger" id="bgdelete">Delete</button>
					<button type="button" class="btn btn-primary" id="bgpost">Update</button>
				</div>

			</div>
		</div>
	</div>
</div>

<script charset="utf-8">
	document.addEventListener('DOMContentLoaded', function() {

		if (!sessionStorage.getItem("loginuser")) {
			window.location.href = "/";
		}

		var url = location.pathname.replace("calendar", "post");
		var user;

		var result;

		$.ajax({
			url : url,
			contentType : "application/json",
			type : "GET",
			async : false,
			success : function(response) {
				user = response["user"];
				result = response["userpost"];
			}
		});

		var usertag = user.usertag;

		$('#usertag').text("@" + usertag);

		var calendarEl = document.getElementById('calendar');

		var events = new Array();

		for ( var i in result) {
			var data = new Object();
			var postdate = formDate(result[i]["postdate"]);
			data.start = postdate;
			data.post = result[i];
			data.display = "background";
			data.backgroundColor = "white";
			events.push(data);
		}

		/* calendar init */
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			initialDate : localStorage.getItem("initdate"),
			selectable : true,
			eventBorderColor : "white",
			events : events,
			eventDidMount : function(info) {
				let el = info.el;
				let event = info.event;
				var $td = $(el).closest("td");
				if (event.extendedProps.post) {
					$td.css({
						"background-size" : "cover",
						"background-image" : "url(" + event.extendedProps.post.pic + ")"
					});
					$td.attr("data-post", JSON.stringify(event.extendedProps.post));
				}
			},
			dateClick : function(info) {
				let $day = $(info.dayEl);
				if ($day.data("post")) {
					var post = $day.data("post");

					setReadModal(post);

					if (usertag == sessionStorage.getItem("loginuser")) {
						$('#udmenu').attr("hidden", false);
					}

					$('#readModal').modal("show")
				} else {
					if ($day[0] == $('.fc-day-today')[0] && usertag == sessionStorage.getItem("loginuser")) {
						setPostModal($day.data("date"));
						$('#postModal').modal("show");
					}
				}

			}
		});

		calendar.render();

		localStorage.clear();

		/* calendar rendered */

		if (user.profileimg) {
			$('#userimg').css({
				"background-image" : "url(" + user.profileimg + ")"
			});
		}

		if (user.backimg) {
			$('.card-img-overlay').on('click', function() {
				var max = $("#bgimg").css("max-height");
				if (max == '200px') {
					$("#bgimg").css("max-height", "");
				} else {
					$("#bgimg").css("max-height", "200px");
				}
			});
			$('#bgpreview').attr("src", user.backimg);

			$('#bgimg').css({
				"background-size" : "cover",
				"background-image" : "url(" + user.backimg + ")"
			});
		}

		if (usertag == sessionStorage.getItem("loginuser")) {
			$('#bgbtn').attr("hidden", false);
		}

		/* userprofile */

		/* follow modal */

		var follower;
		var following;

		$.ajax({
			url : "/user/follow/" + usertag,
			contentType : "application/json",
			type : "GET",
			async : false,
			success : function(response) {
				follower = response.follower;
				following = response.following;
				$('#followernum').text(follower.length);
				$('#followingnum').text(following.length);
			}
		});

		if (usertag == sessionStorage.getItem("loginuser")) {
			$('#followbtn').hide();
		}

		if (follower.length == 0) {
			$('#follower').append('<div class="col mx-2">No Follower</div>');
		}

		for (var i = 0; i < follower.length; i++) {
			$('#follower').append('<div class="col mx-2"> <a href="/calendar/'+follower[i].usertag+'">@' + follower[i].usertag + '</a></div>');
			if (follower[i].usertag == sessionStorage.getItem("loginuser")) {
				$('#followbtn').text("Unfollow");
			}
		}

		if (following.length == 0) {
			$('#following').append('<div class="col mx-2">No Follower</div>');
		}
		for (var i = 0; i < following.length; i++) {
			$('#following').append('<div class="col mx-2"><a href="/calendar/'+following[i].follow+'">@' + following[i].follow + '</a></div>');
		}

		$('#followModal .modal-title').text("@" + usertag);

		/* follow modal */

		function setPostModal(postdate) {
			$('#postModal .modal-title').text(postdate);
			$('#upload').empty();
			$('#preview').attr("src", "");
			$('#uploadlabel').text("Choose File");
			$('#postModal #user-tag').text("@" + usertag);
			$('#input-tag').val('');
			$('#added-tags').empty();
			$('#post').text("Post");
		}

		$('#addtag').on('click', function(e) {

			var tag = $('#input-tag').val().replace(/ /gi, "");

			var reg_usertag = /[\{\}\[\]\/?.,;:|\)~`\-+<>@\#$%&\\\=\(\'\"]/gi;

			if (reg_usertag.test(tag)) {
				alert("Only *, !, _, ^ allowed");
				tag = tag.replace(reg_usertag, "");
			}

			var btns = $('#added-tags .btn');
			if (tag.length > 0) {
				$('#added-tags').append('<button type="button" class="btn btn-outline-secondary btn-sm border-0">#' + tag + '</button>')
			}
			$('#input-tag').val("");
		});

		$('#added-tags').on('click', function(e) {
			$(e.target).remove();
		});

		$("#post").on("click", function(e) {
			var method = "POST"

			if ($('#post').text() == "Update") {
				method = "PUT"
			}

			if ($("#upload")[0].files.length > 0 || method == "PUT") {

				var data = new FormData();

				var tags = "";

				var btns = $('#added-tags .btn');

				for (var i = 0; i < btns.length; i++) {
					var tag = $(btns[i]).text();
					tags = tags + tag;
				}

				tags = tags + "#";

				var postdate = $("#postModal .modal-title").text();

				var upload = "";

				if ($("#upload")[0].files[0] != undefined) {
					upload = $("#upload")[0].files[0];
				}

				data.append("upload", upload);

				data.append("tags", tags)

				$.ajax({
					url : url + "/" + postdate,
					processData : false,
					contentType : false,
					data : data,
					type : method,
					success : function(result) {
						$('#post').text("Uploading....");
						$('#postModal').modal("hide");
						setReadModal(regetPost(usertag, postdate));
						$('#readModal').modal("show");
						$('#udmenu').attr("hidden", true);
						$('#readModal').on('hide.bs.modal', function() {
							localStorage.setItem("initdate", postdate);
							window.location.reload();
						});
					},
					error : function(request, status, error) {
						alert($('#post').text() + " Error");
					}
				});

			} else {
				alert("Must Put Image!!");
			}
		});

		$("#upload, #bgupload").change(function() {
			readURL(this);
		});

		$("#bgpost").on("click", function(e) {

			if ($("#bgupload")[0].files.length > 0) {

				var data = new FormData();

				var upload = "";

				if ($("#bgupload")[0].files[0] != undefined) {
					upload = $("#bgupload")[0].files[0];
				}

				data.append("upload", upload);

				$.ajax({
					url : "/user/" + usertag + "/backimg",
					processData : false,
					contentType : false,
					data : data,
					type : "PUT",
					success : function(result) {
						$('#bgpost').text("Uploading....");
						window.location.reload();
					},
					error : function(request, status, error) {
						alert($('#post').text() + " Error");
					}
				});

			} else {
				alert("Must Put Image!!");
			}
		});

		$('#bgdelete').on('click', function() {
			$('#deleteModal .modal-title').text("Delete Image");
			$('#deleteModal').modal("show");
		});

		$("#deletea").on('click', function() {

			$('#deleteModal .modal-title').text("Delete Post");
			$('#deleteModal').modal("show");

		});

		$("#updatea").on('click', function() {
			$('#readModal').modal("hide");

			var postdate = $('#readModal .modal-title').text();
			var pic = $('#readModal #pic').attr("src");
			var tags = $('#tags').text().split("#");

			$('#postModal').modal("show");

			$('#postModal .modal-title').text(postdate);
			$('#preview').attr("src", pic);
			$('#post').text("Update");
			for (var i = 1; i < tags.length; i++) {
				$('#added-tags').append('<button type="button" class="btn btn-outline-secondary btn-sm border-0">#' + tags[i] + '</button>');
			}
		});

		$('#input-tag').keypress(function(event) {
			if (event.which == 13) {
				$('#addtag').click();
				return false;
			}
		});

		$('#followbtn').on('click', function() {
			var method;
			if ($('#followbtn').text() == '+Follow') {
				method = "POST"
			} else {
				method = "DELETE"
			}

			var data = new Object();

			data.usertag = sessionStorage.getItem("loginuser");

			data.follow = usertag;

			$.ajax({
				url : "/user/follow/",
				contentType : "application/json",
				data : JSON.stringify(data),
				type : method,
				success : function(result) {
					$('#followbtn').text("+Follow");
					regetFollow();
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});

		});

		function regetFollow() {
			var follower;
			var following;

			$.ajax({
				url : "/user/follow/" + usertag,
				contentType : "application/json",
				type : "GET",
				async : false,
				success : function(response) {
					follower = response.follower;
					following = response.following;
					$('#followernum').text(follower.length);
					$('#followingnum').text(following.length);
				}
			});

			$('#follower *').remove();
			$('#following *').remove();

			if (follower.length == 0) {
				$('#follower').append('<div class="col mx-2">No Follower</div>');
			}

			for (var i = 0; i < follower.length; i++) {
				$('#follower').append('<div class="col mx-2"> <a href="/calendar/'+follower[i].usertag+'">@' + follower[i].usertag + '</a></div>');
				if (follower[i].usertag == sessionStorage.getItem("loginuser")) {
					$('#followbtn').text("Unfollow");
				}
			}

			if (following.length == 0) {
				$('#following').append('<div class="col mx-2">No Follower</div>');
			}
			for (var i = 0; i < following.length; i++) {
				$('#following').append('<div class="col mx-2"><a href="/calendar/'+following[i].follow+'">@' + following[i].follow + '</a></div>');
			}
		}

		function readURL(input) {
			$('#preview').attr('src', '');
			$('#bgpreview').attr('src', '');
			$('.custom-file-label').text('Choose File');
			if (/\.(gif|jpg|jpeg|png)$/i.test(input.files[0].name)) {
				if (input.files && input.files[0]) {
					var name = input.files[0].name;
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#preview').attr('src', e.target.result);
						$('#bgpreview').attr('src', e.target.result);
						$('.custom-file-label').text("");
					}
					reader.readAsDataURL(input.files[0]);
				}
			} else {
				alert('Please Choose Image File');
			}
		}
	});
</script>

<%@include file="../includes/footer.jsp"%>