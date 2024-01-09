<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
</head>
<body>
    <h1>User Profile</h1>
    
    <h2>Past Reservations</h2>
    <% 
        String username = (String) session.getAttribute("username");
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        PreparedStatement pstmt;
        ResultSet rs;

        // Fetch past reservations
        pstmt = con.prepareStatement("SELECT * FROM Tickets JOIN Flights ON Tickets.FlightNumber = Flights.FlightNumber WHERE Tickets.Username = ? AND Flights.FlightDate < CURRENT_DATE");
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        while(rs.next()) {
            out.println("<p>Flight Number: " + rs.getString("FlightNumber") + ", Date: " + rs.getString("FlightDate") + ", Class: " + rs.getString("Class") + "</p>");
        }
    %>

    <h2>Upcoming Flights</h2>
    <% 
        // Fetch upcoming flights
        pstmt = con.prepareStatement("SELECT * FROM Tickets JOIN Flights ON Tickets.FlightNumber = Flights.FlightNumber WHERE Tickets.Username = ? AND Flights.FlightDate >= CURRENT_DATE");
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        while(rs.next()) {
            out.println("<p>Flight Number: " + rs.getString("FlightNumber") + ", Date: " + rs.getString("FlightDate") + ", Class: " + rs.getString("Class"));
            if (rs.getString("Class").equals("Business") || rs.getString("Class").equals("First")) {
                out.println(" <a href='cancelFlight.jsp?ticketId=" + rs.getInt("TicketID") + "'><button type='button'>Cancel</button></a>");
            }
            out.println("</p>");
        }
    %>

    <h2>Waitlisted Flights</h2>
    <% 
        // Fetch waitlisted flights
        pstmt = con.prepareStatement("SELECT * FROM Waitlist JOIN Flights ON Waitlist.FlightNumber = Flights.FlightNumber WHERE Waitlist.Username = ?");
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        while(rs.next()) {
            out.println("<p>Flight Number: " + rs.getString("FlightNumber") + ", Join Date: " + rs.getString("JoinTime") + "</p>");
        }

        // Close resources
        rs.close();
        pstmt.close();
        con.close();
    %>

    <a href='welcome.jsp'><button type='button'>Back to Home</button></a>
</body>
</html>
