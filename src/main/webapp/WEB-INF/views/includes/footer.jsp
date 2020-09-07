

<!-- Footer -->
<footer class="sticky-footer bg-white">
	<div class="container my-auto">
		<div class="copyright text-center my-auto">
			<span>Copyright &copy; Wallendar 2020</span>
		</div>
	</div>
</footer>
<!-- End of Footer -->

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
</script>
</body>
</html>