<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.sql.*, java.util.*, java.sql.Time, travel.db.ApplicationDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Flight to Book</title>
</head>
<body>
<h2>Search Flight to Book for a User</h2>

<form action="repBooking.jsp" method="get">
    Enter Flight Number: <input type="text" name="flightNum" required>
    <input type="submit" value="Next">
</form>

<br><br>
<form action="repDashboard.jsp" method="get">
	<input type="submit" value="Rep Dashboard" style="background-color: #fff9c4">
</form> 

</body>
</html>
