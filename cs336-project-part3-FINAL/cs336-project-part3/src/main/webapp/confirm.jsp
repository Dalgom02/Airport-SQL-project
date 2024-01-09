<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Confirmation Page</title>
</head>
<body>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the login.jsp
		String user = request.getParameter("username");
		String password = request.getParameter("password");

		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		String query = "SELECT password, admin, customer_rep FROM users WHERE username = ? AND password = ?";
	    PreparedStatement ps = con.prepareStatement(query);
	    ps.setString(1, user);
	    ps.setString(2, password);
		ResultSet result = ps.executeQuery();
		
		if(result.next()) {
			boolean isAdmin = result.getBoolean("admin");
			boolean isRep = result.getBoolean("customer_rep");

			session.setAttribute("username", user);
			session.setAttribute("status", "old");
			if (isAdmin) {
				session.setAttribute("admin", true);
				response.sendRedirect(request.getContextPath() + "/Admin/welcomeAdmin.jsp");
		    } 
			if (isRep) {
				session.setAttribute("CustomerRepresentative", true);
				response.sendRedirect(request.getContextPath() + "/CustomerRepresentitive/WelcomeCustomerRepresentitive.jsp");
		    }
			if(!isAdmin && !isRep) {
				session.setAttribute("admin", false);
		    	session.setAttribute("CustomerRepresentative", false);
		    	response.sendRedirect("welcome.jsp");
		    }
			
		}
		else {
			out.print("Login failed: Username and/or Password incorrect.");
		}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
%>
</body>
</html>