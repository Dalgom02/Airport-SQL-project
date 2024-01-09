<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.cs336.pkg.*,java.sql.*, java.util.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Flights From Specific Airport</title>
</head>
<body>

	<div>
		<form action="QueryFlightsFromAirport.jsp" method="get">
			<label for="airportId">Select Airport</label> 
			<select id="airports" name="airportId"> </select>
			<button type="submit">View Flights</button>
		</form>
	</div>

	<script>
	let airports =
		<%ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	JSONArray flights = new JSONArray();
	final ResultSet rs = stmt.executeQuery("SELECT AirportID, AirportName FROM Airports");
	while (rs.next()) {
		JSONObject finalObject = new JSONObject();
		finalObject.put("AirportName", rs.getString("AirportName"));
		finalObject.put("AirportId", rs.getString("AirportId"));
		flights.put(finalObject);
	}
	out.print(flights);
	rs.close();
	stmt.close();%>
	
	let dropdown = document.querySelector("#airports");
	
	for (let airport of airports) {
		let option = document.createElement("option");
		option.text = airport.AirportName;
		option.value = airport.AirportId;
		dropdown.appendChild(option);
	}
	</script>
</body>
</html>