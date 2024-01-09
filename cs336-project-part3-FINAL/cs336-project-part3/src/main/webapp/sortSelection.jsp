<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sort Flights</title>
</head>
<body>
    <h1>Sort Flights</h1>
    <form action="sortFlights.jsp" method="post">
        <label for="sortAttribute">Sort by:</label>
        <select name="sortAttribute" id="sortAttribute">
            <option value="price">Price</option>
            <option value="takeOffTime">Take-Off Time</option>
            <option value="landingTime">Landing Time</option>
            <option value="duration">Duration</option>
        </select>
        <br><br>

        <label for="sortOrder">Order:</label>
        <select name="sortOrder" id="sortOrder">
            <option value="ascending">Ascending</option>
            <option value="descending">Descending</option>
        </select>
        <br><br>

        <input type="submit" value="Sort">
    </form>
</body>
</html>
