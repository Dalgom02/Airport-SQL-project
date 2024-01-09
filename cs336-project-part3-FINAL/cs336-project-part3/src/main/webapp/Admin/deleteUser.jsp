<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Delete User</title>
    </head>
    
    <body>
        <%
        Boolean isAdmin = (Boolean) session.getAttribute("admin");
        String user = (String) session.getAttribute("username");

        if (user != null) {
            if (isAdmin) { 
        %>
                <% 
                try {
                    // Get the database connection
                    ApplicationDB db = new ApplicationDB();    
                    Connection con = db.getConnection();
            
                    String deleteUser = request.getParameter("username");
                    
                    // Create a Prepared SQL statement allowing you to introduce the parameters of the query
                    String reservationQuery = "SELECT FlightNumber FROM Tickets WHERE Username = ?";
                    try (PreparedStatement reservationPs = con.prepareStatement(reservationQuery)) {
                        reservationPs.setString(1, deleteUser);
                        ResultSet reservationResult = reservationPs.executeQuery();
                        
                        // Retrieve flight numbers from reservations
                        List<String> flightNumbers = new ArrayList<>();
                        while (reservationResult.next()) {
                            flightNumbers.add(reservationResult.getString("FlightNumber"));
                        }
                        
                        // Delete the reservations
                        String deleteReservationQuery = "DELETE FROM Tickets WHERE Username = ?";
                        try (PreparedStatement deleteReservationPs = con.prepareStatement(deleteReservationQuery)) {
                            deleteReservationPs.setString(1, deleteUser);
                            int reservationRowsAffected = deleteReservationPs.executeUpdate();
                            
                            // Check if reservations were deleted
                            if (reservationRowsAffected > 0) { 
                            	
                                // Update available seats for each flight
                                for (String flightNumber : flightNumbers) {
                                    String updateSeatsQuery = "UPDATE Flights SET SeatsAvailable = SeatsAvailable + 1 WHERE FlightNumber = ?";
                                    try (PreparedStatement updateSeatsPs = con.prepareStatement(updateSeatsQuery)) {
                                        updateSeatsPs.setString(1, flightNumber);
                                        updateSeatsPs.executeUpdate();
                                    }
                                }
                            } else {
                                out.println("No reservations found for the user.");
                            }
                        }
                    }
                    
                    // Now delete the user
                    String userQuery = "DELETE FROM users WHERE username = ?";
                    try (PreparedStatement userPs = con.prepareStatement(userQuery)) {
                        userPs.setString(1, deleteUser);
                        int userRowsAffected = userPs.executeUpdate();
                        
                        // Check if the user was deleted
                        if (userRowsAffected > 0) {
                            out.println("User deleted successfully.");
                        } else {
                            out.println("User not found or deletion failed.");
                        }
                    }
                    
                    // Close the connection
                    con.close();
                    
                } catch (Exception ex) {
                    out.print(ex);
                    out.print("Deletion failed.");
                }
                %>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/logout.jsp"><button type="button">Log Out</button></a>
                <p>You do not have permission to view this page.</p>
            <% }
			response.sendRedirect("editCustomers.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
        %>
        <br>
    </body>
</html>
