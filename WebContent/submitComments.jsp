<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="cmpe.sjsu.edu.parser.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form method="post" name="f1">
		<div >
 		<textarea style="border:black solid 1px; " name="comments" id="comments" rows="4" cols="50"> </textarea><br />
   			<input type="submit" value="Submit" name="submitbutton" id= "submitbutton"  style="margin-left:370px;"/>
 		</div>
 		<div id="flash" align="left"></div>
 		<ol id="update">
 		</ol>
	</form>
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<script type="text/javascript">
//function onSubmit() {
	//alert("in submit button");
$("#submitbutton").click(function() {
	var boxval = $("#comments").val();
	alert("boxval"+boxval);
	var dataString = 'comments='+ boxval;
	alert("datastring"+dataString);
	 if(boxval=='')
	{
	alert("Please Enter Some Text");
	
	}
	else
	{
		$("#flash").show();
		$.ajax({
			type: "POST",
			url: "appendComments.jsp",
			data: dataString,
			cache: false,
			success: function(html){
				//var x = JSON.stringify(html);
				//alert("Output : " + x);
				 $("ol#update").prepend(html);
				$("ol#update li:first").slideDown("slow");
				document.getElementById('comments').value='';
				$("#flash").hide();
			}
			
			});
}
	 return false;
	});



</script>
</body>
</html>