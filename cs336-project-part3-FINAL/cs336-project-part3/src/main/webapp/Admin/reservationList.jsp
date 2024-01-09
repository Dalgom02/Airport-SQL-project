<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Sort Reservation List</title>
    </head>
    
    <body>
        <%
        Boolean isAdmin = (Boolean) session.getAttribute("admin");
        String user = (String) session.getAttribute("username");
		
        if (user != null) {
            if (isAdmin) { 
        %>
                <a href='welcomeAdmin.jsp'><button type="button">Back</button></a>
                <h1>Sort Reservation List</h1>
			    <form action="sortReservations.jsp" method="post">
			        <label for="sortedBy">Sort by:</label>
			        <select name="sortedBy" id="sortedBy">
			            <option value="flightNumber">Flight Number</option>
			            <option value="february">Customer Name</option>
			        </select>
			        <input type="text" name="input" required>
			        <br><br>
			        <input type="submit" value="Submit">
			    </form>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/logout.jsp"><button type="button">Log Out</button></a>
                <p>You do not have permission to view this page.</p>
            <% }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
        %>
        <br>
    </body>
</html>