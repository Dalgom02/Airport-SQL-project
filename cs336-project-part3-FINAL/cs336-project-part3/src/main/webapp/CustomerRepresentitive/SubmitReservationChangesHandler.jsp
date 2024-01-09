<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.cs336.pkg.*,java.sql.*, java.util.*, org.json.*"%>
<%
    String ticketId = (String) request.getParameter("ticketid");
    String selectedClass = (String) request.getParameter("ticketClass");
	//out.println(ticketId);
	//out.println(selectedClass);

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    PreparedStatement updateClassStmt = null;

    try {
        // Use the TicketID to update the Class in the Tickets table
        updateClassStmt = con.prepareStatement("UPDATE Tickets SET Class = ? WHERE TicketID = ?");
        updateClassStmt.setString(1, selectedClass);
        updateClassStmt.setString(2, ticketId);
        updateClassStmt.executeUpdate();
    } catch (SQLException e) {
        // Handle any SQL exceptions
        e.printStackTrace();
    } finally {
        try {
            if (updateClassStmt != null) {
                updateClassStmt.close();
            }
            con.close();
        } catch (SQLException e) {
            // Handle any SQL exceptions during closing resources
            e.printStackTrace();
        }
    }

    // Redirect back to the page displaying flights after the update
    response.sendRedirect("editReservation.jsp");
%>
