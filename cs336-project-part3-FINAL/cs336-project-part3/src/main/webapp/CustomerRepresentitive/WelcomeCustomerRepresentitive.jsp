<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative</title>
</head>
<body>
	<%
	String username = (String) session.getAttribute("username");
	Boolean isCustomerRepresentative = (Boolean) session.getAttribute("CustomerRepresentative");

	if (username != null) {
		if (isCustomerRepresentative != null) {
	%>
	<h1>Customer Representative</h1>
	<%
	}
	%>
	<a href="<%=request.getContextPath()%>/logout.jsp"><button
			type="button">Log Out</button></a>
	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
	
	out.println("<a href='createReservation.jsp'><button type='button'>Create Reservation</button></a>");
	out.println("<a href='editReservation.jsp'><button type='button'>Edit Reservation</button></a>");
	out.println("<a href='ViewFlightWaitlist.jsp'><button type='button'>View a particular flights waitlist</button></a>");
	out.println("<a href='ViewFlightsFromSpecificAirport.jsp'><button type='button'>View flights from specific airport</button></a>");
	out.println("<a href='CRUDAircraftsAirportsFlights.jsp'><button type='button'>Manage Air Related Items</button></a>");
	out.println("<a href='answerQuestions.jsp'><button type='button'>Answer Questions</button></a>");
	%>
</body>
</html>