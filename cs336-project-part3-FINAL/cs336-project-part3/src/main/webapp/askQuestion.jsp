<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<!DOCTYPE html>
<html>
<head>
    <title>Ask a Question</title>
</head>
<body>
    <h1>Ask a Question</h1>

    <form action="submitQuestion.jsp" method="post">
        <label for="questionText">Your Question:</label><br>
        <textarea name="questionText" id="questionText" rows="4" cols="50" required></textarea><br>
        <input type="submit" value="Submit">
    </form>

</body>
</html>
