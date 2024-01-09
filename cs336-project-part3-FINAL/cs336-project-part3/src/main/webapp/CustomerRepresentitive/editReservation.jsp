<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.cs336.pkg.*,java.sql.*, java.util.*, org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Reservation</title>
</head>
<body>

    <div>
        <form action="EditReservationHandler.jsp" method="post">
            <strong>Edit Reservation</strong>
            <br><br>
            <label for="customer">Select Customer:</label> 
            <select name="customer" id="users"> </select>
            <button type="submit">Edit Reservation</button>
        </form>
    </div>

    <script>
        let users = 
            <%
	            ApplicationDB db = new ApplicationDB();
	            Connection con = db.getConnection();
                Statement Userstmt = con.createStatement();
                JSONArray users = new JSONArray();
                ResultSet Usersrs = Userstmt.executeQuery("SELECT * FROM users WHERE Admin = false and customer_rep = false");
                while (Usersrs.next()) {
                    JSONObject finalObject = new JSONObject();
                    finalObject.put("username", Usersrs.getString("username"));
                    users.put(finalObject);
                }
                out.print(users);
                Usersrs.close(); // Close the result set for users
                Userstmt.close();
                con.close(); // Close the connection
            %>
        ;
        
        // User
        let Userdropdown = document.querySelector("#users");
        
        for (let user of users) {
            let option = document.createElement("option");
            option.text = user.username;
            option.value = user.username;
            Userdropdown.appendChild(option);
        }
    </script>
    <br>
    <a href='WelcomeCustomerRepresentitive.jsp'><button type="button">Back</button></a>
</body>
</html>
