<%@include file="../includes/header.jsp"%>
<body>
	<h2>Hello</h2>
	<div>JSP List Test</div>
	<c:forEach var="post" items="${posts }">
		<br>
		<a href='${post.usertag}/<fmt:formatDate pattern="yyyy-MM-dd" value="${ post.postdate}"/>'>${post.pic}
			link</a>
		<br>
	</c:forEach>

	<%@include file="../includes/footer.jsp"%>