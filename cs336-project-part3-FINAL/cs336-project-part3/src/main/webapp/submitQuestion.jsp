<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<%
    String questionText = request.getParameter("questionText");
    String username = (String) request.getSession().getAttribute("username"); // Using request.getSession() directly

    if (questionText != null && !questionText.trim().isEmpty() && username != null) {
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO Questions (QuestionText, Username) VALUES (?, ?)");
            pstmt.setString(1, questionText);
            pstmt.setString(2, username);
            pstmt.executeUpdate();

            pstmt.close();
            con.close();

            response.sendRedirect("QuestionForum.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error submitting your question. Please try again.</p>");
        }
    } else {
        response.sendRedirect("askQuestion.jsp");
    }
%>
