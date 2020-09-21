<%@include file="../includes/header.jsp"%>

<div class="container">

	<div class="card o-hidden border-0 shadow-lg my-5">
		<div class="card-body p-0">
			<!-- Nested Row within Card Body -->
			<div class="row">
				<div class="col-lg-7 m-auto">
					<div class="p-5">
						<div class="text-center">
							<h1 class="h4 text-gray-900 mb-4">User Profile</h1>
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
								<label for="userName">Name</label> <input type="text"
									class="form-control-plaintext form-control-user pl-2" id="userName" placeholder="Name">
							</div>

							<div class="form-group">
								<label for="userTag">UserTag</label> <input type="text"
									class="form-control-plaintext form-control-user pl-2" id="userTag" placeholder="Usertag">
							</div>

							<div class="form-group">
								<label for="userPassword">Password</label> <input type="password" readonly
									class="form-control-plaintext form-control-user pl-2" id="userPassword"
									data-toggle="modal" data-target="#checkModal" placeholder="Change Password">
							</div>
							<button class="btn btn-primary btn-user btn-block" id="userupdatebtn">Update
								Profile</button>
							<hr>
							<button class="btn btn-danger btn-user btn-block" id="deleteuserbtn">Delete Account</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- chekcmodal -->
<div class="modal fade" id="checkModal" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="followModalLabel">Check Password</h4>

				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form py-2">
					<label for="userTag">Enter Password</label> <input type="password"
						class="form-control form-control-user" id="checkPassword" placeholder="Enter Password">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="checkpassbtn">Submit</button>
				</div>
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
						<input type="password" class="form-control form-control-user" id="changePassword"
							placeholder="Password">
					</div>
					<div class="col-sm-6">
						<input type="password" class="form-control form-control-user" id="repeatPassword"
							placeholder="Repeat Password">
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

<!-- deleteusermodal -->
<div class="modal fade" id="deleteuserModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Delete Account</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">Are you Sure??</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="#" id="deleteuser">Delete</a>
			</div>
		</div>
	</div>
</div>


<script>
	$(document).ready(function() {
		if (!sessionStorage.getItem("loginuser")) {
			window.location.href = "/";
		}

		var result;
		$.ajax({
			url : "/user/" + sessionStorage.getItem("loginuser"),
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				result = response
			}
		});

		$('#preview').css({
			"background-image" : "url('data:image/jpeg;base64," + result.profileimg + "')"
		});

		$('#userName').val(result.username);
		$('#userTag').val(result.usertag);

		$('#userupdatebtn').on('click', function() {
			var user = new Object();

			var data = new FormData();

			if ($("#upload")[0].files[0]) {
				data.append("upload", $("#upload")[0].files[0])
			}

			if ($('#userTag').val() != result.usertag) {
				if ($('#userTag').val() < 4) {
					alert("Usertag is Too Short");
					return;
				}
				user.usertag = $('#userTag').val();
			}

			if ($('#userName').val() != result.username) {
				user.username = $('#userName').val();
			}

			if ($('#userPassword').val()) {
				user.password = $('#userPassword').val();
			}

			data.append("userinfo", JSON.stringify(user));

			$.ajax({
				url : "/user/" + sessionStorage.getItem("loginuser"),
				processData : false,
				contentType : false,
				data : data,
				type : "PUT",
				success : function(response) {
					if (response) {
						sessionStorage.clear();
						alert("Profile Update success.");
						window.location.href = "/";
					} else {
						alert("Usertag Already Exists");
					}
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		});

		$('#deleteuserbtn').on('click', function() {
			$('#checkModal').modal("show");
			$('#checkpassbtn').attr("data-method", "delete");
			console.log($('#checkpassbtn').attr("data-method"));
		});

		$('#deleteuser').on('click', function() {
			$.ajax({
				url : "/user/delete/" + sessionStorage.getItem("loginuser"),
				type : "DELETE",
				success : function() {
					alert("Thank you For Using Wallendar. Hopfully See You Again!!");
					sessionStorage.clear();
					window.location.href = "/";
				},
				error : function(request, status, error) {
					alert("delete error");
				}
			})
		});

		$('#checkpassbtn').on('click', function() {
			var data = new Object();
			data.email = result.email;
			data.password = $('#checkPassword').val();

			$.ajax({
				url : "/user/login",
				contentType : "application/json",
				data : JSON.stringify(data),
				type : "POST",
				async : false,
				success : function(result) {
					if (result.usertag) {
						$('#checkModal').modal("hide");
						if ($('#checkpassbtn').attr("data-method") == "delete") {
							$('#deleteuserModal').modal("show");
							$('#checkpassbtn').attr("data-method", "");
						} else {
							$('#passwordModal').modal("show");
						}

					} else {
						alert("Invalid Email or Password");
					}
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		});

		$('#changepassbtn').on('click', function() {
			if ($('#changePassword').val() == $('#repeatPassword').val()) {
				if (!$('#changePassword').val()) {
					alert("Please Check Password");
				} else if ($('#changePassword').val().length < 8) {
					alert("Password is Too Short");
				} else {
					$('#userPassword').val($('#changePassword').val());
					$('#passwordModal').modal("hide");
				}
			} else {
				alert("Please Check Password");
			}
		});
	});

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