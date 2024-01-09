<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Add New Customer</title>
	</head>
	
	<body>
		<strong>Add New Customer</strong>					  
		<br>
		<%
			String repParam = request.getParameter("rep");
			Boolean isRep = Boolean.parseBoolean(repParam);
		%>
		<form method="post" action="registerCustomer.jsp?rep=<%= isRep %>">
			<table>
				<tr>    
					<td>Username:</td><td><input type="text" name="username" required></td>
				</tr>
				<tr>
					<td>Password:</td><td><input type="password" name="password1" required></td>
				</tr>
				<tr>
					<td>Confirm Password:</td><td><input type="password" name="password2" required></td>
				</tr>
			</table>
			<input type="submit" value="ADD">
		</form>
	<br>
	

</body>
</html>