<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.ApplicationDB"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Flight Search</title>
</head>
<body>
    <h1>Search for Flights</h1>
    <form action="processSearch.jsp" method="post">
        <label for="departureAirport">Departure Airport:</label>
        <select name="departureAirport" id="departureAirport">
            <% 
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT AirportID, AirportName FROM Airports");
                while(rs.next()) {
                    out.println("<option value='" + rs.getString("AirportID") + "'>" + rs.getString("AirportName") + "</option>");
                }
                rs.close();
                stmt.close();
            %>
        </select>
        <br>

        <label for="arrivalAirport">Arrival Airport:</label>
        <select name="arrivalAirport" id="arrivalAirport">
            <% 
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT AirportID, AirportName FROM Airports");
                while(rs.next()) {
                    out.println("<option value='" + rs.getString("AirportID") + "'>" + rs.getString("AirportName") + "</option>");
                }
                rs.close();
                stmt.close();
                con.close();
            %>
        </select>
        <br>

        <label for="tripType">Trip Type:</label>
        <select name="tripType" id="tripType">
            <option value="one-way">One-Way</option>
            <option value="round-trip">Round-Trip</option>
        </select>
        <br>

        <label for="departureDate">Departure Date:</label>
        <input type="date" name="departureDate" id="departureDate" required>
        <br>

        <input type="checkbox" name="flexibleDates" id="flexibleDates">
        <label for="flexibleDates">Flexible Dates (+/- 3 days)</label>
        <br>

        <div id="returnDateSection" style="display: none;">
            <label for="returnDate">Return Date:</label>
            <input type="date" name="returnDate" id="returnDate">
            <br>
        </div>

        <input type="submit" value="Search">

        <script>
            document.getElementById("tripType").addEventListener("change", function() {
                var tripType = this.value;
                var returnDateSection = document.getElementById("returnDateSection");
                if (tripType == "round-trip") {
                    returnDateSection.style.display = "block";
                } else {
                    returnDateSection.style.display = "none";
                }
            });
        </script>
    </form>
</body>
</html>