<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
    <title>Filtered Flight Results</title>
</head>
<body>
    <h1>Filtered Flight Results</h1>
    <%
        ResultSet filteredFlights = (ResultSet) request.getAttribute("filteredFlights");
        while(filteredFlights.next()) {
            out.println("<p>");
            out.println("Flight Number: " + filteredFlights.getString("FlightNumber") + "<br>");
            out.println("Airline: " + filteredFlights.getString("AirlineID") + "<br>");
            out.println("Departure Airport: " + filteredFlights.getString("DepartureAirportID") + "<br>");
            out.println("Arrival Airport: " + filteredFlights.getString("ArrivalAirportID") + "<br>");
            out.println("Departure Time: " + filteredFlights.getString("DepartureTime") + "<br>");
            out.println("Arrival Time: " + filteredFlights.getString("ArrivalTime") + "<br>");
            out.println("Price: $" + filteredFlights.getString("Price") + "<br>");
            out.println("<a href='reserveFlight.jsp?flightNumber=" + filteredFlights.getString("FlightNumber") + "'><button type='button'>Reserve</button></a>");
            out.println("</p>");
        }
    %>
</body>
</html>
