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
                <h1 style="margin-top: 0">About Us</h1>
                <div class="clearfix" style="text-align: justify; padding: 30px 20px; background: #eee; border: 2px solid #bbb; border-radius: 10px;">
                   
                    <p>Blogs have developed to "multi-author blogs" with posts written by large number of authors and professionally edited. Blogs from newspaper, other media outlets, universities, think tanks, advocacy groups and similar institutions account want discussions to be maintained in the blogs.Our Application allows better organization of the discussion data and better view of the discussions with graphical representation of discussion and comments posted for each issue.
Our Application allows the user to glance at the issues faster with graphical representation of the issues status showing positive and negative analysis of the comments. Our application also shows the most active issue in the Blog. In this application the user can view the following graphs:</br></br> 
<i>Graphs depicting comparing of positive and negative for each issue posting on the Blog.</br></br>
Graphs depicting how comments are posted for each month with respect to each issue.</br></br>
Graph depicting overall analysis of issue showing which issue has the highest comments posting and which issue has maximum positive  ,negative comments posted.</br></br>
Graph depicting  Monthly activity with respect to all issues.</br></br></i>
On the whole it lets the user to glance through blog faster , hence saving his time.</br></br>
This can be used for receiving customer reviews  for better Products and Services, hence increasing your sales. This analysis API can also be used for customer support as it helps to know how customers think about your Product. So to connect to your customer better use this API.
                       </p>                    
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
    <!-- /.container -->

    <!-- JavaScript -->
    <!--Go back to home page-->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>
	<script type="text/javascript">
	function goback(){
		window.location.href="index.jsp";
		
	}
	
	</script>
</body>

</html>
