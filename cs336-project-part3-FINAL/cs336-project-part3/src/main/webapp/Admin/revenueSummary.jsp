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
                    String query1 = "SELECT FlightNumber, SUM(TotalFare) AS Flight_Revenue FROM Tickets GROUP BY FlightNumber ORDER BY Flight_Revenue DESC";
                    String query2 = "SELECT A.AirlineName, SUM(T.TotalFare) AS TotalAirlineRevenue " +
		                    		"FROM Tickets T " +
		                    		"JOIN Flights F ON T.FlightNumber = F.FlightNumber " +
		                    		"JOIN Airlines A ON F.AirlineID = A.AirlineID " +
		                    		"GROUP BY A.AirlineName " +
		                    		"ORDER BY TotalAirlineRevenue DESC";
                    String query3 = "SELECT Username, SUM(TotalFare) AS Customer_Revenue FROM Tickets GROUP BY Username ORDER BY Customer_Revenue DESC";
                %>
                    
                    <%  
                    try (PreparedStatement ps = con.prepareStatement(query1);
                         ResultSet result = ps.executeQuery()) {
                        // Check if there are results
                        if (result.next()) {
                %>
                            <table border='1'>
                                <tr>
                                    <th>Flights</th>
                                    <th>Total Revenue</th>
                                </tr>
                <%
                            // Display the flight numbers and ticket counts
                            do {
                                String flightNumber = result.getString("FlightNumber");
                                double total = result.getDouble("Flight_Revenue");
                %>
                                <tr>
                                    <td><%= flightNumber %></td>
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
                    } %>
                    <br>
                    
                    <%  
                    try (PreparedStatement ps = con.prepareStatement(query2);
                         ResultSet result = ps.executeQuery()) {
                        // Check if there are results
                        if (result.next()) {
                %>
                            <table border='1'>
                                <tr>
                                    <th>Airlines</th>
                                    <th>Total Revenue</th>
                                </tr>
                <%
                            // Display the flight numbers and ticket counts
                            do {
                                String flightNumber = result.getString("A.AirlineName");
                                double total = result.getDouble("TotalAirlineRevenue");
                %>
                                <tr>
                                    <td><%= flightNumber %></td>
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
                    } %>
                    <br>
                    
                 <%  
                    try (PreparedStatement ps = con.prepareStatement(query3);
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
                                double total = result.getDouble("Customer_Revenue");
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
