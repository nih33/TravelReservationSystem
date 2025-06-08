<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Revenue Summary</title>
</head>
<body>

	<h3>Revenue Summary</h3>
	
	<form method="post"> 
		<label for="summaryType">Group Revenue By:</label>
		<select name="summaryType" required>
			<option value="">-- Select --</option>
			<option value="flight">Flight</option>
			<option value="airline">Airline</option>
			<option value="customer">Customer</option>
		</select>
		<input type="submit" value="View Report">
		<input type="hidden" name="selected" value="summary">
	</form>

<%
	String selected = request.getParameter("selected");
	if("summary".equals(selected)){
		String type = request.getParameter("summaryType");
		if(type != null && !type.isEmpty()){
			try{
				
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				
				PreparedStatement ps = null;
				String queryTitle = "";
				
				if("flight".equals(type)){
					ps = conn.prepareStatement("select flight_id, sum(booking_fee) as total_rev from tickets t join ticket_flights tf on t.ticket_id = tf.ticket_id where t.is_cancelled=0 group by flight_id");
					queryTitle = "Revenue By Flight";
				}else if("airline".equals(type)){
					ps = conn.prepareStatement("select f.airline_id, sum(t.booking_fee) as total_rev " 
												+ "from tickets t "
												+ "join ticket_flights tf on t.ticket_id = tf.ticket_id "
												+ "join flights f on tf.flight_id=f.flight_id "
												+ "where t.is_cancelled = 0 "
												+ "group by f.airline_id"
												);
					queryTitle = "Revenue By Airline";
				}else if("customer".equals(type)){
					ps = conn.prepareStatement("select user_id, sum(booking_fee) as total_rev from tickets t where t.is_cancelled = 0 group by user_id");
					queryTitle = "Revenue By Customer";
				}
				
				ResultSet rs = ps.executeQuery();
				
				out.println("<h3>" + queryTitle + "</h3>");
				out.println("<table border='1'>");
				
				if("flight".equals(type)){
					out.println("<tr><th>Flight ID</th><th>Total Revenue</th></tr>");
					while(rs.next()){
						out.println("<tr><td>" + rs.getInt("flight_id") + "</td><td>$" + String.format("%.2f", rs.getDouble("total_rev")) + "</td></tr>");
					}
				}else if("airline".equals(type)){
					out.println("<tr><th>Airline ID</th><th>Total Revenue</th></tr>");
					while(rs.next()){
						out.println("<tr><td>" + rs.getString("airline_id") + "</td><td>$" + String.format("%.2f", rs.getDouble("total_rev")) + "</td></tr>");
					}
				}else if("customer".equals(type)){
					out.println("<tr><th>Customer ID</th><th>Total Revenue</th></tr>");
					while(rs.next()){
						out.println("<tr><td>" + rs.getInt("user_id") + "</td><td>$" + String.format("%.2f", rs.getDouble("total_rev")) + "</td></tr>");
					}
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
	<form action="adminDashboard.jsp" method="get">
		<input type="submit" value="Admin Dashboard" style="background-color: #fff9c4">
	</form> 

</body>
</html>