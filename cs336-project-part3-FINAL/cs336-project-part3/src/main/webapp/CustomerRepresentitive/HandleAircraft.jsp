<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Handle Aircraft</title>
</head>
<body>
	<%
	    // Get the database connection
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
   		
	    String AircraftId = request.getParameter("AircraftID");
	    String Action = Optional.ofNullable(request.getParameter("action")).orElse("create");
	    String AirlineId = request.getParameter("AirlineID");
 
	    PreparedStatement stmt;
	    String command;
	    switch(Action) {
	    case "delete":
	    	command = "DELETE FROM aircrafts WHERE AircraftID = ?;";
	    	stmt = con.prepareStatement(command);
	    	stmt.setString(1, AircraftId);
	    	stmt.executeUpdate();
	    	con.close();
	    	response.sendRedirect("CRUDAircraftsAirportsFlights.jsp");
	    	break;
	    case "edit":
	    	break;
	    default: 
	    	command = "INSERT INTO aircrafts(AircraftID, AirlineID)"
		    		+ "VALUES (?, ?)";
	    	stmt = con.prepareStatement(command);
	    	stmt.setString(1, AircraftId);
	    	stmt.setString(2, AirlineId);
	    	stmt.executeUpdate();
	    	con.close();
	    	response.sendRedirect("CRUDAircraftsAirportsFlights.jsp");
	    	break;
	    }
	   
	%>
	
	<h1>Edit Aircraft</h1>
	
	<form action="HandleUpdates.jsp">
		<input type="hidden" id="model" name="typeOfModel" value="Aircraft">
		
		<label for ="AircraftId">Aircraft ID</label>
		<br>
			<input type='text' name='AircraftId' value='<% out.println(AircraftId); %>'>
		<br><br>
		<label for="AirlineId">Airline ID</label>
		<br>
		<input type="text" name="AirlineId" value='<% out.println(AirlineId); %>'>
		<br> <br>
		<button type="submit">Update Aircraft</button>
		<br> <br>
	</form>
</body>
</html>