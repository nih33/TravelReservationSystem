<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Most Active Flights</title>
</head>
<body>

	<h3>Most Active Flights</h3>
	<%
	try{
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"select f.flight_id, count(t.ticket_id) as ticket_count " +
				"from flights f " +
				"join ticket_flights tf on f.flight_id = tf.flight_id " +
				"join tickets t on tf.ticket_id = t.ticket_id " +
				"group by f.flight_id " +
				"order by ticket_count desc " +
				"limit 5"
				);
		
		ResultSet rs = ps.executeQuery();
		
		out.println("<table border='1'>");
		out.println("<tr> <th>Flight ID</th><th>Tickets Sold</th></tr>");


		while(rs.next()){
			out.println("<tr>");
			out.println("<td>" + rs.getInt("flight_id") + "</td>");
			out.println("<td>" + rs.getInt("ticket_count") + "</td>");
		}
		
		out.println("</table>");
		
		rs.close();
		ps.close();
		conn.close();
		
	} catch(Exception e){
		out.println("<p style = 'color:red;'>Error: " + e + "</p>");
	}
	%>
	
	<br><br>
	<form action="adminDashboard.jsp" method="get">
		<input type="submit" value="Admin Dashboard" style="background-color: #fff9c4">
	</form> 
	
</body>
</html>