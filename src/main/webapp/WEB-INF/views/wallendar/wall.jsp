<%@include file="../includes/header.jsp"%>
<h2>WALL</h2>
<div class="text-center" id="userpost">
	<input type="text" class="text-center border-0" readonly size="30" id="seldate">
</div>
<div class="container-fluid text-center" id="dateposts">No Result</div>


<script charset="utf-8">
	$(document).ready(function() {
		var url = location.pathname.replace("wall", "post/date");
		var date = url.replace("/post/date/", "");

		var result;

		$("#seldate").datepicker();
		$("#seldate").datepicker("option", "dateFormat", "yy-mm-dd");
		$("#seldate").datepicker("setDate", date);

		$.ajax({
			url : url,
			contentType : "JSON",
			type : "GET",
			async : false,
			success : function(response) {
				result = response;
			}
		});

		if (result.length > 0) {
			$('#dateposts').text("");
		}

		for (var i = 0; i < result.length; i++) {
			$('#dateposts').append('<div class="modal-dialog modal-xl" role="document">' + '<div class="modal-content">' + '<div class="modal-header">' + '<h5 class="modal-title">' + formDate(result[i]["postdate"]) + '</h5></div>' + '<div class="modal-body">' + '<h5 class="input-group-prepend">@' + result[i]["usertag"] + '</h5>' + '<div class="text-center">' + '<img class="img-fluid" src="../'+result[i]["pic"]+'"></div>' + '<div class="p-5"><h5>Tags</h5>' + '<p class="form-control-plaintext text-left">' + result[i]["tags"].substring(0, result[i]["tags"].length-1) + '</p>' + '</div></div></div></div>');
		}

		$("#seldate").on('change', function() {
			window.location.href = $("#seldate").val();
		});
	});
</script>
<%@include file="../includes/footer.jsp"%>