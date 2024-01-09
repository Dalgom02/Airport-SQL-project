<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Trip Type</title>
</head>
<body>
    <form action="searchFlights.jsp" method="post">
    <label for="tripType">Trip Type:</label>
    <select name="tripType" id="tripType">
        <option value="one-way">One-Way</option>
        <option value="round-trip">Round-Trip</option>
    </select>
    <input type="submit" value="Next">
	</form>
</body>
</html>
