<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" 	import="com.cs336.pkg.*,java.sql.*, java.util.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Customer Reservation</title>
</head>
<body>
<%
String flightNumber = request.getParameter("flights");
String classSelection = request.getParameter("classSelection");
String username = (String) request.getParameter("customer");

ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();


    // Check if user already has a reservation for this flight
    PreparedStatement checkReservationStmt = con.prepareStatement("SELECT * FROM Tickets WHERE FlightNumber = ? AND Username = ?");
    checkReservationStmt.setString(1, flightNumber);
    checkReservationStmt.setString(2, username);
    ResultSet reservationRs = checkReservationStmt.executeQuery();

    if (reservationRs.next()) {
        // User already has a reservation for this flight
        out.println("<p>Error: This customer already have a reservation for this flight.</p>");
        out.println("<a href='WelcomeCustomerRepresentitive.jsp'><button type='button'>Back</button></a>");
    } else {
        // Check if seats are available
        PreparedStatement pstmt = con.prepareStatement("SELECT SeatsAvailable FROM Flights WHERE FlightNumber = ?");
        pstmt.setString(1, flightNumber);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next() && rs.getInt("SeatsAvailable") > 0) {
            // Seats are available, process reservation
            int newSeatsAvailable = rs.getInt("SeatsAvailable") - 1;

            // Update seats available in Flights table
            PreparedStatement updateSeatsStmt = con.prepareStatement("UPDATE Flights SET SeatsAvailable = ? WHERE FlightNumber = ?");
            updateSeatsStmt.setInt(1, newSeatsAvailable);
            updateSeatsStmt.setString(2, flightNumber);
            updateSeatsStmt.executeUpdate();
            updateSeatsStmt.close();
            
            // Get ticket price
            PreparedStatement getTicketPrice = con.prepareStatement("SELECT Price FROM Flights WHERE FlightNumber = ?");
            getTicketPrice.setString(1, flightNumber);
            ResultSet resultSet = getTicketPrice.executeQuery();   
            double ticketPrice = 0;
            if (resultSet.next()) {
                ticketPrice = resultSet.getDouble("Price");
            }
            resultSet.close();
            getTicketPrice.close();

            // Add ticket to Tickets table
            PreparedStatement addTicketStmt = con.prepareStatement("INSERT INTO Tickets (FlightNumber, Username, Class, TotalFare) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            addTicketStmt.setString(1, flightNumber);
            addTicketStmt.setString(2, username);
            addTicketStmt.setString(3, classSelection);
            addTicketStmt.setDouble(4, ticketPrice);
            addTicketStmt.executeUpdate();

            // Retrieve generated ticket ID
            ResultSet generatedKeys = addTicketStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                long ticketId = generatedKeys.getLong(1);
                out.println("<p>Reservation successful. Customer's ticket ID is " + ticketId + ".</p>");
                out.println("<a href='WelcomeCustomerRepresentitive.jsp'><button type='button'>Back</button></a>");
            }
            generatedKeys.close();
            addTicketStmt.close();
        } else {
            // No seats available, add to waitlist
            PreparedStatement addWaitlistStmt = con.prepareStatement("INSERT INTO Waitlist (FlightNumber, Username) VALUES (?, ?)");
            addWaitlistStmt.setString(1, flightNumber);
            addWaitlistStmt.setString(2, username);
            addWaitlistStmt.executeUpdate();
            addWaitlistStmt.close();

            out.println("<p>Flight is full. Customer has been added to the waitlist.</p>");
            out.println("<a href='WelcomeCustomerRepresentitive.jsp'><button type='button'>Back</button></a>");
        }

        rs.close();
        pstmt.close();
    }

    reservationRs.close();
    checkReservationStmt.close();
    con.close();
%>
