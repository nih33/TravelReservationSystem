<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Rep Dashboard</title>
</head>
<body>

	<h2>Customer Representative Dashboard</h2>
	
	<form action="repBookSearch.jsp" method="get">
	    <input type="submit" value="Book Flight for a User" style="background-color: #F4C2C2;">
	</form>
	
	<form action="repFlightManager.jsp" method="get">
	    <input type="submit" value="Manage Flights" style="background-color: #F4C2C2;">
	</form>
	
	<form action="repWaitlist.jsp" method="get">
	    <input type="submit" value="View Flight Waitlists" style="background-color: #F4C2C2;">
	</form>
	
	<form action="/TravelReservationSystem/pages/shared/qa.jsp" method="get">
	    <input type="submit" value="Answer Customer Questions" style="background-color: #F4C2C2;">
	</form>
	
	<form action="ticketEdit.jsp" method="get">
	    <input type="submit" value="Ticket Edit" style="background-color: #F4C2C2;">
	</form>
	
	<form action="repAirportFlights.jsp" method="get">
	    <input type="submit" value="Lookup Flights by Airport" style="background-color: #F4C2C2;">
	</form>
	
	<form action="/TravelReservationSystem/pages/shared/logout.jsp" method="get">
		<input type="submit" value="Logout" style="background-color: #fff9c4;">
	</form> 
	
</body>
</html>