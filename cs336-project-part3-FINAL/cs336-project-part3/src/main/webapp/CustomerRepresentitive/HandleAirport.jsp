<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Handle Airport</title>
</head>
<body>
	<%
	    // Get the database connection
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
   		
	    String AirportId = request.getParameter("AirportId");
	    String Action = Optional.ofNullable(request.getParameter("action")).orElse("create");
	    String AirportName = request.getParameter("AirportName");
	    String Location = request.getParameter("Location");
 
	    PreparedStatement stmt;
	    String command;
	    switch(Action) {
	    case "delete":
	    	command = "DELETE FROM airports WHERE AirportId = ?";
	    	stmt = con.prepareStatement(command);
	    	stmt.setString(1, AirportId);
	    	stmt.executeUpdate();
		    con.close();
		    response.sendRedirect("CRUDAircraftsAirportsFlights.jsp");
	    	break;
	    case "edit":
	    	break;
	    default: 
	    	command = "INSERT INTO airports(AirportId, AirportName, Location)"
		    		+ "VALUES (?, ?, ?)";
	    	stmt = con.prepareStatement(command);
	    	stmt.setString(1, AirportId);
	    	stmt.setString(2, AirportName);
	    	stmt.setString(3, Location);
	    	stmt.executeUpdate();
		    con.close();
		    response.sendRedirect("CRUDAircraftsAirportsFlights.jsp");
	    	break;
	    }
	%>
	
	<h1>Edit Airport</h1>
	
	<form action="HandleUpdates.jsp">
		<input type="hidden" id="model" name="typeOfModel" value="Airport">
		
		<label for ="AirportId">Airport ID</label>
		<br>
			<input type='text' name='AirportId' value='<% out.println(AirportId); %>'>
		<br><br>
		<label for="AirportName">Airport Name</label>
		<br>
		<input type="text" name="AirportName" value='<% out.println(AirportName); %>'>
		<br> <br>
		<label for="Location">Location</label>
		<br> <br>
		<input type="text" name="Location" value='<% out.println(Location); %>'>
		<br><br>
		<button type="submit">Update Airport</button>
		<br> <br>
	</form>
</body>
</html>