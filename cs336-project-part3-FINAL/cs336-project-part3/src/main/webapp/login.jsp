<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Page</title>
	</head>
	
	<body>
		<strong>Login</strong>					  
		<br>
		<form method="get" action="confirm.jsp">
			<table>
				<tr>    
					<td>Username:</td><td><input type="text" name="username" required></td>
				</tr>
				<tr>
					<td>Password:</td><td><input type="password" name="password" required></td>
				</tr>
			</table>
			<input type="submit" value="LOGIN">
			<a href='signup.jsp'>Don't have an account yet?</a>
		</form>
	<br>
	

</body>
</html>