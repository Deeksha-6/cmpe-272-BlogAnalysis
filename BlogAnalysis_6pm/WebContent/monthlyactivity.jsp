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
                <h1 style="margin-top: 0">Opinions Placed on Each Post</h1>
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
		con = DriverManager.getConnection(
				"jdbc:mysql://sql3.freemysqlhosting.net:3306/sql339736", "sql339736", "xS8*xZ3!");

		st = con.createStatement();
		rs = st
				.executeQuery("SELECT COUNT(*) count FROM blogissues");
		
		int topicCnt = 0;

		while (rs.next())
			topicCnt = rs.getInt("count"); 
		
		st = con.createStatement();
		rs = st
				.executeQuery("SELECT result.TopicId TopicId, SUM(result.PComments) PositiveComments, SUM(result.NComments) NegativeComments FROM ( " +
								"SELECT c.TopicId TopicId, COUNT(*) PComments, 0 NComments FROM blogcomments c WHERE c.Score > 0 GROUP BY c.TopicId " +
								"UNION ALL " +
								"SELECT c.TopicId TopicId, 0 PComments, COUNT(*) NComments FROM blogcomments c WHERE c.Score < 0 GROUP BY c.TopicId " +
							 ") result GROUP BY result.TopicId");

		int[] pComments = new int[topicCnt];
		int[] nComments = new int[topicCnt];

		while (rs.next()) {
			pComments[rs.getInt("TopicId") - 1] = rs.getInt("PositiveComments"); 
			nComments[rs.getInt("TopicId") - 1] = rs.getInt("NegativeComments");
		}
		
		con.close();
		
		String pTemp = "", nTemp = "";
		for (int i = 0; i < topicCnt; i++)
		{
			pTemp += pComments[i] + ",";
			nTemp += nComments[i] + ",";
		}
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

<script>
        $(function () {
        	
        	var cnt = parseInt(<%=topicCnt%>);
			var pdt = "<%=pTemp%>";
			var ndt = "<%=nTemp%>";
			
			var pTempArr = pdt.split(",");
			var nTempArr = ndt.split(",");

			var issues = [], pCount = [], nCount = [];

			for (var i = 0; i < cnt; i++)
			{	
				issues[i] = 'Post# ' + (i + 1);
				pCount[i] = parseInt(pTempArr[i]);
				nCount[i] = parseInt(nTempArr[i]);
			}
			
        $('#chartcontainer').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Total Activity On Each Post'
            },
            xAxis: {
                categories: issues
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total Number of Comments'
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -70,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y +'<br/>'+
                        'Total: '+ this.point.stackTotal;
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                        style: {
                            textShadow: '0 0 3px black, 0 0 3px black'
                        }
                    }
                }
            },
            series: [{
                name: 'Positive',
                data: pCount//[5, 3, 4, 7, 2, 4]
            }, {
                name: 'Negative',
                data: nCount//[2, 2, 3, 2, 1, 2]
            }]
        });
    });
    </script>
    <!--Go back to home Page-->
	<script type="text/javascript">
	function goback(){
		window.location.href="index.jsp";
		
	}
	
	</script>
</body>

</html>
