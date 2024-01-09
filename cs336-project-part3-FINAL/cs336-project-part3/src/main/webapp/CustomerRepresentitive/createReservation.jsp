<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="com.cs336.pkg.*,java.sql.*, java.util.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Reservation</title>
</head>
<body>

	<div>
		<form action="CreateReservationHandler.jsp" method="post">
			<strong>Create Reservation</strong>
			<br><br>
			<label for="customer">Select Customer:</label> 
			<select name="customer" id="users"> </select>
			<br> <br>
			<label>Select Flight</label> 
			<select  id="flights" name="flights" > </select>
			<select name="classSelection" id="classSelection">
            <option value="Economy">Economy</option>
            <option value="Business">Business</option>
            <option value="First">First</option>
        	</select>
			<button type="submit">Create Reservation</button>
		</form>
	</div>

	<script>
	let flights =
		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			JSONArray flights = new JSONArray();
			ResultSet rs = stmt.executeQuery("SELECT * FROM flights");
			while (rs.next()) {
				JSONObject finalObject = new JSONObject();
	        	finalObject.put("departureAirportId", rs.getString("departureAirportId"));
	        	finalObject.put("arrivalAirportId", rs.getString("arrivalAirportId"));
	        	finalObject.put("flightNumber", rs.getString("FlightNumber"));
	        	finalObject.put("departureTime", rs.getString("departureTime"));
	        	finalObject.put("arrivalTime", rs.getString("arrivalTime"));
	        	finalObject.put("flightDate", rs.getString("flightDate"));
	        	finalObject.put("duration", rs.getString("duration"));
				flights.put(finalObject);
			}
			out.print(flights);
			rs.close();
			stmt.close();
		%>
		;
		
		// Departing Flights
		let dropdown = document.querySelector("#flights");
		
		for (let flight of flights) {
			let option = document.createElement("option");
			option.text = flight.departureAirportId + " TO " + " " + flight.arrivalAirportId + ": " + flight.flightDate + " " + flight.departureTime;
			option.value = flight.flightNumber;
			dropdown.appendChild(option);
		}
			
	let users = 
		<%
		Statement Userstmt = con.createStatement();
		JSONArray users = new JSONArray();
		ResultSet Usersrs = Userstmt.executeQuery("SELECT * FROM users WHERE Admin = false and customer_rep = false");
		while (Usersrs.next()) {
			JSONObject finalObject = new JSONObject();
			finalObject.put("username", Usersrs.getString("username"));
			users.put(finalObject);
		}
		out.print(users);
		rs.close();
		stmt.close();
		%>
		;
		
		// User
		let Userdropdown = document.querySelector("#users");
		
		for (let user of users) {
			let option = document.createElement("option");
			option.text = user.username;
			option.value = user.username;
			Userdropdown.appendChild(option);
		}
	</script>
</body>
</html>