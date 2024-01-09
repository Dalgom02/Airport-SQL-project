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
	    <a href='editCustomers.jsp'><button type="button">Back</button></a>
	    <br>
	    <%                 
	    try {
	        // Get the database connection
	        ApplicationDB db = new ApplicationDB();
	        Connection con = db.getConnection();
	
	        String username = request.getParameter("username");
	        // SQL query to get the password for a given username
	        String query = "SELECT Password FROM users WHERE Username = ?";
	
	        try (PreparedStatement ps = con.prepareStatement(query)) {
	            ps.setString(1, username);
	            
	            try (ResultSet result = ps.executeQuery()) {
	                // Check if there are results
	                if (result.next()) {
	                    String oldPassword = result.getString("Password");
	    %>
	                    <h1>Edit User</h1>
	                    <form action="updateUser.jsp" method="post" onsubmit="return validateForm()">
	                        <label for="oldUsername">Old Username:</label>
	                        <input type="text" id="oldUsername" name="oldUsername" value="<%= username %>" readonly>
	                        <br>
	                        <label for="oldPassword">Old Password:</label>
	                        <input type="text" id="oldPassword" name="oldPassword" value="<%= oldPassword %>" readonly>
	                        <br>
	                        <label for="newUsername">New Username:</label>
	                        <input type="text" id="newUsername" name="newUsername">
	                        <br>
	                        <label for="newPassword">New Password:</label>
	                        <input type="password" id="newPassword" name="newPassword">
	                        <br>
	                        <input type="submit" value="Update">
	                    </form>
	                    
	                    <script>
						    function validateForm() {
						        var newUsername = document.getElementById("newUsername").value;
						        var newPassword = document.getElementById("newPassword").value;
						
						        if (newUsername.trim() === "" && newPassword.trim() === "") {
						            alert("Please enter at least a new username or a new password.");
						            return false; // Prevent form submission
						        }
						
						        return true; // Allow form submission
						    }
						</script>
	    <%
	                } else {
	    %>
	                    <p>No results found for username <%= username %>.</p>
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
	<%
	} else { 
	%>
	    <a href="<%= request.getContextPath() %>/logout.jsp"><button type="button">Log Out</button></a>
	    <p>You do not have permission to view this page.</p>
	<%
	}
	} else {
	    response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
	%>
	<br>
	</body>
</html>
