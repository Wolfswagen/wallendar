<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/calendar/css/calstyle.css">

<div class="container">
	<div class="my-calendar clearfix">
		<div class="clicked-date">
			<div class="cal-date"></div>
			<div class="cal-thumbnail" data-toggle="modal" data-target="#exampleModal" id="post"></div>
		</div>
		<div class="calendar-box">
			<div class="ctr-box clearfix">
				<button type="button" title="prev" class="btn-cal prev"></button>
				<span class="cal-month"></span> <span class="cal-year"></span>
				<button type="button" title="next" class="btn-cal next"></button>
			</div>
			<table class="cal-table">
				<thead>
					<tr>
						<th>S</th>
						<th>M</th>
						<th>T</th>
						<th>W</th>
						<th>T</th>
						<th>F</th>
						<th>S</th>
					</tr>
				</thead>
				<tbody class="cal-body"></tbody>
			</table>
		</div>
	</div>
	<!-- // .my-calendar -->
</div>

<div class="modal fade " id="exampleModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
>
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">New message</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form>
					<div class="text-center">
						<label for="pic" class="col-form-label"></label>
						<img class="img-fluid" id="pic">
					</div>
					<div class="text-center p-5">
						<label for="tags" class="col-form-label">Tags</label>
						<p class="form-control-plaintext text-left" id="tags"></p>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<!-- <button type="button" class="btn btn-primary">Send message</button> -->
			</div>
		</div>
	</div>
</div>



<script src="/calendar/js/calendar.js"></script>

<script>
	$(document).ready(function() {

		$('.cal-body').on('click', function(e) {
			if (e.target.classList.contains('day')) {
				if (init.activeDTag) {
					init.activeDTag.classList.remove('day-active');
				}
				let day = Number(e.target.textContent);
				var postdate = $('.cal-year').text() + "-" + (init.monList.indexOf($('.cal-month').text()) + 1) + "-" + e.target.textContent;
				loadDate(postdate);
				e.target.classList.add('day-active');
				init.activeDTag = e.target;
				init.activeDate.setDate(day);
				$.ajax({
					url : location.pathname + "/" + $('#usertag').text() + "/" + postdate,
					contentType : "JSON",
					type : "GET",
					success : function(response) {
						console.log(response);
						if (response == undefined) {
							$(".cal-thumbnail").css({
								"background-image" : "url('')"
							});
							$('.cal-thumbnail').addClass("empty-post");
						} else {
							$(".cal-thumbnail").css({
								"background-image" : "url(../" + response["pic"] + ")"
							});
						}
					}
				});

			}
		});

		$('#exampleModal').on('show.bs.modal', function(event) {

			var postdate = $('.cal-date').text();
			var modal = $(this);
			var result;
			$.ajax({
				url : location.pathname + "/" + $('#usertag').text() + "/" + postdate + "/" + "tags",
				contentType : "JSON",
				type : "GET",
				async : false,
				success : function(response) {
					result = response;
					console.log("ajax" + result);
				}
			});
			var pic = $('.cal-thumbnail').css('background-image');
			pic = pic.substring(26, pic.indexOf('")'));
			modal.find('.modal-title').text(postdate);
			modal.find('#pic').attr("src", pic);

			$('#tags').empty();

			$('#tags').append("#" + $('#usertag').text() + "<br/>");
			for ( var tag in result) {
				console.log(result[tag]["tag"]);
				$('#tags').append("#" + result[tag]["tag"]);
			}
		})

	});
</script>

<%@include file="../includes/footer.jsp"%>