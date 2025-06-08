<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
 <%@ page import="java.sql.*, travel.db.ApplicationDB" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Flights</title>
</head>
<body>
<h2>Search Flights</h2>
<form action="/TravelReservationSystem/pages/customer/flightResults.jsp" method="get">
    From Airport: <input type="text" name="from" required><br><br>
    To Airport: <input type="text" name="to" required><br><br>
    Departure Date: <input type="date" name="departureDate"><br><br>
    Return Date: <input type="date" name="returnDate"><br><br>
    Trip Type: 
    <input type="radio" name="tripType" value="oneway" checked> One-Way
    <input type="radio" name="tripType" value="roundtrip"> Round-Trip<br><br>
    Flexible Dates: <input type="checkbox" name="flexible" value="yes"><br><br>
    <input type="submit" value="Search Flights">
</form>
<form action="/TravelReservationSystem/pages/customer/home.jsp" method="get" style="display:inline;">
    <input type="submit" value="Home">
</form>
</body>
</html>