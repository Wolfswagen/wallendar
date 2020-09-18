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
						<div class="text-center p-3">
							<img class="img-fluid rounded-circle border"
								style="width: 50%; height: 50%; background-size: cover; background-color: white"
								src="../image/thumbnail.png" id="preview">
						</div>
						<div class="input-group py-3">

							<div class="input-group-prepend">
								<span class="input-group-text" id="uploadgroup">Profile Image</span>
							</div>
							<div class="custom-file">
								<input type="file" class="custom-file-input" id="upload" aria-describedby="uploadgroup">
								<label class="custom-file-label" for="upload" id="uploadlabel">Choose File</label>
							</div>
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
								<div class="col-sm-6">
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
			var data = new FormData();

			user.email = $('#registerEmail').val();
			user.password = $('#registerPassword').val();
			user.username = $('#registerName').val();
			user.usertag = $('#registerTag').val();

			if ($("#upload")[0].files[0]) {
				data.append("upload", $("#upload")[0].files[0]);
			}

			data.append("userinfo", JSON.stringify(user));

			if (checkRegister()) {
				console.log($("#upload")[0].files[0]);
				$.ajax({
					url : "/user/register",
					processData : false,
					contentType : false,
					data : data,
					type : "POST",
					success : function(result) {
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

	function checkRegister() {
		console.log("check");
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

		if (!reg_email.test($('#registerEmail').val()) || !$('#registerEmail').val()) {
			alert("Please Check email");
			return false;
		} else if (!$('#registerName').val()) {
			alert("Please Check Username");
			return false;
		} else if ($('#registerTag').val() < 4) {
			alert("Usertag is Too Short");
			return false;
		} else if (!$('#registerPassword').val()) {
			alert("Please Check Password");
			return false;
		} else if ($('#registerPassword').val().length < 8) {
			alert("Password is Too Short");
			return false;
		} else {
			return true;
		}

	}

	$("#upload").change(function() {
		readURL(this);
	});

	function readURL(input) {
		$('#preview').css({
			"background-image" : "url()"
		});
		$('.custom-file-label').text('Choose File');
		if (/\.(gif|jpg|jpeg|png)$/i.test(input.files[0].name)) {
			if (input.files && input.files[0]) {
				var name = input.files[0].name;
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#preview').css({
						"background-image" : "url(" + e.target.result + ")"
					});
					$('.custom-file-label').text(name);
				}
				reader.readAsDataURL(input.files[0]);
			}
		} else {
			alert('Please Choose Image File');
		}
	}
</script>

<%@include file="../includes/footer.jsp"%>