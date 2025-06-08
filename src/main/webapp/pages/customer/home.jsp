<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
</head>

<body>
	<% String user = (String) session.getAttribute("user"); %>
	Welcome back, <%= user %>!
	
	<h2 style="margin-bottom: 5px;">Sign Out</h2> 
	
	<!-- Sign Out Form -->
	<form method="post" action="/TravelReservationSystem/pages/shared/logout.jsp">
		<input type="submit" value="Sign Out"/>
	</form>
	
	<!-- Search Flights Button -->
    <form method="get" action="/TravelReservationSystem/pages/customer/searchFlights.jsp" style="margin-top: 10px;">
        <input type="submit" value="Search for Flights" />
    </form>
    
    <!-- Q&A Button -->
	<form method="get" action="/TravelReservationSystem/pages/shared/qa.jsp">
	    <input type="submit" value="Flight Q & A" />
	</form>

	<!-- View Reservations Button -->
	<form method="get" action="/TravelReservationSystem/pages/customer/myReservations.jsp">
	    <input type="submit" value="View My Reservations" />
	</form>
</body>
</html>
