<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sign Up Page</title>
	</head>
	
	<body>
		<strong>Sign Up</strong>					  
		<br>
		<form method="post" action="register.jsp">
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
			<input type="submit" value="SIGN UP">
			<a href='login.jsp'>Have an account already?</a>
		</form>
	<br>
	

</body>
</html>