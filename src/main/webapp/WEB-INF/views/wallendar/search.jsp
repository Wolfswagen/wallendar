<%@include file="../includes/header.jsp"%>
<h2>WALL</h2>

<div class="pl-5">
	<h5>User</h5>
	<div class="ml-2" id="userpost">No Result</div>
</div>
<hr>
<div class="pl-5">
	<h5>Tags</h5>
	<div class="ml-2" id="tagpost">No Result</div>
	<div class="container-fluid">
		<div class="row row-cols-4 p-3" id="tagrow"></div>
	</div>
</div>

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

<script charset="utf-8">
	$(document).ready(function() {
		var url = location.pathname.replace("search", "post");
		var userpost;
		var tagpost;

		$.ajax({
			url : url,
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				userpost = response["userpost"];
				tagpost = response["tagpost"];
			}
		});

		if (userpost.length > 0) {
			$('#userpost').text('').append('<a href="/calendar/'+userpost[0]["usertag"]+'">@' + userpost[0]["usertag"] + '</a>');
		}

		if (tagpost.length > 0) {
			$('#tagpost').text("#" + url.replace("/post/", ""));
		}

		for (var i = 0; i < tagpost.length; i++) {
			$('#tagrow').append('<img class = "mb-3 col rounded" usertag = "' + tagpost[i]["usertag"] + '" postdate = "' + formDate(tagpost[i]["postdate"]) + '" style="width:100%; background:url(../' + tagpost[i]["pic"] + ') no-repeat center center; background-size:cover; " src = /image/thumbnail.png>');
		}

		$('.rounded').on('click', function(event) {

			var postdate = $(event.target).attr("postdate").substring(0, 10);
			var usertag = $(event.target).attr("usertag");
			console.log("/post/" + usertag + "/" + postdate);
			var tags;
			var pic;

			$.ajax({
				url : "/post/" + usertag + "/" + postdate,
				contentType : "JSON",
				type : "GET",
				async : false,
				success : function(response) {
					console.log(response);
					tags = response["tags"];
					pic = "../" + response["pic"];
				}
			});

			tags = tags.substring(0, tags.length - 1);
			$('#readModal .modal-title').text(postdate);
			$('#readModal #user-tag').text("@" + usertag);
			$('#pic').attr("src", pic);
			$('#tags').text(tags);
			$('#readModal').modal("show");
		});
	});
</script>
<%@include file="../includes/footer.jsp"%>