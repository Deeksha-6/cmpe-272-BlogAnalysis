<%@page import="java.sql.*"%>

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
                <!-- Begin Slider -->
                <div class="row carousel-holder">

                    <div class="col-md-12">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="4" ></li>
                                <li data-target="#carousel-example-generic" data-slide-to="5"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="6"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="7"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="8" ></li>
                                <li data-target="#carousel-example-generic" data-slide-to="9"></li>
                               
                            </ol>
                            <div class="carousel-inner">
                                <div class="item active">
                                    <img class="slide-image" src="images/toptop1.jpg" alt="">
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="images/toptop2.jpg" alt="">
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="images/toptop4.jpg" alt="">
                                </div>
                                <div class="item">
                                    <img   class="slide-image" src="images/toptop5.jpg" alt="">
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="images/toptop6.jpg" alt="">
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="images/toptop3.jpg" alt="">
                                </div>
                                
                            </div>
                            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        </div>
                    </div>

                </div>
                <!-- end slider -->

                <!-- Main Content -->
                <div class="row" style="margin-top: 40px;">
<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection(
		"jdbc:mysql://sql3.freemysqlhosting.net:3306/sql339736", "sql339736", "xS8*xZ3!");
Statement st = con.createStatement();
//	String ids = "<script>document.writeln(data)</script>";

ResultSet rs = st.executeQuery("SELECT * FROM blogissues");
	
String Topic = "", Desc = "",topicImage="",topicId="",shortDesc="";
while(rs.next())
{
	Topic = rs.getString("Topic");
	//Desc = rs.getString("Description");
	topicImage=rs.getString("ImagePath");
	topicId=rs.getString("Id");
	Desc=rs.getString("ShortDescription");
	%>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail" style="padding: 12px;box-shadow: 1px 1px 5px #aaa;">
                          <a href="topic.jsp?id=<%=topicId %>"><h4><%=Topic %></h4></a>
                            <img src="topicImages/<%=topicImage %>" alt="">
                            <p>
                               <%=Desc %>
                               <a href="topic.jsp?id=<%=topicId %>">Read More</a></p>
                        </div>
                    </div>
                    <%
                    rs.next();
                    Topic = rs.getString("Topic");
                	//Desc = rs.getString("Description");
                	topicImage=rs.getString("ImagePath");
                	topicId=rs.getString("Id");
                	Desc=rs.getString("ShortDescription");
                	 %>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail" style="padding: 12px;box-shadow: 1px 1px 5px #aaa;">
                            <a href="topic.jsp?id=<%=topicId %>"><h4><%=Topic %></h4></a>
                            <img src="topicImages/<%=topicImage %>" alt="">
                            <p>
                               <%=Desc %>
                               <a href="topic.jsp?id=<%=topicId %>">Read More</a></p>
                        </div>
                    </div>
                     <%
                    rs.next();
                     Topic = rs.getString("Topic");
                 	//Desc = rs.getString("Description");
                 	topicImage=rs.getString("ImagePath");
                 	topicId=rs.getString("Id");
                 	Desc=rs.getString("ShortDescription");
                 	 %>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail" style="padding: 12px;box-shadow: 1px 1px 5px #aaa;">
                            <a href="topic.jsp?id=<%=topicId %>"><h4><%=Topic %></h4></a>
                            <img src="topicImages/<%=topicImage %>" alt="">
                            <p>
                               <%=Desc %>
                               <a href="topic.jsp?id=<%=topicId %>">Read More</a></p>
                        </div>
                    </div>
  <%
}

con.close();
%>
	</div>
            </div>
            <!-- End main content -->

            <div class="col-md-3">
               <div class="list-group">
                    <a href="#" class="list-group-item active">
                        <h4 class="list-group-item-heading">Recent Blog Posts</h4>
                      </a><%
                      		Class.forName("com.mysql.jdbc.Driver").newInstance();
                      			Connection con1 = DriverManager.getConnection("jdbc:mysql://sql3.freemysqlhosting.net:3306/sql339736", "sql339736", "xS8*xZ3!");
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
					con1.close();
                    %>    </div>

                <button class="btn btn-danger btn-block btn-lg" onclick="gotochart1()" >Monthly Activity on Blog</button>
                <button class="btn btn-danger btn-block btn-lg" onclick="gotochart2()" >Comparision btween Threads</button>

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
      <script src="js/Chart.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/modules/exporting.js"></script>
    <script src="/js/jquery.min.js"></script>
    <script src="/js/highcharts.js"></script>
    
    <script>
      function gotochart1(){
          location.href='totalactivityonpost.jsp';
      }
      function gotochart2(){
          location.href='monthlyactivity.jsp';
      }

  </script>
</body>

</html>
