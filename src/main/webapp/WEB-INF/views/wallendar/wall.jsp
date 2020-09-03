<%@include file="../includes/header.jsp"%>
<h2>WALL</h2>

<div id="testdiv"></div>


<script charset="utf-8">


		$(document).ready(function() {
			var url = location.pathname.replace("wall", "post");
			var userpost;
			var tagpost;
			
			$.ajax({
				url : url,
				contentType : "JSON",
				type : "GET",
				async : false,
				success : function(response) {
					userpost = response["userpost"];
					tagpost = response["tagpost"];
					
				}
			}); 
			

			console.log(userpost);
			console.log(tagpost);
			
			for(var i = 0; i < userpost.length; i++){
				$('#testdiv').append(userpost[i]["usertag"] +" ");
				$('#testdiv').append(userpost[i]["postdate"] +" ");
				$('#testdiv').append(userpost[i]["pic"] +"<br>");
				$('#testdiv').append(userpost[i]["tags"] +"<br>");
			}
			
			for(var i = 0; i < tagpost.length; i++){
				$('#testdiv').append(tagpost[i]["usertag"] +" ");
				$('#testdiv').append(tagpost[i]["postdate"] +" ");
				$('#testdiv').append(tagpost[i]["pic"] +"<br>");
				$('#testdiv').append(tagpost[i]["tags"] +"<br>");
			}
			
			});
		
	</script>
<%@include file="../includes/footer.jsp"%>