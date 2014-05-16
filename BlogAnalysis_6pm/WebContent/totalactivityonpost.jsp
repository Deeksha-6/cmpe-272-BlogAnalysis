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

					</div>
			</div>

			<!-- End main content -->

			<div class="col-md-3">
               <div class="list-group">
                    <a href="#" class="list-group-item active">
                        <h4 class="list-group-item-heading">Recent Blog Posts</h4>
                      </a><%
                      
                    dbAcessClass db = new dbAcessClass();
                    Connection con = db.getDbConnection();
           			Statement st = con.createStatement();
								//                      	String ids = "<script>document.writeln(data)</script>";

					String query = "SELECT i.Id, Topic, g.date FROM blogissues i INNER JOIN " +
									"(	SELECT DISTINCT MAX(date) date, topicid " + 
									"	FROM blogcomments GROUP BY (topicid) ORDER BY date DESC " +
									") g ON g.TopicId = i.id ORDER BY g.date DESC";

					ResultSet rs = st.executeQuery(query);	
                     
					while(rs.next()){
                      %>
 		                   <a href="topic.jsp?id=<%=rs.getString("Id")%>" class="list-group-item" ><%=rs.getString("Topic") %></a>
                    <%
                    }
					
					con.close();
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
    	con = db.getDbConnection();
		st = con.createStatement();
		rs = st
				.executeQuery("SELECT COUNT(*) count FROM blogissues");
		
		int cnt = 0;
		while(rs.next())
			cnt = rs.getInt("count");
		
		st = con.createStatement();
		rs = st
				.executeQuery("SELECT `TopicId`, `month`, `count` FROM ( "
							+ "SELECT YEAR(c.date) AS `year`, MONTH(c.date) AS `month`, c.TopicId AS `TopicId`, COUNT(*) AS `count` "
							+ "FROM blogcomments c "
							+ "GROUP BY `year`, `month`, `TopicId` "
							+ ") AS result WHERE `year` = 2014 ORDER BY `TopicId`");

		String months = "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec";
		int monthCnt = months.split(",").length;
		int[][] issues = new int[cnt][monthCnt];

		String temp = "";
		
		while (rs.next()) 
			issues[rs.getInt("TopicId") - 1][rs.getInt("month") - 1] = rs.getInt("count"); 
		
		con.close();
		
		for (int i = 0; i < cnt; i++)
			for (int j = 0; j < monthCnt; j++)
				temp += issues[i][j] + ",";
		
	%>

	<!-- /.container -->

	<!-- JavaScript -->
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
		var months = "<%=months%>".split(","); 
		var counts = "<%=temp%>".split(",");
		var topicCnt = parseInt("<%=cnt%>");
		var recCount = topicCnt * months.length;
		
		var names = new Array();
		var readings = new Array();

		for (var i = 0, k = 0; i < topicCnt; i++)
			for (var j = 0; j < months.length; j++)
			{
				names.push('Post #' + (i + 1));  
				readings.push(parseInt(counts[k]));
				k++;
			}
		
	    var series = generateData();

	    function generateData() {
	        var ps = [], series = [];

	        //concat to get points
	        for (var i = 0; i < recCount; i++) {
	            ps[i] = {
	                y: readings[i],
	                n: names[i]
	            };
	        }
	        names = [];
	        //generate series and split points
	        for (i = 0; i < recCount; i++) {
	            var p = ps[i],
	                sIndex = $.inArray(p.n, names);

	            if (sIndex < 0) {
	                sIndex = names.push(p.n) - 1;
	                series.push({
	                    name: p.n,
	                    data: []
	                });
	            }
	            series[sIndex].data.push(p);
	        }
	        return series;
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
						categories : months
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
					series : series
				});
	});
	</script>
<script type="text/javascript">
	function goback(){
		window.location.href="index.jsp";
		
	}
	
	</script>
</body>

</html>
