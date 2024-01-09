<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!-- Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Admin Page</title>
</head>
<body>
    <%
        String username = (String) session.getAttribute("username");
        String status = (String) session.getAttribute("status");
        Boolean isAdmin = (Boolean) session.getAttribute("admin");

        if (username != null) {
            if (isAdmin) { %>
                <h1>Admin Page</h1>
        <% } 
            else { 
            } %>
			<a href="<%= request.getContextPath() %>/logout.jsp"><button type="button">Log Out</button></a>
    <% } 
        else {
        	response.sendRedirect(request.getContextPath() + "/login.jsp");
    	}
        out.println("<a href='editCustomers.jsp'><button type='button'>View Customers/Representatives</button></a>");
        out.println("<a href='salesReport.jsp'><button type='button'>Sales Report</button></a>");
        out.println("<a href='reservationList.jsp'><button type='button'>Reservation List</button></a>");
        
        out.println("<a href='revenueSummary.jsp'><button type='button'>Revenue Summary</button></a>");
        out.println("<a href='customerRevenue.jsp'><button type='button'>Revenue By Customer</button></a>");
        out.println("<a href='mostActiveFlights.jsp'><button type='button'>Most Active Flights</button></a>");

    %>
</body>
</html>
