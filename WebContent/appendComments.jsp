<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
    <%@page import="cmpe.sjsu.edu.parser.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>append comments</title>
</head>

<body>
<% 
	String comment= request.getParameter("comments");
	//String issueid=request.getParameter("issueid");
	String issueid = request.getQueryString();
	//out.println("getQueryString va"+issueid);
	//	out.println(id);
		String [] idd = issueid.split("=");
	int topicId=Integer.parseInt(idd[1]);
	
	TaggerExample tagger1=new TaggerExample();
	try {
		 
		tagger1.insertIntoDBComment(comment,topicId);
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	
	}
try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sentiword","root","power");
	Statement st = con.createStatement();
	ResultSet rs=st.executeQuery("select Comment from blogcomments WHERE id = \"" + idd[1] + "\"");
	//System.out.println("got data");
	
if(rs.next())
{
//	System.out.println("inside if");
		while(rs.next())
		{
			String msg=rs.getString("Comment");
			System.out.println("msg:"+msg);
		%>
		
		<div align="left">
		<span style=" padding:10px"><%= msg %> </span>
		</div>
		
		<%
		
		}
}
else{
		out.println("No Records Found");
	}
}

catch(Exception e){
Exception ex = e;
out.println("Mysql Database Connection Not Found");
}
%>
</body>
=======
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
    <%@page import="cmpe.sjsu.edu.parser.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>append comments</title>
</head>

<body>
<% 
	String comment= request.getParameter("comments");
	//String issueid=request.getParameter("issueid");
	String issueid = request.getQueryString();
	//out.println("getQueryString va"+issueid);
	//	out.println(id);
		String [] idd = issueid.split("=");
	int topicId=Integer.parseInt(idd[1]);
	
	TaggerExample tagger1=new TaggerExample();
	try {
		 
		tagger1.insertIntoDBComment(comment,topicId);
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	
	}
try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sentiword","root","power");
	Statement st = con.createStatement();
	ResultSet rs=st.executeQuery("select Comment from blogcomments WHERE id = \"" + idd[1] + "\"");
	//System.out.println("got data");
	
if(rs.next())
{
//	System.out.println("inside if");
		while(rs.next())
		{
			String msg=rs.getString("Comment");
			System.out.println("msg:"+msg);
		%>
		
		<div align="left">
		<span style=" padding:10px"><%= msg %> </span>
		</div>
		
		<%
		
		}
}
else{
		out.println("No Records Found");
	}
}

catch(Exception e){
Exception ex = e;
out.println("Mysql Database Connection Not Found");
}
%>
</body>
>>>>>>> FETCH_HEAD
</html>