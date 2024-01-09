<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.cs336.pkg.*,java.sql.*, java.util.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Reservation</title>
</head>
<body>

    <%
        String username = (String) request.getParameter("customer");
    %> 
    <h2><% out.print(username); %>'s Flights</h2>
    <%
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        PreparedStatement checkReservationStmt = con.prepareStatement("SELECT FlightNumber, Class, TicketID FROM Tickets WHERE Username = ?");
        checkReservationStmt.setString(1, username);
        ResultSet reservationRs = checkReservationStmt.executeQuery();
    %>
       <table border="1">
	    <tr>
	        <th>Flight Number</th>
	        <th>Class</th>
	    </tr>
	    <%
	        while (reservationRs.next()) {
	            String flightNumber = reservationRs.getString("FlightNumber");
	            String ticketClass = reservationRs.getString("Class");
	            String ticketID = reservationRs.getString("TicketID");
	    %>
	    <form action="SubmitReservationChangesHandler.jsp" method="POST">
	        <tr>
	            <td><%= flightNumber %></td>
	            <td>
	                <input type="text" name="ticketClass" value="<%= ticketClass %>">
	            </td>
	            <td>
	                <input type="hidden" name="ticketid" value="<%= ticketID %>">
	                <button type='submit' style='background-color: green; color: white;'>Submit Changes</button>
	            </td>
	        </tr>
	    </form>
	    <%
	        }
	        reservationRs.close();
	        checkReservationStmt.close();
	        con.close();
	    %>
	</table>

    <br>
    <a href='editReservation.jsp'><button type="button">Back</button></a>
    
</body>
</html>
