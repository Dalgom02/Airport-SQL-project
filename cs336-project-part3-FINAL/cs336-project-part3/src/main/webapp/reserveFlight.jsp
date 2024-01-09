<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<!DOCTYPE html>
<html>
<head>
    <title>Reserve Flight</title>
</head>
<body>
    <h1>Reserve Your Flight</h1>

    <% 
        // Assume flight details are passed via query parameters or session attributes
        String flightNumber = request.getParameter("flightNumber");
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Flights WHERE FlightNumber = ?");
        pstmt.setString(1, flightNumber);
        ResultSet rs = pstmt.executeQuery();

        if(rs.next()) {
            // Display flight details
            out.println("<p><strong>Flight Number:</strong> " + rs.getString("FlightNumber") + "</p>");
            out.println("<p><strong>Departure:</strong> " + rs.getString("DepartureAirportID") + "</p>");
            out.println("<p><strong>Arrival:</strong> " + rs.getString("ArrivalAirportID") + "</p>");
            out.println("<p><strong>Date:</strong> " + rs.getString("FlightDate") + "</p>");
            out.println("<p><strong>Price:</strong> $" + rs.getString("Price") + "</p>");
            // ... include other details as needed
        }

        pstmt.close();
        rs.close();
        con.close();
    %>

    <!-- Reservation form -->
    <form action="processReservation.jsp" method="post">
        <input type="hidden" name="flightNumber" value="<%=flightNumber%>">
        
        <label for="classSelection">Choose Class:</label>
        <select name="classSelection" id="classSelection">
            <option value="Economy">Economy</option>
            <option value="Business">Business</option>
            <option value="First">First</option>
        </select><br><br>

        <input type="submit" value="Reserve">
    </form>

</body>
</html>
