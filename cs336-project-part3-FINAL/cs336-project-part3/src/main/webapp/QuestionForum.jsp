<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<!DOCTYPE html>
<html>
<head>
    <title>Question Forum</title>
</head>
<body>
    <h1>Question Forum</h1>

    <!-- Search Form -->
    <form action="searchResults.jsp" method="get">
        <input type="text" name="searchQuery" placeholder="Search questions..." required>
        <input type="submit" value="Search">
    </form>

    <!-- Buttons for Asking Questions -->
    <p>
        <a href='askQuestion.jsp'><button type='button'>Ask a Question</button></a>
    </p>

    <% 
        // Database connection to fetch questions
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM Questions ORDER BY Timestamp DESC");

        // Display all questions
        while(rs.next()) {
            out.println("<p><strong>Question:</strong> " + rs.getString("QuestionText") + "<br>");
            if(rs.getString("Answer") != null)
            	out.println("<p><strong>Answer:</strong> " + rs.getString("Answer") + "<br>");
            out.println("<strong>Asked by:</strong> " + rs.getString("Username") + "<br>");
            out.println("<strong>Date:</strong> " + rs.getTimestamp("Timestamp") + "</p>");
        }

        // Close resources
        rs.close();
        stmt.close();
        con.close();
    %>

    <!-- Back to Welcome Page Button -->
    <p>
        <a href="welcome.jsp"><button type="button">Back to Welcome Page</button></a>
    </p>

</body>
</html>
