<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight Search Results</title>
</head>
<body>
    <h1>Flight Search Results</h1>
    <% 
        // Retrieve search results. This can be done via session attributes or other methods.
        // For now, this example uses a simple SQL query for demonstration.

        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
        String query = "SELECT * FROM Flights"; // Modify this query based on actual search criteria passed
        ResultSet rs = stmt.executeQuery(query);

        while(rs.next()) {
            out.println("<p>");
            out.println("Flight Number: " + rs.getString("FlightNumber") + "<br>");
            out.println("Airline: " + rs.getString("AirlineID") + "<br>");
            out.println("Departure: " + rs.getString("DepartureTime") + "<br>");
            out.println("Arrival: " + rs.getString("ArrivalTime") + "<br>");
            out.println("Date: " + rs.getString("FlightDate") + "<br>");
            out.println("Price: " + rs.getString("Price") + "<br>");
            out.println("<a href='reserveFlight.jsp?flightNumber=" + rs.getString("FlightNumber") + "'><button type='button'>Reserve</button></a>");
            // Add more flight details as needed
            out.println("</p>");
        }
        rs.close();
        stmt.close();
        con.close();
    %>

    <!-- Here, you would also add the form or links for sorting and filtering the displayed results -->
    <!-- For example, links that redirect to sortFlights.jsp or filterFlights.jsp with the appropriate parameters -->

</body>
</html>
