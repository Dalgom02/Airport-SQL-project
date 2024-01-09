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
        String departureAirport = request.getParameter("departureAirport");
        String arrivalAirport = request.getParameter("arrivalAirport");
        String tripType = request.getParameter("tripType");
        String departureDate = request.getParameter("departureDate");
        String returnDate = request.getParameter("returnDate");
        String flexibleDates = request.getParameter("flexibleDates");

        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
        String query = "SELECT * FROM Flights WHERE DepartureAirportID = '" + departureAirport + "' AND ArrivalAirportID = '" + arrivalAirport + "'";
        
        // Handle flexible date logic
        if ("on".equals(flexibleDates)) {
            query += " AND FlightDate BETWEEN DATE_SUB(STR_TO_DATE('" + departureDate + "', '%Y-%m-%d'), INTERVAL 3 DAY) AND DATE_ADD(STR_TO_DATE('" + departureDate + "', '%Y-%m-%d'), INTERVAL 3 DAY)";
        } else {
            query += " AND FlightDate = STR_TO_DATE('" + departureDate + "', '%Y-%m-%d')";
        }

        // Add logic for round trip
        if ("round-trip".equals(tripType)) {
            // Assuming you want to display the return flight details as well
            // This is a simple example and might need adjustment based on your full requirements
            query += " OR (FlightDate = STR_TO_DATE('" + returnDate + "', '%Y-%m-%d') AND DepartureAirportID = '" + arrivalAirport + "' AND ArrivalAirportID = '" + departureAirport + "')";
        }

        ResultSet rs = stmt.executeQuery(query);
        while(rs.next()) {
            out.println("<p>");
            // Display flight details
            out.println("Flight Number: " + rs.getString("FlightNumber") + "<br>");
            out.println("Airline: " + rs.getString("AirlineID") + "<br>");
            out.println("Departure Airport: " + rs.getString("DepartureAirportID") + "<br>");
            out.println("Arrival Airport: " + rs.getString("ArrivalAirportID") + "<br>");
            out.println("Departure Time: " + rs.getString("DepartureTime") + "<br>");
            out.println("Arrival Time: " + rs.getString("ArrivalTime") + "<br>");
            out.println("Date: " + rs.getString("FlightDate") + "<br>");
            out.println("Price: $" + rs.getString("Price") + "<br>");
            out.println("Duration: " + rs.getString("Duration") + "<br>");
            out.println("<a href='reserveFlight.jsp?flightNumber=" + rs.getString("FlightNumber") + "'><button type='button'>Reserve</button></a>");
            out.println("</p>");
        }
        rs.close();
        stmt.close();
        con.close();
    %>
</body>
</html>
