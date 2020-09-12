<%@include file="../includes/header.jsp"%>

<div class="container">

	<div class="card o-hidden border-0 shadow-lg my-5">
		<div class="card-body p-0">
			<!-- Nested Row within Card Body -->
			<div class="row">
				<div class="col-lg-7 m-auto">
					<div class="p-5">
						<div class="text-center">
							<h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
						</div>
						<div class="user">
							<div class="form-group">
								<input type="email" class="form-control form-control-user" id="registerEmail"
									placeholder="Email Address">
							</div>

							<div class="form-group">
								<input type="text" class="form-control form-control-user" id="registerName"
									placeholder="Name">
							</div>

							<div class="form-group">
								<input type="text" class="form-control form-control-user" id="registerTag"
									placeholder="Usertag">
							</div>

							<div class="form-group row">
								<div class="col-sm-6 mb-3 mb-sm-0">
									<input type="password" class="form-control form-control-user" id="registerPassword"
										placeholder="Password">
								</div>
								<div class="col-sm-6">
									<input type="password" class="form-control form-control-user" id="repeatPassword"
										placeholder="Repeat Password">
								</div>
							</div>
							<button class="btn btn-primary btn-user btn-block" id="registerbtn">Register
								Account</button>
							<hr>
						</div>

						<!-- <div class="text-center">
							<a class="small" href="forgot-password.html">Forgot Password?</a>
						</div> -->
						<div class="text-center">
							<a class="small" href="/">Already have an account? Login!</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

<script>
	$('#registerbtn').on('click', function() {
		if ($('#registerPassword').val() == $('#repeatPassword').val()) {
			var user = new Object();
			user.email = $('#registerEmail').val();
			user.password = $('#registerPassword').val();
			user.username = $('#registerName').val();
			user.usertag = $('#registerTag').val();
			user.salt = null;

			if (checkRegister(user)) {
				$.ajax({
					url : "/user/register",
					contentType : "application/json",
					data : JSON.stringify(user),
					type : "POST",
					success : function(result) {
						console.log(result);
						if (result.email) {
							alert("Email Already Exists");
						} else if (result.usertag) {
							alert("Usertag Already Exists");
						} else {
							alert("Register success");
							window.location.href = "/";
						}
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}
				});
			}
		} else {
			alert("Please Check Password");
		}

	});

	function checkRegister(userInfo) {
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

		console.log(userInfo);

		if (!reg_email.test(userInfo.email) || !userInfo.email) {
			alert("Please Check email");
			return false;
		} else if (!userInfo.username) {
			alert("Please Check Username");
			return false;
		} else if (!userInfo.usertag) {
			alert("Please Check Usertag");
			return false;
		} else if (!userInfo.password) {
			alert("Please Check Password");
			return false;
		} else if (userInfo.password.length < 8) {
			console.log(userInfo.password.length);
			alert("Password is Too Short");
			return false;
		} else {
			return true;
		}

	}
</script>

<%@include file="../includes/footer.jsp"%>