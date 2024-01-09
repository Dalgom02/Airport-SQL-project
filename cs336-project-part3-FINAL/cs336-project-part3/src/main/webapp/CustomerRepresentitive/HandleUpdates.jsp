<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Handle Updates</title>
</head>
<body>
	<%
		String model = request.getParameter("typeOfModel");
	
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
		
	    PreparedStatement stmt;
	    String command;
		switch(model) {
			case "Aircraft":
				String AircraftId = request.getParameter("AircraftId");
				String AirlineId = request.getParameter("AirlineId");
				command = "UPDATE aircrafts SET AirlineID = ? WHERE AircraftID = ?";
				stmt = con.prepareStatement(command);
				stmt.setString(1, AirlineId);
				stmt.setString(2, AircraftId);
				stmt.executeUpdate();
				break;
			case "Airport":
				String AirportId = request.getParameter("AirportId");
				String AirportName = request.getParameter("AirportName");
				String Location = request.getParameter("Location");
				command = "UPDATE airports SET AirportName = ?, Location = ? WHERE AirportId = ?";
				stmt = con.prepareStatement(command);
				stmt.setString(1, AirportName);
				stmt.setString(2, Location);
				stmt.setString(3, AirportId);
				stmt.executeUpdate();
				break;
			case "Flight":
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
				command = "UPDATE flights SET AirlineID = ?, AircraftID = ?, DepartureAirportID = ?, ArrivalAirportID = ?, DepartureTime = ?, ArrivalTime = ?, FlightDate = ?, DaysOfOperation = ?, TotalSeats = ?, Price = ?, Duration = ?, FlightType = ? WHERE FlightNumber = ?";
				stmt = con.prepareStatement(command);
		    	stmt.setString(1, AirlineID);
		    	stmt.setString(2, AircraftID);
		    	stmt.setString(3, DepartureAirportID);
		    	stmt.setString(4, ArrivalAirportID);
		    	stmt.setString(5, DepartureTime);
		    	stmt.setString(6, ArrivalTime);
		    	stmt.setString(7, FlightDate);
		    	stmt.setString(8, DaysOfOperation);
		    	stmt.setInt(9, Integer.parseInt(TotalSeats));
		    	stmt.setDouble(10, Double.parseDouble(Price));
		    	stmt.setString(11, Duration);
		    	stmt.setString(12, FlightType);				
		    	stmt.setString(13, FlightNumber);
				stmt.executeUpdate();
				break;
		}
		con.close();
    	response.sendRedirect("CRUDAircraftsAirportsFlights.jsp");
			
	%>
</body>
</html>