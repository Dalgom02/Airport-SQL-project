	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page import="com.cs336.pkg.ApplicationDB"%>
	<%@ page import="java.io.*,java.util.*,java.sql.*"%>
	
	<!DOCTYPE html>
	<html>
	<head>
	    <title>Filter Flights</title>
	</head>
	<body>
	    <h1>Filter Flights</h1>
	    <form action="processFilter.jsp" method="post">
	        <!-- Price Range -->
	        <label for="minPrice">Minimum Price:</label>
	        <input type="number" name="minPrice" id="minPrice">
	        <label for="maxPrice">Maximum Price:</label>
	        <input type="number" name="maxPrice" id="maxPrice">
	        <br><br>
	
	        <!-- Number of Stops -->
	        <label for="numStops">Number of Stops:</label>
	        <input type="number" name="numStops" id="numStops" min="0">
	        <br><br>
	
	        <!-- Airline Selection -->
	        <label for="airline">Airline:</label>
	        <select name="airline" id="airline">
	            <option value="">None</option>
	            <% 
	                ApplicationDB db = new ApplicationDB();
	                Connection con = db.getConnection();
	                Statement stmt = con.createStatement();
	                ResultSet rs = stmt.executeQuery("SELECT AirlineID, AirlineName FROM Airlines");
	                while(rs.next()) {
	                    out.println("<option value='" + rs.getString("AirlineID") + "'>" + rs.getString("AirlineName") + "</option>");
	                }
	                rs.close();
	                stmt.close();
	                con.close();
	            %>
	        </select>
	        <br><br>
	
	        <!-- Take-Off Time Range -->
	        <label for="takeOffTimeStart">Take-Off Time Start:</label>
	        <input type="time" name="takeOffTimeStart" id="takeOffTimeStart">
	        <label for="takeOffTimeEnd">End:</label>
	        <input type="time" name="takeOffTimeEnd" id="takeOffTimeEnd">
	        <br><br>
	
	        <!-- Landing Time Range -->
	        <label for="landingTimeStart">Landing Time Start:</label>
	        <input type="time" name="landingTimeStart" id="landingTimeStart">
	        <label for="landingTimeEnd">End:</label>
	        <input type="time" name="landingTimeEnd" id="landingTimeEnd">
	        <br><br>
	
	        <input type="submit" value="Filter">
	    </form>
	</body>
	</html>
