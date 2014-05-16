<%@page import="java.sql.*"%>
<%@page import="cmpe.sjsu.edu.parser.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

     <title>Straight Talk.. because every opinion matters</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Add custom CSS here -->
    <link href="css/style.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Bevan' rel='stylesheet' type='text/css'>

</head>

<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
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
            <h1>Straight Talk.. <small>because every opinion matters</small></h1>
        </div>

        <div class="row">

            <div class="col-md-9">
                <h1 style="margin-top: 0"></h1>
                <div class="clearfix" style="text-align: justify; padding: 20px; background: #eee; border: 2px solid #bbb; border-radius: 10px;">
                <div id="chartcontainer" style="width:100%; height:400px;"></div>

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


                <button class="btn btn-danger btn-block btn-lg" onclick="goback();" >Back</button>
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
    	String id = request.getQueryString();
    	//	out.println(id);
    	String [] idd = id.split("=");

        con = db.getDbConnection();
		st = con.createStatement();
		rs = st
				.executeQuery("SELECT ROUND((SELECT SUM(c.Score) FROM blogcomments c WHERE c.topicid = \"" + idd[1] + "\" AND c.Score > 0), 2) PositiveScore, " + 
								"ROUND(ABS((SELECT SUM(c.Score) FROM blogcomments c WHERE c.TopicId = \"" + idd[1] + "\" AND c.Score < 0)), 2) NegativeScore");
		
		int pscore = 0, nscore = 0;

		while (rs.next()) {
			pscore = rs.getInt("PositiveScore");
			nscore = rs.getInt("NegativeScore");
		}
		
		con.close();

	%>
    
    <!-- /.container -->

    <!-- JavaScript -->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/Chart.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/modules/exporting.js"></script>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/highcharts.js"></script>

<script type="text/javascript">
    $(function() {			    	   
    $('#chartcontainer').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Seniment Analysis for the issue'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Issue',
            data: [
                ['Positive', <%=pscore%>],
                ['Negative', <%=nscore%>],
            ]
        }]
    });
});
    </script>
<script type="text/javascript">
	function goback(){
		issueid="<%=idd[1]%>";
		window.location.href="topic.jsp?issueid="+issueid;
		
	}
	
	</script>
</body>

</html>