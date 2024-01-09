<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Update User</title>
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
            
                    String oldUsername = request.getParameter("oldUsername");
                    String oldPassword = request.getParameter("oldPassword");
                    String newUser = request.getParameter("newUsername");
                    Boolean userEmpty = true;
                    if(newUser.trim() != "")
                    	userEmpty = false;
                    String newPass = request.getParameter("newPassword");
                    Boolean passEmpty = true;
                    if(newPass.trim() != "")
                    	passEmpty = false;
                    // Create a Prepared SQL statement allowing you to introduce the parameters of the query
                    if(!userEmpty && !passEmpty) {
                		String updateQuery = "UPDATE users SET Username = ?, Password = ? WHERE Username = ? AND Password = ?";
                    	try (PreparedStatement userPs = con.prepareStatement(updateQuery)) {
                    		userPs.setString(1, newUser);
                    		userPs.setString(2, newPass);
                    		userPs.setString(3, oldUsername);
                    		userPs.setString(4, oldPassword);
                            int userRowsAffected = userPs.executeUpdate();
                            
                            // Check if the user was deleted
                            if (userRowsAffected > 0) {
                                out.println("User updated successfully.");
                            } else {
                                out.println("User not found.");
                            }
                        }
                    }
                    // Close the connection
                    con.close();
                    
                } catch (Exception ex) {
                    out.print(ex);
                    out.print("Updating failed.");
                }
                %>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/logout.jsp"><button type="button">Log Out</button></a>
                <p>You do not have permission to view this page.</p>
            <% }
			// response.sendRedirect("editCustomers.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
        %>
        <br>
    </body>
</html>
