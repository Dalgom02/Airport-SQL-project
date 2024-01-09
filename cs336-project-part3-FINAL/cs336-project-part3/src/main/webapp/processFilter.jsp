<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    String minPrice = request.getParameter("minPrice");
    String maxPrice = request.getParameter("maxPrice");
    String numStops = request.getParameter("numStops");
    String airline = request.getParameter("airline");
    String takeOffTimeStart = request.getParameter("takeOffTimeStart") + ":00";
    String takeOffTimeEnd = request.getParameter("takeOffTimeEnd") + ":00";
    String landingTimeStart = request.getParameter("landingTimeStart") + ":00";
    String landingTimeEnd = request.getParameter("landingTimeEnd") + ":00";

    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();

    StringBuilder queryBuilder = new StringBuilder("SELECT * FROM Flights WHERE 1=1");

    if(minPrice != null && !minPrice.trim().isEmpty()) {
        queryBuilder.append(" AND Price >= ").append(minPrice.trim());
    }
    if(maxPrice != null && !maxPrice.trim().isEmpty()) {
        queryBuilder.append(" AND Price <= ").append(maxPrice.trim());
    }
    if(numStops != null && !numStops.trim().isEmpty()) {
        queryBuilder.append(" AND Stops = ").append(numStops.trim());
    }
    if(airline != null && !airline.trim().isEmpty()) {
        queryBuilder.append(" AND AirlineID = '").append(airline.trim()).append("'");
    }
    if(takeOffTimeStart != null && !takeOffTimeStart.trim().equals(":00") && takeOffTimeEnd != null && !takeOffTimeEnd.trim().equals(":00")) {
        queryBuilder.append(" AND DepartureTime BETWEEN '").append(takeOffTimeStart.trim()).append("' AND '").append(takeOffTimeEnd.trim()).append("'");
    }
    if(landingTimeStart != null && !landingTimeStart.trim().equals(":00") && landingTimeEnd != null && !landingTimeEnd.trim().equals(":00")) {
        queryBuilder.append(" AND ArrivalTime BETWEEN '").append(landingTimeStart.trim()).append("' AND '").append(landingTimeEnd.trim()).append("'");
    }

    String query = queryBuilder.toString();
    ResultSet rs = stmt.executeQuery(query);

    request.setAttribute("filteredFlights", rs);

    RequestDispatcher dispatcher = request.getRequestDispatcher("DisplayFilteredFlights.jsp");
    dispatcher.forward(request, response);

    rs.close();
    stmt.close();
    con.close();
%>
