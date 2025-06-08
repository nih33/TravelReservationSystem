<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservations</title>
</head>
<body>

	<h3> Reservations </h3>
	<form method="post">
		<label for="filter">Reservations by </label>
		<select name="category" required onchange="this.form.submit()">
			<option>-- Select --</option>
			<option value="01">Flight Number</option>
			<option value="02">Customer Name</option>
		</select>
		
		<input type="hidden" name="filterBy" value="filter"> 
	</form>
<%
	String filterBy = request.getParameter("filterBy"); // once form is submitted, gets "category"
	if("filter".equals(filterBy)){
		String category = request.getParameter("category");
		if("01".equals(category)){
%>
			<form method="post">
				<label for="flightNum">Flight Number: </label>
				<input type="text" name="flightNum" id="flightNum" required placeholder="Enter flight number">
				
				<input type="hidden" name="selectedFlight" value="filter">
				<input type="submit" value="View Report">
			</form>
<%
		
		}else if("02".equals(category)){
			
%>
			<form method="post">
				<label for="customerName">Customer Name: </label>
				<input type="text" name="customerName" id="customerName" required placeholder="Enter customer name">
				
				<input type="hidden" name="selectedCustomer" value="filter">
				<input type="submit" value="View Report">
			</form>
<%
			
		}
	}
	
	String selectedCustomer = request.getParameter("selectedCustomer");
	String selectedFlight = request.getParameter("selectedFlight");
	if("filter".equals(selectedCustomer)){
		String customerName = request.getParameter("customerName");
		if(customerName != null && !customerName.isEmpty()){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				
				PreparedStatement ps = conn.prepareStatement(
						"select t.*, tf.flight_id " +
						"from tickets t " + 
						"join ticket_flights tf on t.ticket_id = tf.ticket_id " +
						"where t.user_id in " +
						"(select user_id from customers where concat(fname, ' ', lname) LIKE ?)"
						);
				ps.setString(1, "%" + customerName + "%");
				
				ResultSet rs = ps.executeQuery();
				
				out.println("<h3>Tickets for Customer: " + customerName + "</h3>");
				out.println("<table border='1'>");
				out.println("<tr><th> Ticket ID </th><th> User ID </th><th> Class </th><th> Total Fare </th><th> Booking Fee </th><th> Purchase DateTime </th><th> Is Cancelled? </th><th> Flight ID </th></tr>");

				boolean hasResults = false;
				
				while(rs.next()){
					hasResults = true;
					out.println("</tr>");
					out.println("<td>" + rs.getString("ticket_id") + "</td>");
					out.println("<td>" + rs.getInt("user_id") + "</td>");
					out.println("<td>" + rs.getString("class") + "</td>");
					out.println("<td>" + rs.getInt("total_fare") + "</td>");
					out.println("<td>" + rs.getInt("booking_fee") + "</td>");
					out.println("<td>" + rs.getTimestamp("purchase_datetime") + "</td>");
					out.println("<td>" + rs.getBoolean("is_cancelled") + "</td>");
					out.println("<td>" + rs.getInt("flight_id") + "</td>");
					out.println("</tr>");
				}
				
				if(!hasResults){
					out.println("<p style='color:orange;'>No results found.</p>");
				}
				
				out.println("</table>");
				conn.close();
		
			}catch(Exception e){
				out.println("<p style='color:red;'>Error: " + e + "</p>");
			}
		}
	}else if("filter".equals(selectedFlight)){
		String flightNum = request.getParameter("flightNum");
		if(selectedFlight != null && !selectedFlight.isEmpty()){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				
				PreparedStatement ps = conn.prepareStatement(
						"SELECT t.*, tf.flight_id " +
						"FROM tickets t " +
						"JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
						"JOIN flights f ON tf.flight_id = f.flight_id " +
						"WHERE f.flight_number = ?"
						);
				
				ps.setString(1, flightNum);
				
				ResultSet rs = ps.executeQuery();
				
				out.println("<h3>Tickets for Flight: " + flightNum + "</h3>");
				out.println("<table border='1'>");
				out.println("<tr><th> Ticket ID </th><th> User ID </th><th> Class </th><th> Total Fare </th><th> Booking Fee </th><th> Purchase DateTime </th><th> Is Cancelled? </th><th> Flight ID</th></tr>");

				boolean hasResults = false;
				
				while(rs.next()){
					hasResults = true;
					out.println("</tr>");
					out.println("<td>" + rs.getString("ticket_id") + "</td>");
					out.println("<td>" + rs.getInt("user_id") + "</td>");
					out.println("<td>" + rs.getString("class") + "</td>");
					out.println("<td>" + rs.getInt("total_fare") + "</td>");
					out.println("<td>" + rs.getInt("booking_fee") + "</td>");
					out.println("<td>" + rs.getTimestamp("purchase_datetime") + "</td>");
					out.println("<td>" + rs.getBoolean("is_cancelled") + "</td>");
					out.println("<td>" + rs.getInt("flight_id") + "</td>");
					out.println("</tr>");
				}
				
				if(!hasResults){
					out.println("<p style='color:orange;'>No results found.</p>");
				}
				
				out.println("</table>");
				conn.close();
			}catch(Exception e){
				out.println("<p> Error: " + e + "</p>");
			}
		}
	}
	
%>

<br><br>
<form action="adminDashboard.jsp" method="get">
		<input type="submit" value="Admin Dashboard" style="background-color: #fff9c4;">
</form> 

</body>
</html>