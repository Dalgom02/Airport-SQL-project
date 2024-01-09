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
                <a href='welcomeAdmin.jsp'><button type="button">Back</button></a>
                <br>
                <%                 
                try {
                    // Get the database connection
                    ApplicationDB db = new ApplicationDB();
                    Connection con = db.getConnection();

                    // SQL query to get flight numbers and the count of tickets for each flight
                    String query = "SELECT Username, SUM(TotalFare) AS Total FROM Tickets GROUP BY Username ORDER BY Total DESC";

                    try (PreparedStatement ps = con.prepareStatement(query);
                         ResultSet result = ps.executeQuery()) {

                        // Check if there are results
                        if (result.next()) {
                %>
                            <table border='1'>
                                <tr>
                                    <th>Customers</th>
                                    <th>Total Revenue</th>
                                </tr>
                <%
                            // Display the flight numbers and ticket counts
                            do {
                                String username = result.getString("Username");
                                double total = result.getDouble("Total");
                %>
                                <tr>
                                    <td><%= username %></td>
                                    <td>$<%= String.format("%.2f", total) %></td>
                                </tr>
                <%
                            } while (result.next());
                %>
                            </table>
                <%
                        } else {
                %>
                            <p>No results found.</p>
                <%
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
