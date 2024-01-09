<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Customers List</title>
    </head>
    
    <body>
        <%
        Boolean isAdmin = (Boolean) session.getAttribute("admin");
        String user = (String) session.getAttribute("username");
		
        if (user != null) {
            if (isAdmin) { 
        %>
                <a href='salesReport.jsp'><button type="button">Back</button></a>
                <br>
                <%                 
                try {
                    // Get the database connection
                    ApplicationDB db = new ApplicationDB();    
                    Connection con = db.getConnection();
            
                    Map<String, Integer> months = new HashMap<>();
                    months.put("january", 1);
                    months.put("february", 2);
                    months.put("march", 3);
                    months.put("april", 4);
                    months.put("may", 5);
                    months.put("june", 6);
                    months.put("july", 7);
                    months.put("august", 8);
                    months.put("september", 9);
                    months.put("october", 10);
                    months.put("november", 11);
                    months.put("december", 12);
                    
                    String selectedMonth = request.getParameter("month");
                    int monthNumber = months.get(selectedMonth.toLowerCase());
                    
                    // Create a Prepared SQL statement allowing you to introduce the parameters of the query
                    String query = "SELECT SUM(TotalFare) AS TotalFareSum " +
                   		"FROM Tickets " +
                   		"WHERE YEAR(PurchaseTime) = 2023 AND MONTH(PurchaseTime) = ?";
                    
                    try (PreparedStatement ps = con.prepareStatement(query)) {
				        ps.setInt(1, monthNumber);
				
				        try (ResultSet result = ps.executeQuery()) {
				            if (result.next()) {
				                double totalFareSum = result.getDouble("TotalFareSum");
				                out.println("Sales report for " + 
				                	(selectedMonth.substring(0, 1).toUpperCase() + selectedMonth.substring(1)) 
				                	+ " 2023: $" + String.format("%.2f", totalFareSum));
				            } else {
				                out.println("No data found for the specified month and year.");
				            }
				        }
				    }
                    
                    // Close the connection
                    con.close();
                    
                } catch (Exception ex) {
                    out.print(ex);
                    out.print("Database query failed.");
                }
                %>
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