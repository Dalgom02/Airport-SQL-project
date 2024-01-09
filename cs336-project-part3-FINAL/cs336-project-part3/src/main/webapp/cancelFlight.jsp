<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    int ticketId = Integer.parseInt(request.getParameter("ticketId"));
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    try {
        // First, get the FlightNumber for the ticket being cancelled
        PreparedStatement pstmtGetFlight = con.prepareStatement("SELECT FlightNumber FROM Tickets WHERE TicketID = ?");
        pstmtGetFlight.setInt(1, ticketId);
        ResultSet rs = pstmtGetFlight.executeQuery();

        String flightNumber = null;
        if (rs.next()) {
            flightNumber = rs.getString("FlightNumber");
        }
        rs.close();
        pstmtGetFlight.close();

        // Cancel the flight reservation
        PreparedStatement pstmtCancelTicket = con.prepareStatement("DELETE FROM Tickets WHERE TicketID = ?");
        pstmtCancelTicket.setInt(1, ticketId);
        int rowsAffected = pstmtCancelTicket.executeUpdate();
        pstmtCancelTicket.close();

        // Increase SeatsAvailable in the Flights table
        if (flightNumber != null) {
            PreparedStatement pstmtUpdateSeats = con.prepareStatement("UPDATE Flights SET SeatsAvailable = SeatsAvailable + 1 WHERE FlightNumber = ?");
            pstmtUpdateSeats.setString(1, flightNumber);
            pstmtUpdateSeats.executeUpdate();
            pstmtUpdateSeats.close();
        }

        // Check if the cancellation was successful
        if(rowsAffected > 0) {
            out.println("<p>Cancellation successful.</p>");
        } else {
            out.println("<p>Error: Unable to cancel the reservation.</p>");
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        con.close();
    }
%>

<a href='userProfile.jsp'><button type='button'>Back to Profile</button></a>
