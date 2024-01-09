<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Customers List</title>
</head>

<body>
    <%
        Boolean isAdmin = (Boolean) session.getAttribute("admin");
        String user = (String) session.getAttribute("username");

        if (user != null) {
            if (isAdmin) { 
    %>
                <a href='reservationList.jsp'><button type="button">Back</button></a>
                <br>
                <table border='1'>
                    <tr>
                        <th>Flight Number</th>
                        <th>Username</th>
                    </tr>
                    <%
                    try {
                        // Get the database connection
                        ApplicationDB db = new ApplicationDB();    
                        Connection con = db.getConnection();

                        String sorted = request.getParameter("sortedBy");
                        String param = request.getParameter("input");
                        String query = "";

                        // Create a Prepared SQL statement allowing you to introduce the parameters of the query
                        if(sorted.equals("flightNumber")) {
                            query = "SELECT FlightNumber, Username FROM tickets WHERE FlightNumber = ?";
                        }
                        else {
                            query = "SELECT FlightNumber, Username FROM tickets WHERE Username = ?";
                        }

                        try (PreparedStatement ps = con.prepareStatement(query)) {
                            ps.setString(1, param);		
                            try (ResultSet result = ps.executeQuery()) {
                            	boolean resultsFound = false;
                                while (result.next()) {
                                	resultsFound = true;
                                    String flightNumber = result.getString("FlightNumber");
                                    String username = result.getString("Username");
                    %>
                                    <tr>
                                        <td><%= flightNumber %></td>
                                        <td><%= username %></td>
                                    </tr>
                    <%
                                }
                                if (!resultsFound) {
                    %>
                                    <tr>
                                        <td colspan="2">No results found.</td>
                                    </tr>
                    <%
                                }
                            }
                        }
                        // Close the connection
                        con.close();
                    } catch (Exception ex) {
                        out.print(ex);
                        out.print("Database query failed.");
                    }
                    %>
                </table>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/logout.jsp"><button type="button">Log Out</button></a>
                <p>You do not have permission to view this page.</p>
            <% }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    %>
    <br>
</body>
</html>
