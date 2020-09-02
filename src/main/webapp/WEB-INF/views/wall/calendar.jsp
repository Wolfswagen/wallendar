<%@include file="../includes/header.jsp"%>
<link href='../fullcalendar/lib/main.css' rel='stylesheet' />
<script src='../fullcalendar/lib/main.js' charset="utf-8"></script>

<div id='calendar'></div>
<!--calendar  -->
<div class="modal fade " id="readModal" role="dialog">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="readModalLabel">Wallendar</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="text-center">
					<img class="img-fluid" id="pic">
				</div>
				<div class="dropdown float-right">
					<button class="btn btn-secondary dropdown-toggle btn-sm" type="button" id="dropdownMenuButton"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item" href='javascript:void(0);' onclick="deletePost();">Delete</a> <a
							class="dropdown-item" href='javascript:void(0);' onclick="updatePost();">Update</a>
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
<!-- read modal -->

<div class="modal fade" id="postModal" role="dialog">
	<div class="modal-dialog  modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="postModalLabel">Post</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body modal-lg">
				<div class="text-center p-3">
					<img class="img-fluid" id="preview">
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
						<div class="input-group-prepend" id="user-tag"></div>
						<div class="input-group-append btn-group" role="group" aria-label="tags-btn" id="added-tags">
						</div>

						<div class="input-group-append btn-group" role="group" aria-label="tags-btn" id="delete-tags"
							hidden="true"></div>

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
						<button type="button" class="btn btn-primary" id="update">Update</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- post modal -->



<script charset="utf-8">
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var url = location.pathname.replace("calendar/", "");
		var result;
		var usertag = url.replace("/", "");
		$.ajax({
			url : url,
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				result = response
			}
		});

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

		var events = new Array();

		for ( var i in result) {
			var data = new Object();
			var postdate = formDate(result[i]["postdate"]);
			data.start = postdate;
			data.imageurl = result[i]["pic"];
			data.display = "background";
			events.push(data);
		}

		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			selectable : true,
			eventBorderColor : "white",
			events : events,
			eventDidMount : function(info) {
				let el = info.el;

				let event = info.event;
				if (event.extendedProps.imageurl) {
					$(el).css({
						"background-size" : "cover"
					});
					$(el).css({
						"background-image" : "url(../" + event.extendedProps.imageurl + ")"
					});
					$(el).closest("td").attr("data-toggle", "modal");
					$(el).closest("td").attr("data-target", "#readModal");
					$(el).closest("td").append('<input type="hidden" id="picpath" value= "'+event.extendedProps.imageurl+'">');
				}
			}
		});
		calendar.render();

		if ($(".fc-day-today").attr("data-toggle") == undefined) {
			$(".fc-day-today").attr("data-toggle", "modal");
			$(".fc-day-today").attr("data-target", "#postModal");
		}

		$('#readModal').on('show.bs.modal', function(event) {
			var postdate = $(".fc-highlight").closest("td").attr("data-date");
			var pic = "../" + $(".fc-highlight").closest("td").find("#picpath").val();
			var tags;
			$.ajax({
				url : url + "/" + postdate + "/tags",
				contentType : "JSON",
				type : "GET",
				async : false,
				success : function(response) {
					tags = response;
				}
			});
			$('#readModal .modal-title').text(postdate);
			$('#pic').attr("src", pic);
			$('#tags').empty();

			$('#tags').append("<b>@" + usertag + "<b><br>");
			for ( var tag in tags) {
				$('#tags').append("#" + tags[tag]["tag"]);
			}
		});

		$('#postModal').on('show.bs.modal', function(event) {
			var postdate = $(".fc-highlight").closest("td").attr("data-date");
			var tags;
			$('#postModal .modal-title').text(postdate);
			$('#upload').empty();
			$('#preview').attr("src", "");
			$('#uploadlabel').text("Choose File");
			$('#user-tag').text("@" + usertag);
			$('#input-tag').val('');
			$('#added-tags').empty();
			$('#update').hide();
			$('#delete-tags').val('');

		});

		$('#addtag').on('click', function(e) {
			if ($('#input-tag').val().length > 0) {
				$('#added-tags').append('<button type="button" class="btn btn-outline-secondary btn-sm border-0">#' + $('#input-tag').val() + ' x</button>')
				$('#input-tag').val("");
			}
		});

		$('#added-tags').on('click', function(e) {
			var tag = $(e.target).text();
			$('#delete-tags').append('<input type = "hidden" value="' + tag.substring(1, tag.length - 2) + '">')
			$(e.target).remove();
		});

		$("#post").on("click", function(e) {

			var res = 0;

			if ($("#upload")[0].files.length > 0) {

				var data = new FormData();

				var postdate = $("#postModal .modal-title").text();

				data.append("upload", $("#upload")[0].files[0]);

				$.ajax({
					url : url + "/" + postdate,
					processData : false,
					contentType : false,
					async : false,
					data : data,
					type : "POST",
					success : function(result) {
						res = 1;
					},
					error : function(request, status, error) {
						res = 0;
						alert("post error");
					}
				});

				var tagArray = new Array();

				var btns = $('#added-tags .btn');

				if (btns.length > 0) {
					for (var i = 0; i < btns.length; i++) {
						var tag = $(btns[i]).text();
						tagArray.push(tag.substring(1, tag.length - 2));
					}

					var tags = {
						"tags" : tagArray
					}

					$.ajax({
						url : url + "/" + postdate + '/tags',
						dataType : "json",
						traditional : true,
						async : false,
						data : tags,
						type : "POST",
						error : function(request, status, error) {
							res = 0;
							alert("tag post error");
						}
					});
				}

			} else {
				alert("must put image");
			}

			if (res == 1) {
				window.location.reload();
			}
		});

		$("#update").on("click", function(e) {

			var res = 1;

			var postdate = $("#postModal .modal-title").text();

			if ($("#upload")[0].files.length > 0) {

				var data = new FormData();

				data.append("upload", $("#upload")[0].files[0]);

				$.ajax({
					url : url + "/" + postdate,
					processData : false,
					contentType : false,
					async : false,
					data : data,
					type : "PUT",
					error : function(request, status, error) {
						res = 0;
						alert("post error");
					}
				});

			}

			var saveTags = new Array();

			var deleteTags = new Array();

			var addtags = $('#added-tags .btn');

			var deltags = $("#delete-tags input");

			for (var i = 0; i < addtags.length; i++) {
				var tag = $(addtags[i]).text();
				saveTags.push(tag.substring(1, tag.length - 2));
			}

			for (var i = 0; i < deltags.length; i++) {
				var tag = $(deltags[i]).val();
				deleteTags.push(tag);
			}

			if (deleteTags.length == 0) {
				deleteTags.push("");
			}
			
			if (saveTags.length == 0) {
				saveTags.push("");
			}

			var tags = {
				"saveTags" : saveTags,
				"deleteTags" : deleteTags
			}
			

			console.log(tags.saveTags)
			console.log(tags.deleteTags)

			$.ajax({
				url : url + "/" + postdate + '/tags',
				dataType : "json",
				traditional : true,
				async : false,
				data : tags,
				type : "PUT",
				error : function(request, status, error) {
					res = 0;
					alert("tag post error");
				}
			});

			if (res == 1) {
				window.location.reload();
			}
		});

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

	function deletePost() {
		var postdate = $('#readModal .modal-title').text();
		var url = location.pathname.replace("calendar/", "");
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
	}

	function updatePost() {
		$('#readModal').modal('hide');
		var postdate = $('#readModal .modal-title').text();
		var url = location.pathname.replace("calendar/", "");
		var pic = $('#readModal #pic').attr("src");
		var tags = $('#tags').text().split("#");

		$('#postModal').modal("show");
		$('#postModal .modal-title').text(postdate);
		$('#preview').attr("src", pic);
		$('#post').toggle();
		$('#update').toggle();
		for (var i = 1; i < tags.length; i++) {
			$('#added-tags').append('<button type="button" class="btn btn-outline-secondary btn-sm border-0">#' + tags[i] + ' x</button>')
		}
		$('#post').text("Update");

	}

	$("#upload").change(function() {
		readURL(this);
	});
</script>

<%@include file="../includes/footer.jsp"%>