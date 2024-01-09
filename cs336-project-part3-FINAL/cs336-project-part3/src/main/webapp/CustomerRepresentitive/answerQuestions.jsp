<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Questions Portal</title>
</head>
<body>
		<a href='WelcomeCustomerRepresentitive.jsp'><button type="button">Back</button></a>
	    <br>
    <%
    
    try {
        // Get the database connection
        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();

        // Create a SQL statement
        String query = "SELECT * FROM questions";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet result = ps.executeQuery();

        while (result.next()) {
            String questionID = String.valueOf(result.getInt("questionID"));
            String questionText = result.getString("questiontext");
            String answer = result.getString("answer");

            out.println("<p><strong>Question:</strong> " + questionText + "</p>");

            if (answer == null) {
                // Input text box for the user to answer the question
                out.println("<input type='text' id='answerInput_" + questionID + "' placeholder='Your Answer'>");

                // Button to submit the answer
                out.println("<button onclick='answerQuestion(" + questionID + ")'>Submit Answer</button>");
            } else {
                out.println("<p><strong>Answer:</strong> " + answer + "</p>");
            }

            out.println("<hr>");
        }

        // Close the connection
        con.close();

    } catch (Exception ex) {
        out.print(ex);
        out.print("Query failed");
    }
    %>

    <script>
        function answerQuestion(questionId) {
            // Get the answer from the input text box
            var answer = document.getElementById('answerInput_' + questionId).value;

            // Redirect to the answer page with the questionId and answer
            window.location.href = 'sendAnswer.jsp?questionID=' + questionId + '&answer=' + answer;
        }
    </script>
</body>
</html>
