<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sorted Flight Results</title>
</head>
<body>
    <h1>Sorted Flight Results</h1>
    <%
        String sortAttribute = request.getParameter("sortAttribute");
        String sortOrder = request.getParameter("sortOrder");

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();

        String orderByClause = "";
        if ("price".equals(sortAttribute)) {
            orderByClause = "Price";
        } else if ("takeOffTime".equals(sortAttribute)) {
            orderByClause = "DepartureTime";
        } else if ("landingTime".equals(sortAttribute)) {
            orderByClause = "ArrivalTime";
        } else if ("duration".equals(sortAttribute)) {
            orderByClause = "Duration";
        }

        orderByClause += " " + ("ascending".equals(sortOrder) ? "ASC" : "DESC");

        String query = "SELECT * FROM Flights ORDER BY " + orderByClause;
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
            out.println("<p>");
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
    <p>
        <a href='welcome.jsp'><button type="button">Return to Welcome Page</button></a>
        <a href='tripTypeSelection.jsp'><button type="button">New Flight Search</button></a>
        <a href='sortSelection.jsp'><button type="button">Sort Flights Again</button></a>
    </p>
</body>
</html>
