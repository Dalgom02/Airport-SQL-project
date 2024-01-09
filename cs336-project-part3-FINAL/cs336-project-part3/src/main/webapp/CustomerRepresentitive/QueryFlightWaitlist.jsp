<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<strong id="title">Waitlist</strong>
	<ol id="waitlist"></div>
	
	<script>
		let waitlist = <%
		  // Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        Connection con = db.getConnection();
	        String query = "SELECT * FROM waitlist WHERE FlightNumber = ?";
	        
	        
	        String flightNumber = request.getParameter("flightNumber");
	        PreparedStatement ps = con.prepareStatement(query);
	        ps.setString(1, flightNumber);
	        
	        ResultSet rs = ps.executeQuery();
	        
	        JSONArray waitlist = new JSONArray();
	        while (rs.next()) {
	        	JSONObject finalObject = new JSONObject();
	        	finalObject.put("username", rs.getString("username"));
	        	finalObject.put("jointime", rs.getString("jointime"));
	        	waitlist.put(finalObject);
	        }
	        out.print(waitlist);
		%>;
		
		let orderedList = document.querySelector("#waitlist");
		
		for (let waitee of waitlist) {
			let list = document.createElement("li");
			list.innerHTML = waitee.username + " joined at " + waitee.jointime;
			orderedList.appendChild(list);
		}
		
		console.log(waitlist);
	</script>	
</body>
</html>