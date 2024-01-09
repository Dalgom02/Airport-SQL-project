<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
</head>
<body>
    <h1>Search Results</h1>

    <% 
        String searchQuery = request.getParameter("searchQuery");
        if(searchQuery != null && !searchQuery.trim().isEmpty()) {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM Questions WHERE QuestionText LIKE ?");
            pstmt.setString(1, "%" + searchQuery + "%");
            ResultSet rs = pstmt.executeQuery();

            boolean hasResults = false;
            while(rs.next()) {
                hasResults = true;
                out.println("<p><strong>Question:</strong> " + rs.getString("QuestionText") + "<br>");
                out.println("<strong>Asked by:</strong> " + rs.getString("Username") + "<br>");
                out.println("<strong>Date:</strong> " + rs.getTimestamp("Timestamp") + "</p>");
                // If you later add answers, include them here
            }

            if(!hasResults) {
                out.println("<p>No results found for '" + searchQuery + "'</p>");
            }

            rs.close();
            pstmt.close();
            con.close();
        } else {
            out.println("<p>Please enter a search term.</p>");
        }
    %>

    <p><a href="QuestionForum.jsp">Back to Question Forum</a></p>
</body>
</html>
