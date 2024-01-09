<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register Confirmation Page</title>
</head>
<body>
	<%
	try {
		//Get parameters from the HTML form at the signup.jsp
		String user = request.getParameter("username");
		String password = request.getParameter("password1");
		String confirmPassword = request.getParameter("password2");
		
		if(!password.equals(confirmPassword)) {
			out.print("The passwords do not match. <a href='signup.jsp'><button type='button'>Back</button></a>");
			return;
		}
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String query = "SELECT username FROM users WHERE username = ?";
	    PreparedStatement ps = con.prepareStatement(query);
	    ps.setString(1, user);
		ResultSet result = ps.executeQuery();
		
		if(result.next()) {
			out.print("User already exists. <a href='signup.jsp'><button type='button'>Back</button></a>");
		}
		else {
			String insert = "INSERT INTO users(username, password, admin, customer_rep)"
				+ "VALUES (?, ?, false, false)";
		    PreparedStatement newUser = con.prepareStatement(insert);
		    newUser.setString(1, user);
		    newUser.setString(2, password);			
		    newUser.executeUpdate();
			session.setAttribute("username", user);
			session.setAttribute("status", "new");
			response.sendRedirect("welcome.jsp");
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