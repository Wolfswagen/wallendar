<%@include file="../includes/header.jsp"%>
<body>


	<div class="uploadDiv">
		<input type="file" name="upload">
	</div>

	<button id="uploadBtn">Upload</button>
	<input type="hidden" name="postdate">

	<script>
		$(document).ready(function() {

			$("#uploadBtn").on("click", function(e) {
				var formData = new FormData();

				var inputFile = $("input[name='upload']");

				var files = inputFile[0].files;

				for (var i = 0; i < files.length; i++) {
					formData.append("upload", files[i]);
				}
				
				
				
				formData.append("postdate", "2020-08-29");

				/* $.ajax({
					url : "upload",
					processData : false,
					contentType : false,
					data : formData,
					type : "POST",
					success : function(result) {
						alert("uploaded");
					}

				});
 */			});
		});
	</script>
</body>
</html>