<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Welcome Page</title>
</head>
<body>
    <%
        String username = (String) session.getAttribute("username");
        String status = (String) session.getAttribute("status");
        if (username != null) {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            PreparedStatement pstmt;
            ResultSet rs;

            // Check if user is on waitlist for any flights with available seats
            pstmt = con.prepareStatement("SELECT Waitlist.FlightNumber FROM Waitlist JOIN Flights ON Waitlist.FlightNumber = Flights.FlightNumber WHERE Waitlist.Username = ? AND Flights.SeatsAvailable > 0");
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            boolean seatAvailable = false;
            while(rs.next()) {
                seatAvailable = true;
                String flightNumber = rs.getString("FlightNumber");

                // Automatically move user from waitlist to confirmed tickets
                PreparedStatement moveUserStmt = con.prepareStatement("INSERT INTO Tickets (FlightNumber, Username, Class) VALUES (?, ?, 'Economy')", Statement.RETURN_GENERATED_KEYS); // Assuming default class as Economy
                moveUserStmt.setString(1, flightNumber);
                moveUserStmt.setString(2, username);
                moveUserStmt.executeUpdate();

                // Update seats available in Flights table
                PreparedStatement updateSeatsStmt = con.prepareStatement("UPDATE Flights SET SeatsAvailable = SeatsAvailable - 1 WHERE FlightNumber = ?");
                updateSeatsStmt.setString(1, flightNumber);
                updateSeatsStmt.executeUpdate();

                // Remove user from Waitlist
                PreparedStatement removeWaitlistStmt = con.prepareStatement("DELETE FROM Waitlist WHERE FlightNumber = ? AND Username = ?");
                removeWaitlistStmt.setString(1, flightNumber);
                removeWaitlistStmt.setString(2, username);
                removeWaitlistStmt.executeUpdate();
            }

            // Display welcome message
            out.println("<h1>Welcome " + (status.equals("old") ? "back, " : "new user, ") + username + "!</h1>");

            // Display alert if seat was available
            if (seatAvailable) {
                out.println("<p style='color: green;'>Alert: A seat has become available on a flight you were waitlisted for. Check your profile for details!</p>");
            }

            // Display buttons for different actions
            out.println("<p>");
            out.println("<a href='logout.jsp'><button type='button'>Log Out</button></a>");
            out.println("<a href='tripTypeSelection.jsp'><button type='button'>Search Flights</button></a>");
            out.println("<a href='sortSelection.jsp'><button type='button'>Sort Flights</button></a>");
            out.println("<a href='FilterSelection.jsp'><button type='button'>Filter Flights</button></a>");
            out.println("<a href='QuestionForum.jsp'><button type='button'>Question Forum</button></a>");
            out.println("<a href='userProfile.jsp'><button type='button'>Profile</button></a>");
            out.println("</p>");

            // Close resources
            rs.close();
            pstmt.close();
            con.close();
        } else {
            // Redirect to login page if no username is found in the session
            response.sendRedirect("login.jsp");
        }
    %>
</body>
</html>
