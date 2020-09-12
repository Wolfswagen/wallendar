<%@include file="../includes/header.jsp"%>
<h2>WALL</h2>
<div class="text-center" id="userpost">
	<input type="text" class="text-center border-0 text-secondary" style="font-size: 32px" readonly size="30" id="seldate">
</div>
<div class="text-center py-3" id="result">
	<h2>No Result</h2>
</div>
<div class="container-fluid">
	<div class="row row-cols-1 text-center" id="resultrow"></div>
</div>



<script charset="utf-8">
	$(document).ready(function() {

		if (!sessionStorage.getItem("loginuser")) {
			window.location.href = "/";
		}

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
			$('#result').text("");
		}

		for (var i = 0; i < result.length; i++) {
			$('#resultrow').append('<div class ="p-3 col"> <h4>@'+result[i].usertag+'</h4> <img class="border rounded" id = "thumbnail' + i + '" style="width:100%; max-width:800px; background:url(../' + result[i]["pic"] + ') no-repeat center center; background-size:cover; " src = /image/thumbnail.png><h4>'+result[i].tags.substring(0,result[i].tags.length-1)+'</h4></div>');
			$('#thumbnail' + i).attr("data-post", JSON.stringify(result[i]));
		}

		$('.rounded').on('click', function(event) {

			var post = JSON.parse($(event.target).attr("data-post"))

			setReadModal(post);
			$('#readModal').modal("show");
		});

	});

	$("#seldate").on('change', function() {
		window.location.href = $("#seldate").val();
	});
</script>
<%@include file="../includes/footer.jsp"%>