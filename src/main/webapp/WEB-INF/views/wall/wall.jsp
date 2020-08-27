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
	<%@include file="../includes/footer.jsp"%>