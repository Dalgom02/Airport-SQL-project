<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*,java.sql.*, java.util.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Flight Waitlist</title>
</head>
<body>
	<strong>View Flight Waitlist</strong>
	
		<form action="QueryFlightWaitlist.jsp" method="post">
			<label for="flightNumber">Flight: </label>
			<select name="flightNumber" id="waitingListDropdown"> </select>
			<button type="submit">View Waitlist</button>
		</form>
	<script>
			let waitingListFlights =
			<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		JSONArray flights = new JSONArray();
		ResultSet rs = stmt.executeQuery("SELECT * FROM flights");
		while (rs.next()) {
			JSONObject finalObject = new JSONObject();
			finalObject.put("flightNumber", rs.getString("FlightNumber"));
			finalObject.put("departureAirportId", rs.getString("departureAirportId"));
			finalObject.put("arrivalAirportId", rs.getString("arrivalAirportId"));
			flights.put(finalObject);
		}
		out.print(flights);
		rs.close();
		stmt.close();%>
				;
				
		let dropdown = document.querySelector("#waitingListDropdown");
		
		for (let flight of waitingListFlights) {
			let option = document.createElement("option");
			option.text = flight.flightNumber;
			option.value = flight.flightNumber;
			dropdown.appendChild(option);
		}
	</script>
</body>
</html>