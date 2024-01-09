<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Answer Question</title>
</head>
<body>
    <%
    String questionID = request.getParameter("questionID");
    String answer = request.getParameter("answer");

    try {
        // Get the database connection
        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();

        // Insert the answer into the database
        String insertQuery = "UPDATE questions SET answer=? WHERE questionID=?";
        PreparedStatement ps = con.prepareStatement(insertQuery);
        ps.setString(1, answer);
        ps.setInt(2, Integer.parseInt(questionID));
        ps.executeUpdate();

        // Close the connection
        con.close();

        // Redirect back to the question list or a confirmation page
        response.sendRedirect("answerQuestions.jsp");

    } catch (Exception ex) {
        out.print(ex);
        out.print("Answer submission failed");
    }
    %>
</body>
</html>
