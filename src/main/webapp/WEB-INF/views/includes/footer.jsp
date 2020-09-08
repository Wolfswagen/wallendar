

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
				<div class="dropdown float-right" id="udmenu">
					<button class="btn btn-secondary dropdown-toggle btn-sm" type="button" id="dropdownMenuButton"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item" id="deletea">Delete</a> <a class="dropdown-item" id="updatea">Update</a>
					</div>
				</div>

				<div class="pl-5 pt-5">
					<h5>Tags</h5>
					<p class="form-control-plaintext text-left" id="tags"></p>
					<hr>
					<h5>Comments</h5>
					<div class="form-control-plaintext text-left" id="comments"></div>
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
<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Logout</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
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

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Delete</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
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
	$(document).ready(function() {

		$('#dataTables-example').DataTable({
			responsive : true
		});

		$(".sidebar-nav").attr("class", "sidebar-nav navbar-collapse collapse").attr("aria-expanded", "false").attr("style", "height:1px");

	});

	$('#search-btn').on('click', function(e) {
		if ($('#search').val().length > 0) {
			document.location.href = "/search/" + $('#search').val();
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
				window.location.reload();
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});

	function setReadModal(usertag, postdate) {

		$('#udmenu').hide();

		var tags;
		var comments;
		var pic;
		$.ajax({
			url : "/post/" + usertag + "/" + postdate,
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				comments = response["reply"];
				tags = response["tags"];
				pic = "../" + response["pic"];
			}
		});

		tags = tags.substring(0, tags.length - 1);

		$('#readModal .modal-title').text(postdate);
		$('#readModal #user-tag').text("@" + usertag);
		$('#pic').attr("src", pic);
		$('#tags').text(tags);
		$('#readModal #comments *').remove();
		for (var i = 0; i < comments.length; i++) {
			var writer = comments[i]["writer"];

			if (comments[i]["writer"] == sessionStorage.getItem("loginuser")) {
				writer = "x " + writer;
			} else {
				writer = "@ " + writer;
			}
			$('#readModal #comments').append('<p> <a id="writer" onclick = "commentOnClick(this);" class="font-weight-bolder" rno = "' + comments[i]["rno"] + '">' + writer + '</a> : ' + comments[i]["contents"] + '</p>');
		}
	}

	function commentOnClick(e) {
		if ($(e).text().substring(0, 1) == "x") {
			$('#deleteModal .modal-title').text("Delete Comment");
			$('#deletebtn').attr("rno", $(e).attr("rno"));
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

		if ($('#deleteModal .modal-title').text() == "Delete Post") {

			var postdate = $('#readModal .modal-title').text();
			var usertag = $('#readModal #user-tag').text().substring(1);

			$.ajax({
				url : "/post/" + usertag + "/" + postdate,
				type : "DELETE",
				success : function() {
					window.location.reload();
				},
				error : function(request, status, error) {
					alert("delete error");
				}
			});
		}

		if ($('#deleteModal .modal-title').text() == "Delete Comment") {
			var rno = $("#deletebtn").attr("rno");
			$.ajax({
				url : "/post/comment/" + rno,
				type : "DELETE",
				success : function() {
					window.location.reload();
				},
				error : function(request, status, error) {
					alert("delete error");
				}
			});
		}

	});

	$('body').on('hidden.bs.modal', function() {
		if ($('.modal:visible').length > 0) {
			$('body').addClass('modal-open');
		}
	});
</script>
</body>
</html>