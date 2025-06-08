<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Admin Dashboard</title>
</head>
<body>

<h2>Admin Dashboard</h2>

<form action="adminUserManagement.jsp" method="get">
	<input type="submit" value="Add/Edit/Delete Users" style="background-color: #d0e7ff">
</form>

<form action="adminSalesReport.jsp" method="get">
	<input type="submit" value="Sales Report (By Month)" style="background-color: #d0e7ff;">
</form>

<form action="adminReservations.jsp" method="get">
	<input type="submit" value="View Reservations" style="background-color: #d0e7ff;">
</form>

<form action="adminRevenueSummary.jsp" method="get">
	<input type="submit" value="Revenue Summary" style="background-color: #d0e7ff;">
</form>

<form action="adminTopCustomer.jsp" method="get">
	<input type="submit" value="Top-Spending Customer" style="background-color: #d0e7ff;">
</form>

<form action="adminActiveFlights.jsp" method="get">
	<input type="submit" value="Most Active Flights" style="background-color: #d0e7ff;"> 
</form> <br>

<form action="logout.jsp" method="get">
	<input type="submit" value="Logout" style="background-color: #fff9c4;">
</form> 
	
</body>
</html>