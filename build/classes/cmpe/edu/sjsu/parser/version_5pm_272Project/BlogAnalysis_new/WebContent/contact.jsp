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
                    <h1 style="margin-top: 0">Contact Us</h1>
                    <div class="clearfix" style="text-align: justify">
                        <form class="form-horizontal" style="padding: 30px 20px; background: #eee; border: 2px solid #bbb; border-radius: 10px;">
                                <div class="form-group">
                                    <label for="inputName" class="col-lg-2 control-label">Name</label>
                                    <div class="col-lg-10">
                                        <input type="text" class="form-control" id="inputName" placeholder="Your Good Name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-lg-2 control-label">Email</label>
                                    <div class="col-lg-10">
                                        <input type="text" class="form-control" id="inputEmail" placeholder="Email">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="message" class="col-lg-2 control-label">Message</label>
                                    <div class="col-lg-10">
                                        <textarea class="form-control" rows="3" id="message"></textarea>
                                        <span class="help-block">Message help text</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-10 col-lg-offset-2">
                                        <button type="submit" class="btn btn-success">Submit</button>
                                    </div>
                                </div>
                        </form>                  
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
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/bootstrap.js"></script>
		<script type="text/javascript">
	function goback(){
		window.location.href="index.jsp";
		
	}
	
	</script>
    </body>

</html>
