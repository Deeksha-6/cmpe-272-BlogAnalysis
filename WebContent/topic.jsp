
<%@page import="java.sql.*"%>
<%@page import="cmpe.sjsu.edu.parser.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<title>Straight Talk..because every opinion matters</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Add custom CSS here -->
<link href="css/style.css" rel="stylesheet">
<link href='http://fonts.googleapis.com/css?family=Bevan'
	rel='stylesheet' type='text/css'>

</head>

<body>
<script type="text/javascript">
    var queryString = new Array();
    var data = window.location.search.substring(4);
   // alert(data);
</script>

	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Navigation</span> <span class="icon-bar"></span>
					<span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<!--<a class="navbar-brand" href="index.html">Straight Talk</a>-->
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav">
                    <li class="active"><a href="index.jsp">Home</a>
                    </li>
                    <li><a href="about.html">About Us</a>
                    </li>
                    <li><a href="contact.html">Contact Us</a>
                    </li>
                </ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<div class="container">

		<div class="page-header" id="site-header">
			<h1>
				Straight Talk.. <small>because every opinion matters</small>
			</h1>
		</div>

		<%
		String id = request.getQueryString();
				//	out.println(id);
					String [] idd = id.split("=");
					
		String ids = "<script>document.writeln(data)</script>";
		//out.println("data "+data);		
 			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/sentiword", "root", "power");
			Statement st = con.createStatement();
		//	String ids = "<script>document.writeln(data)</script>";
			
			ResultSet rs = st.executeQuery("SELECT * FROM blogissues WHERE id = \"" + idd[1] + "\"");
 			
			String Topic = "", Desc = "",topicImage="";
			while(rs.next())
			{
				Topic = rs.getString("Topic");
				Desc = rs.getString("Description");
				topicImage=rs.getString("ImagePath");
			}
		
 		%>

		<div class="row">

			<div class="col-md-9">
				<h1 style="margin-top: 0"><%= Topic%></h1>
				<div class="clearfix"
					style="text-align: justify; padding: 20px; background: #eee; border: 2px solid #bbb; border-radius: 10px;">
					<div><img src="topicImages/<%=topicImage %>" alt="Image"
						style="float: left; margin-right: 15px; margin-bottom: 15px;" />
				</div>
					<p><%= Desc %>
					</p>
					<div class="clearfix post_comment_box" style="margin-top: 20px;">
						<h3>Post Your Comment</h3>
						<form class="form-horizontal">
							
							
							</div>

							<div class="form-group">
								<label for="message" class="col-lg-2 control-label">Comment</label>
								<div class="col-lg-10">
									<textarea class="form-control" rows="3" id="comments" name="comments" ></textarea>
									<span class="help-block">Comment help text</span>
								</div>
							</div>
							<div class="form-group">
								<div class="col-lg-10 col-lg-offset-2">
									<button type="submit" value="Submit" name="submitbutton" id= "submitbutton"  class="btn btn-success">Submit</button>
								</div>
							</div>
						</form>
					</div>
					<div class="clearfix post_comment_box" style="margin-top: 20px;">
						<h3>See what people are saying..</h3>
						<div class="clearfix" style="margin-top: 30px;">
							<%
								st = con.createStatement();
								rs = st.executeQuery("select Comment from blogcomments WHERE TopicId = \"" + idd[1] + "\"");
								//System.out.println("got data");
								if (rs.next()) {
									//                          	System.out.println("inside if");
									while (rs.next()) {
										String msg = rs.getString("Comment");
							%>
							<div class="media">
								<a class="pull-left" href="#"> <img class="media-object"
									style="width: 64px; height: 64px;" src="images/user.jpg"></a>
								
								<div id="flash" align="left"></div>
 								<ol id="update"><%=msg %></ol>
								</div>

							<%
								}
								} else {
									out.println("No Records Found");
								}
							%>



							<ul class="pagination pagination-sm pull-right">
								<li><a href="#">&laquo;</a></li>
								<li class="active"><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">&raquo;</a></li>
							</ul>

						</div>
					</div>
				</div>
			

			<!-- End main content -->

			<div class="col-md-3">
            <p class="lead">Side Bar Links</p>
                <div class="list-group">
                    <a href="#" class="list-group-item active">
                        <h4 class="list-group-item-heading">Side Bar Link 1</h4>
                        <p class="list-group-item-text">Recent Blog Posts</p>
                      </a>
                    <a href="#" class="list-group-item">Side Bar Link 2</a>
                    <a href="#" class="list-group-item">Side Bar Link 3</a>
                    <a href="#" class="list-group-item">Side Bar Link 4</a>
                    <a href="#" class="list-group-item">Side Bar Link 5</a>
                    <a href="#" class="list-group-item active">Side Bar Link 6</a>
                </div>


				<a class="btn btn-danger btn-block btn-lg" onclick="gotochart()">Monthly
					Analysis of all the Post</a> <a class="btn btn-danger btn-block btn-lg"
					onclick="gotochart1()">Overall Analysis of each Post</a>

			</div>

		</div>

	</div>
	</div>
	<!-- /.container -->

	<div class="container">

		<hr>

		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p class="text-right">Copyright &copy; Company 2014 - Team #21Synergy Spirit
                    </p>
				</div>
			</div>
		</footer>

	</div>
	<!-- /.container -->

	<!-- JavaScript -->
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
		function gotochart() {
			location.href = 'eachissueanalysis.jsp?issueid=<%=idd[1]%>';

		}
	</script>
	<script>
		function gotochart1() {
			location.href = 'analysisofissue.jsp?issueid=<%=idd[1]%>';

		}
	
	</script>
	<script type="text/javascript">
	$("#submitbutton").click(function() {
		var boxval = $("#comments").val();
		alert("boxval"+boxval);
		var dataString = 'comments='+ boxval;
		alert("datastring"+dataString);
		issueid=<%=idd[1]%>;
		url='appendComments.jsp?issueid='+issueid;
		 if(boxval=='')
		{
		alert("Please Enter Some Text");
		
		}
		else
		{
			$("#flash").show();
			$.ajax({
				type: "POST",
				url: url,
				data: dataString,
				cache: false,
				success: function(html){
					//var x = JSON.stringify(html);
					//alert("Output : " + x);
					
				/*	var $newdiv1 = $( "<div id='update'/>"+html ),
  					newdiv2 = document.createElement( "div" ),
  					existingdiv1 = document.getElementById( "update" );
 
					$( "body" ).append( $newdiv1, [ newdiv2, existingdiv1 ] );
					*/
					
					$("ol#update").prepend(html);
					$("ol#update").slideDown("slow");
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
