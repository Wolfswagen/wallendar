<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<link href="/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css">

<title>Wallendar</title>

<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<!-- Custom fonts for this template -->
<link href="/theme/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/theme/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="/theme/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>
<body id="page-top">
	<!-- Topbar -->
	<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">


		<!-- Topbar Search -->
		<div class="d-none d-sm-inline-block form-inline ml-md-3 my-2 my-md-0 mw-100 navbar-search">
			<div class="input-group">
				<input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
					aria-label="Search" aria-describedby="basic-addon2" id="search">
				<div class="input-group-append">
					<button class="btn btn-secondary" type="button" id="search-btn">
						<i class="fas fa-search fa-sm"></i>
					</button>
				</div>
			</div>
		</div>

		<div>
			<button class="btn btn-secondary ml-1" id="calbtn">calendar</button>
			<button class="btn btn-secondary" id="wallbtn">wall</button>
		</div>



		<!-- Topbar Navbar -->
		<ul class="navbar-nav ml-auto">

			<!-- Nav Item - Search Dropdown (Visible Only XS) -->
			<li class="nav-item dropdown no-arrow d-sm-none"><a class="nav-link dropdown-toggle"
				href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
			</a> <!-- Dropdown - Messages -->
				<div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
					aria-labelledby="searchDropdown">
					<form class="form-inline mr-auto w-100 navbar-search">
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small" id="search-xs"
								placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button class="btn btn-secondary" type="button" id="search-btn-xs">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>
				</div></li>


			<!-- 			Nav Item - User Information -->
			<li class="nav-item dropdown no-arrow"><a class="nav-link dropdown-toggle" href="#"
				id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <span class="mr-2 d-none d-lg-inline text-gray-600 small"
					id="logged-on-user"></span> <img class="img-profile rounded-circle"
					src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
			</a> <!-- Dropdown - User Information -->
				<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
					aria-labelledby="userDropdown">
					<a class="dropdown-item" href="#"> <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
						Profile
					</a> <a class="dropdown-item" href="#"> <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
						Settings
					</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"> <i
						class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> Logout
					</a>
				</div></li>

		</ul>
	</nav>
	<!-- End of Topbar -->