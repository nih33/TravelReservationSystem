<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flights by Airport</title>
</head>
<body>

	<h3>Flight Lookup by Airport </h3>
	<form method="post">
		<label for="airportCode">Enter Airport Code:</label>
		<input type="text" name="airportCode" maxlength="3" required>
		<input type="submit" value="View Flights">
		<input type="hidden" name="selected" value="airport">
	</form>
	
	<%
	
	String selected = request.getParameter("selected");
	if("airport".equals(selected)){
		String num = request.getParameter("airportCode");
		if(num != null && !num.isEmpty()){
			try{
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				
				PreparedStatement ps = conn.prepareStatement(
						"SELECT * FROM flights WHERE dep_airport = ? OR arr_airport = ?"
					);
				ps.setString(1, num);
				ps.setString(2, num);
					
				ResultSet rs = ps.executeQuery();
					
				out.println("<h3>Flights Related to Airport: " + num + "</h3>");
				out.println("<table border='1'>");
				out.println("<tr><th>Flight ID</th><th>Flight Number</th><th>Airline ID</th><th>Aircraft ID</th><th>Departure Airport</th><th>Arrival Airport</th><th>Departure Time</th><th>Arrival Time</th><th>Days of Week</th><th>International</th><th>Price ($)</th><th># Stops</th></tr>");
					
				while(rs.next()){
					out.println("<tr>");
					out.println("<td>" + rs.getInt("flight_id") + "</td>");
					out.println("<td>" + rs.getString("flight_number") + "</td>");
					out.println("<td>" + rs.getString("airline_id") + "</td>");
					out.println("<td>" + rs.getString("aircraft_id") + "</td>");
					out.println("<td>" + rs.getString("dep_airport") + "</td>");
					out.println("<td>" + rs.getString("arr_airport") + "</td>");
					out.println("<td>" + rs.getString("dep_time") + "</td>");
					out.println("<td>" + rs.getString("arr_time") + "</td>");
					out.println("<td>" + rs.getString("days_of_week") + "</td>");
					out.println("<td>" + (rs.getBoolean("isInternational") ? "Yes" : "No") + "</td>");
					out.println("<td>$" + String.format("%.2f", rs.getDouble("price")) + "</td>");
					out.println("<td>" + rs.getInt("num_stops") + "</td>");
					out.println("</tr>");
				}
					
				out.println("</table>");
				rs.close();
				ps.close();
				conn.close();
					
			}catch(Exception e){
				out.println("<p style='color:red;'>Error: " + e + "</p>");
			}
		}
	}
	%>
	
	<br><br>
	<form action="repDashboard.jsp" method="get">
		<input type="submit" value="Rep Dashboard" style="background-color: #fff9c4">
	</form> 
	
</body>
</html>