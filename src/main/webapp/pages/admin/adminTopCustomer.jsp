<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top-Spending Customer</title>
</head>
<body>

	<h3>The Current Top-Spending Customer is...</h3>
	<%
	
	try{
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement(
				"select c.user_id, c.fname, c.lname, sum(t.booking_fee) as total_spent " +
				"from customers c " +
				"join tickets t on c.user_id = t.user_id " +
				"where t.is_cancelled = 0 " +
				"group by c.user_id " +
				"order by total_spent desc " +
				"limit 1"
				);
		
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			int id = rs.getInt("user_id");
			String name = rs.getString("fname") + " " + rs.getString("lname");
			double total = rs.getDouble("total_spent");
			
			out.println("<p>" + name + "(Customer ID: " + id + "), with a total spending of " + String.format("%.2f", total)+ "</p>");
		}else{
			out.println("<p>No customer data.</p>");
		}
		
		rs.close();
		ps.close();
		conn.close();
	} catch(Exception e) {
		out.println("<p>style='color:red;Error: " + e + "</p>");
	}
	
	%>
	
	<br><br>
	<form action="adminDashboard.jsp" method="get">
		<input type="submit" value="Admin Dashboard" style="background-color: #fff9c4">
	</form> 

</body>
</html>