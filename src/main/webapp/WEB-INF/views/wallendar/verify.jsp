<%@include file="../includes/header.jsp"%>
<div class="container">

	<!-- Outer Row -->
	<div class="row justify-content-center">

		<div class="col-xl-10 col-lg-12 col-md-9">

			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="p-5">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
								<p class="mb-4">Enter your email address below and we'll send you a link to reset your password!</p>
							</div>

							<div class="form-group">
								<input type="text" class="form-control form-control-user" id="inputEmail" aria-describedby="emailHelp" placeholder="Enter Email Address...">
							</div>
							<button class="btn btn-primary btn-user btn-block" id="verifybtn">Verify Email</button>

							<hr>
							<div class="text-center">
								<a class="small" href="/register">Create an Account!</a>
							</div>
							<div class="text-center">
								<a class="small" href="/">Already have an account? Login!</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="checkcodeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Verify...</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<input type="text" class="form-control form-control-user" id="inputCode" placeholder="Enter Code...">
				</div>
				<div id="timer" class="text-center"></div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="#" id="checkcodebtn">Verify</a>
			</div>
		</div>
	</div>
</div>

<!-- changepassmodal -->
<div class="modal fade" id="passwordModal" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="followModalLabel">Change Password</h4>

				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="py-2">Change Password</div>
				<div class="form-group row py-2">
					<div class="col-sm-6">
						<input type="password" class="form-control form-control-user" id="changePassword" placeholder="Password">
					</div>
					<div class="col-sm-6">
						<input type="password" class="form-control form-control-user" id="repeatPassword" placeholder="Repeat Password">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="changepassbtn">Submit</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	var code;
	var usertag;
	var timer;
	$('#verifybtn').on('click', function() {
		var email = new Object();
		email.email = $('#inputEmail').val();

		$.ajax({
			url : "/user/mail",
			contentType : "application/json",
			data : JSON.stringify(email),
			type : "POST",
			async : false,
			success : function(result) {
				if (result.code) {
					code = result.code;
					usertag = result.usertag;
					$('#checkcodeModal').modal("show");
				} else {
					alert("Invalid Email");
				}
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});

	$('#checkcodeModal').on('show.bs.modal', function() {
		var time = 180;
		var min = "";
		var sec = "";
		timer = setInterval(function() {
			console.log(time);
			min = parseInt(time / 60);
			sec = time % 60;
			$('#timer').text(min + ":" + sec);
			time--;
			if (time < 0) {
				clearInterval(timer);
				$('#checkcodeModal').modal("hide");
			}
		}, 1000)
	});

	$('#checkcodeModal').on('hide.bs.modal', function() {
		clearInterval(timer);
	});

	$('#checkcodebtn').on('click', function() {
		if ($('#inputCode').val() == code) {
			$('#checkcodeModal').modal("hide");
			$('#passwordModal').modal("show");
		} else {
			alert("Invaild Code");
		}
	});

	$('#changepassbtn').on('click', function() {
		if ($('#changePassword').val() == $('#repeatPassword').val()) {
			if (!$('#changePassword').val()) {
				alert("Please Check Password");
			} else if ($('#changePassword').val().length < 8) {
				alert("Password is Too Short");
			} else {
				var user = new Object();
				var data = new FormData();

				user.password = $('#changePassword').val();

				data.append("userinfo", JSON.stringify(user));

				$.ajax({
					url : "/user/" + usertag,
					processData : false,
					contentType : false,
					data : data,
					type : "PUT",
					success : function(response) {
						alert("Password Reset.");
						window.location.href = "/";
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}
				})
			}
		} else {
			alert("Please Check Password");
		}
	});
</script>
<%@include file="../includes/footer.jsp"%>