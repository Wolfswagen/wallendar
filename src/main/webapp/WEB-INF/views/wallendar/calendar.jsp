<%@include file="../includes/header.jsp"%>
<link href='../fullcalendar/lib/main.css' rel='stylesheet' />

<div id='calendar'></div>
<!--calendar  -->
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
				<div class="dropdown float-right" id="udmenu">
					<button class="btn btn-secondary dropdown-toggle btn-sm" type="button" id="dropdownMenuButton"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item" id="deletea">Delete</a> <a class="dropdown-item" id="updatea">Update</a>
					</div>
				</div>

				<div class="p-5">
					<h5>Tags</h5>
					<p class="form-control-plaintext text-left" id="tags"></p>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- read modal end -->

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

						<div class="input-group-append btn-group" role="group" aria-label="tags-btn" id="added-tags">
						</div>

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



<script charset="utf-8">
	var url = location.pathname.replace("calendar", "post");
	var usertag = url.replace("/post/", "");
	document.addEventListener('DOMContentLoaded', function() {
		
		if (!sessionStorage.getItem("loginuser")) {
			window.location.href = "/";
		}
		
		var calendarEl = document.getElementById('calendar');

		if (usertag != sessionStorage.getItem("loginuser")) {
			$('#udmenu').hide();
		}

		var result;
		$.ajax({
			url : url,
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				result = response["userpost"]
			}
		});

		var events = new Array();

		for ( var i in result) {
			var data = new Object();
			var postdate = formDate(result[i]["postdate"]);
			data.start = postdate;
			data.imageurl = result[i]["pic"];
			data.display = "background";
			data.backgroundColor = "white";
			events.push(data);
		}

		/* calendar init */
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			selectable : true,
			eventBorderColor : "white",
			events : events,
			eventDidMount : function(info) {
				let el = info.el;

				let event = info.event;
				var $td = $(el).closest("td");
				if (event.extendedProps.imageurl) {
					$td.css({
						"background-size" : "cover",
						"background-image" : "url(../" + event.extendedProps.imageurl + ")"
					});

					$td.attr("data-toggle", "modal").attr("data-target", "#readModal");
					$td.append('<input type="hidden" id="picpath" value= "'+event.extendedProps.imageurl+'">');
				}
			}
		});
		calendar.render();
		/* calendar rendered */

		if ($(".fc-day-today").attr("data-toggle") == undefined) {
			$(".fc-day-today").attr("data-toggle", "modal");
			$(".fc-day-today").attr("data-target", "#postModal");
		}

	});

	/* modal */
	$('#readModal').on('show.bs.modal', function(event) {

		var postdate = $(".fc-highlight").closest("td").attr("data-date");
		var tags;
		var pic;
		$.ajax({
			url : url + "/" + postdate,
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				tags = response["tags"];
				pic = "../" + response["pic"];
			}
		});

		tags = tags.substring(0, tags.length - 1);
		$('#readModal .modal-title').text(postdate);
		$('#readModal #user-tag').text("@" + usertag);
		$('#pic').attr("src", pic);
		$('#tags').text(tags);
	});

	$('#postModal').on('show.bs.modal', function(event) {
		var postdate = $(".fc-highlight").closest("td").attr("data-date");
		$('#postModal .modal-title').text(postdate);
		$('#upload').empty();
		$('#preview').attr("src", "");
		$('#uploadlabel').text("Choose File");
		$('#postModal #user-tag').text("@" + usertag);
		$('#input-tag').val('');
		$('#added-tags').empty();
		$('#post').text("Post");
	});

	$('#addtag').on('click', function(e) {
		var tag = $('#input-tag').val().replace(/ /gi, "");
		if (tag.length > 0) {
			$('#added-tags').append('<button type="button" class="btn btn-outline-secondary btn-sm border-0">#' + tag + ' x</button>')
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

		var res = 0;

		if ($("#upload")[0].files.length > 0 || method == "PUT") {

			var data = new FormData();

			var tags = "";

			var btns = $('#added-tags .btn');

			for (var i = 0; i < btns.length; i++) {
				var tag = $(btns[i]).text().replace(" x", '');
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
				async : false,
				data : data,
				type : method,
				success : function(result) {
					res = 1;
				},
				error : function(request, status, error) {
					alert($('#post').text() + " Error");
				}
			});

		} else {
			alert("Must Put Image!!");
		}
		if (res == 1) {
			setTimeout(function() {
				window.location.reload();
			}, 500);
		}
	});

	$('body').on('hidden.bs.modal', function() {
		if ($('.modal:visible').length > 0) {
			$('body').addClass('modal-open');
		}
	});

	$("#upload").change(function() {
		readURL(this);
	});

	$("#deletea").on('click', function() {
		var postdate = $('#readModal .modal-title').text();
		console.log(url)
		$.ajax({
			url : url + "/" + postdate,
			type : "DELETE",
			success : function() {
				window.location.reload();
			},
			error : function(request, status, error) {
				alert("delete error");
			}
		});
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
			$('#added-tags').append('<button type="button" class="btn btn-outline-secondary btn-sm border-0">#' + tags[i] + ' x</button>')
		}
	});

	$('#input-tag').keypress(function(event) {
		if (event.which == 13) {
			$('#addtag').click();
			return false;
		}
	});

	function readURL(input) {
		$('#preview').attr('src', '');
		$('.custom-file-label').text('Choose File');
		if (input.files && input.files[0]) {

			var name = input.files[0].name;
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
				$('.custom-file-label').text(name);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>

<%@include file="../includes/footer.jsp"%>
