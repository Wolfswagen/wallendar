<%@include file="../includes/header.jsp"%>
<body>
	<h2>WALL</h2>
	<div>JSP List Test</div>
	${post.pic}
	<br>
	<br> #${post.usertag}
	<c:forEach var="tag" items="${tags }">
		#${tag.tag}
	</c:forEach>

	<form
		action='/${post.usertag}/<fmt:formatDate pattern="yyyy-MM-dd" value="${ post.postdate}"/>'
		method="post">
		<input type="button" id="delete" value="delete">
	</form>
	<script>
		$('#delete').click(function() {
			$.ajax({
				url: window.location.pathname,
				type: "delete",
				  success: (data, textStatus, jqXHR) => {
				        console.log('success');
				        console.log(data);
				        console.log(textStatus);
				        console.log(jqXHR);
				        
				    }
			})
			window.location.replace('/${post.usertag}');
		});
	</script>
	<%@include file="../includes/footer.jsp"%>