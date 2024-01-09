<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<strong>Departing and Arriving Flights</strong>
	<div>
		<strong>Arrivals</strong>
		<ol id="arrivals"></div>
	</div>
	
	<div>
		<strong>Departures</strong>
		<ol id="departures"></ol>
	</div>
	
	<script>
		let arrivals = <%
		  // Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        Connection con = db.getConnection();
	        String query = "SELECT * FROM flights WHERE ArrivalAirportID = ?";
	        
	        
	        String airportId = request.getParameter("airportId");
	        PreparedStatement ps = con.prepareStatement(query);
	        ps.setString(1, airportId);
	        
	        ResultSet rs = ps.executeQuery();
	        
	        JSONArray arrivalFlight = new JSONArray();
	        while (rs.next()) {
	        	JSONObject finalObject = new JSONObject();
	        	finalObject.put("departureAirportId", rs.getString("departureAirportId"));
	        	finalObject.put("arrivalAirportId", rs.getString("arrivalAirportId"));
	        	finalObject.put("departureTime", rs.getString("departureTime"));
	        	finalObject.put("arrivalTime", rs.getString("arrivalTime"));
	        	finalObject.put("flightDate", rs.getString("flightDate"));
	        	finalObject.put("duration", rs.getString("duration"));
	        	arrivalFlight.put(finalObject);
	        }
	        out.print(arrivalFlight);
		%>;
		
		let orderedList = document.querySelector("#arrivals");
		
		for (let arrival of arrivals) {
			let list = document.createElement("li");
			list.innerHTML = arrival.departureAirportId + "'s  flight leaves at " + arrival.departureTime + " and arrives here at " + arrival.arrivalTime;
			orderedList.appendChild(list);
		}
		
			let departures = <%
					String departureQuery = "SELECT * FROM flights WHERE departureAirportId = ?";
	        PreparedStatement DeparturePs = con.prepareStatement(query);
	        DeparturePs.setString(1, airportId);
	        
	        ResultSet departureRs = DeparturePs.executeQuery();
	        
	        JSONArray departureFlights = new JSONArray();
	        while (departureRs.next()) {
	        	JSONObject finalObject = new JSONObject();
	        	finalObject.put("departureAirportId", departureRs.getString("departureAirportId"));
	        	finalObject.put("arrivalAirportId", departureRs.getString("arrivalAirportId"));
	        	finalObject.put("departureTime", departureRs.getString("departureTime"));
	        	finalObject.put("arrivalTime", departureRs.getString("arrivalTime"));
	        	finalObject.put("flightDate", departureRs.getString("flightDate"));
	        	finalObject.put("duration", departureRs.getString("duration"));
	        	departureFlights.put(finalObject);
	        }
	        out.print(departureFlights);
				%>
				
			let departureOrderedList = document.querySelector("#departures");
			
			for (let departure of departures) {
				let list = document.createElement("li");
				list.innerHTML = departure.departureAirportId + "'s  flight leaves at " + departure.departureTime + " and arrives here at " + departure.arrivalTime;
				departureOrderedList.appendChild(list);
			}
			console.log(departures);
	</script>	
</body>
</html>