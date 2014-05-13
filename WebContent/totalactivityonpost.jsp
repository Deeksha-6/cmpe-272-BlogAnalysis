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
                    <li><a href="about.jsp">About Us</a>
                    </li>
                    <li><a href="contact.jsp">Contact Us</a>
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

		<div class="row">

			<div class="col-md-9">
				<h1 style="margin-top: 0">Monthly Blog Analysis</h1>
				<div class="clearfix"
					style="text-align: justify; padding: 20px; background: #eee; border: 2px solid #bbb; border-radius: 10px;">
					<div id="chartcontainer" style="width: 100%; height: 400px;"></div>

					<a class="btn btn-block btn-primary" href="topic.html"
						style="margin-top: 20px;">&leftarrow; Go Back</a>
				</div>
			</div>

			<!-- End main content -->

			<div class="col-md-3">
               <div class="list-group">
                    <a href="#" class="list-group-item active">
                        <h4 class="list-group-item-heading">Recent Blog Posts</h4>
                      </a><%
                      
                      			Class.forName("com.mysql.jdbc.Driver").newInstance();
                      			Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/sentiword", "root", "power");
                      			Statement st1 = con1.createStatement();
								//                      	String ids = "<script>document.writeln(data)</script>";

					String query = "SELECT i.Id, Topic, g.date FROM blogissues i " +
							"INNER JOIN " +
							"( " +
							"SELECT TopicID, date FROM (SELECT TopicID, Date FROM blogcomments WHERE TopicId  = 1 ORDER BY date DESC LIMIT 1) a " +
							"UNION ALL " +
							"SELECT TopicID, date FROM (SELECT TopicID, Date FROM blogcomments WHERE TopicId  = 2 ORDER BY date DESC LIMIT 1) b " +
							"UNION ALL " +
							"SELECT TopicID, date FROM (SELECT TopicID, Date FROM blogcomments WHERE TopicId  = 3 ORDER BY date DESC LIMIT 1) c " +
							"UNION ALL " +
							"SELECT TopicID, date FROM (SELECT TopicID, Date FROM blogcomments WHERE TopicId  = 4 ORDER BY date DESC LIMIT 1) d " +
							"UNION ALL " +
							"SELECT TopicID, date FROM (SELECT TopicID, Date FROM blogcomments WHERE TopicId  = 5 ORDER BY date DESC LIMIT 1) e " +
							"UNION ALL " +
							"SELECT TopicID, date FROM (SELECT TopicID, Date FROM blogcomments WHERE TopicId  = 6 ORDER BY date DESC LIMIT 1) f " +
							") g ON g.TopicId = i.id " +
							"ORDER BY g.date DESC";
					 ResultSet rs1 = st1.executeQuery(query);	
                     
					while(rs1.next()){
                      %>
 		                   <a href="topic.jsp?id=<%=rs1.getString("Id")%>" class="list-group-item" ><%=rs1.getString("Topic") %></a>
                    <%
                    }
                    %>
                    
                    </div>

				<button class="btn btn-danger btn-block btn-lg" onclick="goback();">Back</button>
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

	<%
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/sentiword", "root", "power");
		Statement st = con.createStatement();
		ResultSet rs = st
				.executeQuery("SELECT `TopicId`, `month`, `count` FROM ( "
						+ "SELECT YEAR(c.date) AS `year`, MONTH(c.date) AS `month`, c.TopicId AS `TopicId`, COUNT(*) AS `count` "
						+ "FROM blogcomments c "
						+ "GROUP BY `year`, `month`, `TopicId` "
						+ ") AS result WHERE `year` = 2014 ORDER BY `TopicId`");

		int[] issue1 = new int[12];
		int[] issue2 = new int[12];
		int[] issue3 = new int[12];
		int[] issue4 = new int[12];
		int[] issue5 = new int[12];
		int[] issue6 = new int[12];

		String temp1 = "", temp2 = "", temp3 = "", temp4 = "", temp5 = "", temp6 = "";
		while (rs.next()) {
			int topicId = rs.getInt("TopicId");

			if (topicId == 1)
				issue1[rs.getInt("month") - 1] = rs.getInt("count");

			if (topicId == 2)
				issue2[rs.getInt("month") - 1] = rs.getInt("count");

			if (topicId == 3)
				issue3[rs.getInt("month") - 1] = rs.getInt("count");

			if (topicId == 4)
				issue4[rs.getInt("month") - 1] = rs.getInt("count");

			if (topicId == 5)
				issue5[rs.getInt("month") - 1] = rs.getInt("count");

			if (topicId == 6)
				issue6[rs.getInt("month") - 1] = rs.getInt("count");
		}
		
		for (int i = 0; i < 12; i++)
		{
			temp1 += issue1[i] + ",";
			temp2 += issue2[i] + ",";
			temp3 += issue3[i] + ",";
			temp4 += issue4[i] + ",";
			temp5 += issue5[i] + ",";
			temp6 += issue6[i] + ",";
		}
	%>

	<!-- /.container -->

	<!-- JavaScript -->
	<!--Total Analyis Chart -->
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/Chart.min.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="http://code.highcharts.com/highcharts.js"></script>
	<script src="http://code.highcharts.com/modules/exporting.js"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/highcharts.js"></script>

	<script>
		$(function () {
			
			var dt1 = "<%=temp1%>";
			var dt2 = "<%=temp2%>";
			var dt3 = "<%=temp3%>";
			var dt4 = "<%=temp4%>";
			var dt5 = "<%=temp5%>";
			var dt6 = "<%=temp6%>";
			
			var temparr1 = dt1.split(",");
			var temparr2 = dt2.split(",");
			var temparr3 = dt3.split(",");
			var temparr4 = dt4.split(",");
			var temparr5 = dt5.split(",");
			var temparr6 = dt6.split(",");

			var count1 = [], count2 = [], count3 = [], count4 = [], count5 = [], count6 = [];

			for (var i = 0; i < 12; i++)
			{
				count1[i] = parseInt(temparr1[i]);
				count2[i] = parseInt(temparr2[i]);
				count3[i] = parseInt(temparr3[i]);
				count4[i] = parseInt(temparr4[i]);
				count5[i] = parseInt(temparr5[i]);
				count6[i] = parseInt(temparr6[i]);
			}
			
			$('#chartcontainer').highcharts(
					{
						title : {
							text : 'Monthly Activity On Blog Posts',
							x : -20
						//center
						},
						subtitle : {
							text : 'Source: BlogAnalysis.com',
							x : -20
						},
						xAxis : {
							categories : [ 'Jan', 'Feb', 'Mar', 'Apr', 'May',
									'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov',
									'Dec' ]
						},
						yAxis : {
							min : 0,
							title : {
								text : 'Total Number Of Comments'
							},
							plotLines : [ {
								value : 0,
								width : 1,
								color : '#808080'
							} ]
						},
						tooltip : {
							valueSuffix : 'Comments'
						},
						legend : {
							layout : 'vertical',
							align : 'right',
							verticalAlign : 'middle',
							borderWidth : 0
						},
						series : [
								{
									name : 'Post #1',
									data : count1//[ 7, 6, 9, 14, 18, 21, 25, 26, 23, 18, 13, 9 ]
								},
								{
									name : 'Post #2',
									data : count2//[ 0, 0, 5, 11, 17, 22, 24, 21, 20, 14, 8, 2 ]
								},
								{
									name : 'Post #3',
									data : count3//[ 1, 0, 3, 8, 13, 17, 18, 17, 14, 9, 3, 1 ]
								},
								{
									name : 'Post #4',
									data : count4//[ 3, 4, 5, 8, 11, 15, 17, 16, 14, 10, 6, 4 ]
								},
								{
									name : 'Post #5',
									data : count5//[ 2, 4, 5, 8, 11, 15, 17, 16, 10, 15, 6, 4 ]
								},
								{
									name : 'Post #6',
									data : count6//[ 2, 4, 5, 20, 11, 12, 17, 16, 10, 15, 6, 4 ]
								} ]
					});
		});
	</script>
<script type="text/javascript">
	function goback(){
		window.location.href="index.jsp";
		/* Goes back to index page */
		
	}
	
	</script>
</body>

</html>
