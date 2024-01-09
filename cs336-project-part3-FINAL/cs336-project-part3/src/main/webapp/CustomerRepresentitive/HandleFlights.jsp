<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Handle Flights</title>
</head>
<body>
	<%
	    // Get the database connection
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
   		
	    String FlightNumber = request.getParameter("FlightNumber");
	    String AirlineID = request.getParameter("AirlineID");
	    String AircraftID = request.getParameter("AircraftID");
	    String DepartureAirportID = request.getParameter("DepartureAirportID");
	    String ArrivalAirportID = request.getParameter("ArrivalAirportID");
	    String DepartureTime = request.getParameter("DepartureTime");
	    String ArrivalTime = request.getParameter("ArrivalTime");
	    String FlightDate = request.getParameter("FlightDate");
	    String DaysOfOperation = request.getParameter("DaysOfOperation");
	    String TotalSeats = request.getParameter("TotalSeats");
	    String Price = request.getParameter("Price");
	    String Duration = request.getParameter("Duration");
	    String FlightType = request.getParameter("FlightType");

	    String Action = Optional.ofNullable(request.getParameter("action")).orElse("create");
 
	    PreparedStatement stmt;
	    String command;
	    switch(Action) {
	    case "delete":
	    	command = "DELETE FROM flights WHERE FlightNumber = ?;";
	    	stmt = con.prepareStatement(command);
	    	stmt.setString(1, FlightNumber);
	    	stmt.executeUpdate();
	    	con.close();
	    	response.sendRedirect("CRUDAircraftsAirportsFlights.jsp");
	    	break;
	    case "edit":
	    	command = "SELECT * FROM flights WHERE FlightNumber = ?;";
	    	stmt = con.prepareStatement(command);
	    	stmt.setString(1, FlightNumber);
            ResultSet result = stmt.executeQuery();
	        if (result.next()) {
                FlightNumber = result.getString("FlightNumber");
        	    AirlineID = result.getString("AirlineID");
        	    AircraftID = result.getString("AircraftID");
        	    DepartureAirportID = result.getString("DepartureAirportID");
        	    ArrivalAirportID = result.getString("ArrivalAirportID");
        	    DepartureTime = result.getString("DepartureTime");
        	    ArrivalTime = result.getString("ArrivalTime");
        	    FlightDate = result.getString("FlightDate");
        	    DaysOfOperation = result.getString("DaysOfOperation");
        	    TotalSeats = result.getString("TotalSeats");
        	    Price = result.getString("Price");
        	    Duration = result.getString("Duration");
        	    FlightType = result.getString("FlightType");
			} 	            
	        con.close();
	    	break;
	    default: 
	    	command = "INSERT INTO flights(FlightNumber, AirlineID, AircraftID, DepartureAirportID, ArrivalAirportID, DepartureTime, ArrivalTime, FlightDate, DaysOfOperation, TotalSeats, SeatsAvailable, Price, Duration, FlightType)"
		    		+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 5, ?, ?, ?)";
	    	stmt = con.prepareStatement(command);
	    	stmt.setString(1, FlightNumber);
	    	stmt.setString(2, AirlineID);
	    	stmt.setString(3, AircraftID);
	    	stmt.setString(4, DepartureAirportID);
	    	stmt.setString(5, ArrivalAirportID);
	    	stmt.setString(6, DepartureTime);
	    	stmt.setString(7, ArrivalTime);
	    	stmt.setString(8, FlightDate);
	    	stmt.setString(9, DaysOfOperation);
	    	stmt.setInt(10, Integer.parseInt(TotalSeats));
	    	stmt.setDouble(11, Double.parseDouble(Price));
	    	stmt.setString(12, Duration);
	    	stmt.setString(13, FlightType);
	    	stmt.executeUpdate();
	    	con.close();
	    	response.sendRedirect("CRUDAircraftsAirportsFlights.jsp");
	    	break;
	    }
	   
	%>
	
	<h1>Edit Flight</h1>
	
	<form action="HandleUpdates.jsp">
		<input type="hidden" id="model" name="typeOfModel" value="Flight">
		<button type="submit">Update Flight</button>
		<br> <br>
		<label for="FlightNumber">Flight Number</label>
		<br>
		<input type="text" name="FlightNumber" value='<% out.println(FlightNumber); %>' readonly>
		<br><br>
		<label for="AirlineID">Airline ID</label>
		<br>
		<input type="text" name="AirlineID" value='<% out.println(AirlineID); %>'>
		<br><br>
		<label for="AircraftID">AircraftID</label>
		<br>
		<input type="text" name="AircraftID" value='<% out.println(AircraftID); %>'>
		<br> <br>
		<label for="DepartureAirportID">Departure Airport ID</label>
		<br>
		<input type="text" name="DepartureAirportID" value='<% out.println(DepartureAirportID); %>'>
		<br> <br>
		<label for="ArrivalAirportID">Arrival Airport ID</label>
		<br>
		<input type="text" name="ArrivalAirportID" value='<% out.println(ArrivalAirportID); %>'>
		<br> <br>
		<label for="DepartureTime">Departure Time</label>
		<br>
		<input type="text" name="DepartureTime" value='<% out.println(DepartureTime); %>'>
		<br> <br>
		<label for="ArrivalTime">Arrival Time</label>
		<br>
		<input type="text" name="ArrivalTime" value='<% out.println(ArrivalTime); %>'>
		<br> <br>
		<label for="FlightDate">Flight Date</label>
		<br>
		<input type="text" name="FlightDate" value='<% out.println(FlightDate); %>'>
		<br> <br>
		<input type="text" name="DaysOfOperation" value='<% out.println(DaysOfOperation); %>'>
		<br> <br>
		
		<label for="TotalSeats">Total Seats</label>
		<br>
		<input type="text" name="TotalSeats" value='<% out.println(TotalSeats); %>'>
		<br> <br>
		<label for="Price">Price</label>
		<br>
		<input type="text" name="Price" value='<% out.println(Price); %>'>
		<br> <br>
		<label for="Duration">Duration</label>
		<br>
		<input type="text" name="Duration" value='<% out.println(Duration); %>'>
		<br> <br>
		<label for="FlightType">Flight Type</label>
		<br>
		<input type="text" name="FlightType" value='<% out.println(FlightType); %>'>
		<br> <br>
	</form>
</body>
</html>