<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Sales Report</title>
    </head>
    
    <body>
        <%
        Boolean isAdmin = (Boolean) session.getAttribute("admin");
        String user = (String) session.getAttribute("username");
		
        if (user != null) {
            if (isAdmin) { 
        %>
                <a href='welcomeAdmin.jsp'><button type="button">Back</button></a>
                <h1>Sales Report</h1>
			    <form action="calculateSalesReport.jsp" method="post">
			        <label for="month">Month:</label>
			        <select name="month" id="month">
			            <option value="january">January</option>
			            <option value="february">February</option>
			            <option value="march">March</option>
			            <option value="april">April</option>
   			            <option value="may">May</option>
   			            <option value="june">June</option>
   			            <option value="july">July</option>
   			            <option value="august">August</option>
   			            <option value="september">September</option>
   			            <option value="october">October</option>
   			            <option value="november">November</option>
   			            <option value="december">December</option>
			        </select>
			        <label>2023</label>
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
