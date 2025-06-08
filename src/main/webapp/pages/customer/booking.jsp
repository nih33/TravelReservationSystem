<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, java.util.*, travel.db.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking Confirmation</title>
</head>
<body>
<h2>Confirm Your Booking</h2>
<form action="ConfirmBookingServlet" method="post">
    <!-- Include selected flight info here -->
    <input type="hidden" name="flightId" value="<%= request.getParameter("flightId") %>">
    <!-- Passenger Details -->
    First Name: <input type="text" name="firstName"><br>
    Last Name: <input type="text" name="lastName"><br>
    ID Number: <input type="text" name="idNumber"><br>
    Class: 
    <select name="flightClass">
        <option value="economy">Economy</option>
        <option value="business">Business</option>
        <option value="first">First</option>
    </select><br>
    <input type="submit" value="Confirm Booking">
    
<!-- Back to Home Button -->
<form action="home.jsp">
    <button type="submit">Back to Home</button>
</form>
</body>
</html>

