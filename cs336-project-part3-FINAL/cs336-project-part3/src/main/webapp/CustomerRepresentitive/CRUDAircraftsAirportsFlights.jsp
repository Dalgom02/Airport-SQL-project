<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<a href='WelcomeCustomerRepresentitive.jsp'><button type="button">Back</button></a>
	    <br>
	<section>
		<strong>Airports</strong>
		<br><br>
		<div>
			<strong>Create Airport</strong>
			<form action="HandleAirport.jsp">
				<label for="AirportId">Airport ID</label>
				<br>
				<input type="text" name="AirportId">
				<br><br>
				<label for="AirportName">Airport Name</label>
				<br>
				<input type="text" name="AirportName">
				<br><br>
				<label for="Location">Location</label>
				<br>
				<input type="text" name="Location">
				<br> <br>
				<button type="submit">Create Aircraft</button>
				<br> <br>
			</form>
		</div>
		<br><br>
		<div>
			<strong>Edit Airports</strong>
		<%
			try {
                // Get the database connection
                ApplicationDB db = new ApplicationDB();    
                Connection con = db.getConnection();
                
                // Create a Prepared SQL statement allowing you to introduce the parameters of the query
                String query = "SELECT * FROM airports";
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet result = ps.executeQuery();
                
                out.println("<table border='1'>");
                out.println("<tr><th>Airports</th></tr>");
                
                while (result.next()) {
                    String AirportId = result.getString("AirportID");
                    String AirportName = result.getString("AirportName");
                    String Location = result.getString("Location");
                    out.println("<tr>");
                    out.println("<td>" + AirportId + "</td>");
                    out.println("<td><a href='HandleAirport.jsp?AirportId=" + 
                    		AirportId + 
                    	"&AirportName=" + AirportName +"&Location="+ Location +"&action=edit'><button type='button' style='background-color: grey; color: white;'>Edit</button></a> | <a href='HandleAirport.jsp?AirportId=" + 
                    			AirportId + 
                    	"&action=delete'><button type='button' style='background-color: red; color: white;'>Delete</button></a></td>");
                    out.println("</tr>");
                }
        
                out.println("</table>");
                
                // Close the connection
                con.close();
			} catch (Exception ex) {
				
			}
		%>
		
		</div>
	</section>
	
	<br> <br>
	
	<section>
		<strong>Aircrafts</strong>
		<br> <br>
		<div>
			<form action="HandleAircraft.jsp">
				<strong>Create Aircraft</strong>
				<br>
				<label for ="AircraftID">Aircraft ID</label>
				<br>
				<input type="text" name="AircraftID">
				<br><br>
				<label for="AirlineID">Airline ID</label>
				<br>
				<input type="text" name="AirlineID">
				<br> <br>
				<button type="submit">Create Aircraft</button>
				<br> <br>
			</form>
		</div>
		
		<div>
			<strong>Edit Aircrafts</strong>
			<%
				try {
	                // Get the database connection
	                ApplicationDB db = new ApplicationDB();    
	                Connection con = db.getConnection();
	                
	                // Create a Prepared SQL statement allowing you to introduce the parameters of the query
	                String query = "SELECT * FROM aircrafts";
	                PreparedStatement ps = con.prepareStatement(query);
	                ResultSet result = ps.executeQuery();
	                
	                out.println("<table border='1'>");
	                out.println("<tr><th>Aircrafts</th></tr>");
	                
	                HashMap<String, String> AircraftList = new HashMap<String, String>();
	                while (result.next()) {
	                    String AircraftID = result.getString("AircraftID");
	                    String AirlineID = result.getString("AirlineID");
	                    out.println("<tr>");
	                    out.println("<td>" + AircraftID + "</td>");
	                    out.println("<td><a href='HandleAircraft.jsp?AircraftID=" + 
	                    		AircraftID + 
	                    	"&AirlineID=" + AirlineID + "&action=edit'><button type='button' style='background-color: grey; color: white;'>Edit</button></a> | <a href='HandleAircraft.jsp?AircraftID=" + 
	                    			AircraftID + 
	                    	"&action=delete'><button type='button' style='background-color: red; color: white;'>Delete</button></a></td>");
	                    out.println("</tr>");
	                    AircraftList.put(AircraftID, AirlineID);
	                }
	        
	                out.println("</table>");
	                
	                // Close the connection
	                con.close();
				} catch (Exception ex) {
					
				}
			%>
		</div>
	</section>
	
		<section>
		<strong>Flights</strong>
		<br><br>
		<div>
			<strong>Create Flight</strong>
			<form action="HandleFlights.jsp">
				<label for="FlightNumber">Flight Number</label>
				<br>
				<input type="text" name="FlightNumber">
				<br><br>
				<label for="AirlineID">Airline ID</label>
				<br>
				<input type="text" name="AirlineID">
				<br><br>
				<label for="AircraftID">AircraftID</label>
				<br>
				<input type="text" name="AircraftID">
				<br> <br>
				<label for="DepartureAirportID">Departure Airport ID</label>
				<br>
				<input type="text" name="DepartureAirportID">
				<br> <br>
				<label for="ArrivalAirportID">Arrival Airport ID</label>
				<br>
				<input type="text" name="ArrivalAirportID">
				<br> <br>
				<label for="DepartureTime">Departure Time</label>
				<br>
				<input type="time" name="DepartureTime">
				<br> <br>
				<label for="ArrivalTime">Arrival Time</label>
				<br>
				<input type="time" name="ArrivalTime">
				<br> <br>
				<label for="FlightDate">Flight Date</label>
				<br>
				<input type="date" name="FlightDate">
				<br> <br>
				<label for="DaysOfOperation">Days Of Operation</label>
				<br>
				<input type="text" name="DaysOfOperation">
				<br> <br>
				
				<label for="TotalSeats">Total Seats</label>
				<br>
				<input type="number" name="TotalSeats">
				<br> <br>
				<label for="Price">Price</label>
				<br>
				<input type="number" name="Price">
				<br> <br>
				<label for="Duration">Duration</label>
				<br>
				<input type="number" name="Duration">
				<br> <br>
				<label for="FlightType">Flight Type</label>
				<br>
				<input type="text" name="FlightType">
				<br> <br>
				<button type="submit">Create Flight</button>
				<br> <br>
			</form>
		</div>
		
		<div>
			<strong>Edit Flights</strong>
			<%
				try {
	                // Get the database connection
	                ApplicationDB db = new ApplicationDB();    
	                Connection con = db.getConnection();
	                
	                // Create a Prepared SQL statement allowing you to introduce the parameters of the query
	                String query = "SELECT * FROM flights";
	                PreparedStatement ps = con.prepareStatement(query);
	                ResultSet result = ps.executeQuery();
	                
	                out.println("<table border='1'>");
	                out.println("<tr><th>Flights</th></tr>");
	                
	                while (result.next()) {
	                    String FlightNumber = result.getString("FlightNumber");
	                    out.println("<tr>");
	                    out.println("<td>" + FlightNumber + "</td>");
	                    out.println("<td><a href='HandleFlights.jsp?FlightNumber=" + 
	                    		FlightNumber + "&action=edit'><button type='button' style='background-color: grey; color: white;'>Edit</button></a> | <a href='HandleFlights.jsp?FlightNumber=" + 
	                    				FlightNumber + 
	                    	"&action=delete'><button type='button' style='background-color: red; color: white;'>Delete</button></a></td>");
	                    out.println("</tr>");
	                }
	        
	                out.println("</table>");
	                
	                // Close the connection
	                con.close();
				} catch (Exception ex) {
					
				}
			%>
		</div>
	</section>
	
	
</html>