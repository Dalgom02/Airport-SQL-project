<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
                <a href='welcomeAdmin.jsp'><button type="button">Back</button></a>
                <% 
                
                try {
                    // Get the database connection
                    ApplicationDB db = new ApplicationDB();    
                    Connection con = db.getConnection();
            
                    // Create a Prepared SQL statement allowing you to introduce the parameters of the query
                    String customerQuery = "SELECT username FROM users WHERE admin = FALSE AND customer_rep = FALSE";
                    PreparedStatement customerPS = con.prepareStatement(customerQuery);
                    ResultSet customerResult = customerPS.executeQuery();
                    
                    String repQuery = "SELECT username FROM users WHERE admin = FALSE AND customer_rep = TRUE";
                    PreparedStatement repPS = con.prepareStatement(repQuery);
                    ResultSet repResult = repPS.executeQuery();
                    
                    out.println("<table border='1'>");
                    out.println("<tr><th>Customers</th><th><a href='addCustomer.jsp?rep=false'><button type='button' style='background-color: green; color: white;'>Add New Customer</button></a></th></tr>");

                    while (customerResult.next()) {
                        String customerUsername = customerResult.getString("username");
                        out.println("<tr>");
                        out.println("<td>" + customerUsername + "</td>");
                        out.println("<td><a href='editUser.jsp?username=" + 
                        	customerUsername + 
                        	"'><button type='button' style='background-color: grey; color: white;'>Edit</button></a> | <a href='deleteUser.jsp?username=" + 
                        	customerUsername + 
                        	"'><button type='button' style='background-color: red; color: white;'>Delete</button></a></td>");
                        out.println("</tr>");
                    }
                    
                    out.println("<tr><th>Customer Representatives</th><th><a href='addCustomer.jsp?rep=true'><button type='button' style='background-color: green; color: white;'>Add New Customer Rep</button></a></th></tr>");
                    while (repResult.next()) {
                        String repUsername = repResult.getString("username");
                        out.println("<tr>");
                        out.println("<td>" + repUsername + "</td>");
                        out.println("<td><a href='editUser.jsp?username=" + 
                        	repUsername + 
                        	"'><button type='button' style='background-color: grey; color: white;'>Edit</button></a> | <a href='deleteUser.jsp?username=" + 
                        	repUsername + 
                        	"'><button type='button' style='background-color: red; color: white;'>Delete</button></a></td>");
                        out.println("</tr>");
                    }
            
                    out.println("</table>");
                    
                    // Close the connection
                    con.close();
                    
                } catch (Exception ex) {
                    out.print(ex);
                    out.print("Database query failed.");
                }
                %>
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
