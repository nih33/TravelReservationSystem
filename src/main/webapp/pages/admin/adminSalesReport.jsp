<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Report</title>
</head>
<body>

	<h3> Monthly Sales Report </h3>
	<form method="post">
		<label for="month">Month:</label>
		<select name="month" required>
			<option value="">-- Select Month --</option>
			<option value="01">January</option>
			<option value="02">February</option>
			<option value="03">March</option>
			<option value="04">April</option>
			<option value="05">May</option>
			<option value="06">June</option>
			<option value="07">July</option>
			<option value="08">August</option>
			<option value="09">September</option>
			<option value="10">October</option>
			<option value="11">November</option>
			<option value="12">December</option>
		</select>
		
		<label for="year">Year:</label>
		<select name="year" required>
			<option value="">-- Select Year --</option>
			<option value="2024">2024</option>
			<option value="2025">2025</option>
			<option value="2026">2026</option>
		</select>
		
		<input type="hidden" name="selected" value="monthYear">
		<input type="submit" value="View Report">
		
	</form>
	
<%
	String selected = request.getParameter("selected"); // gets "month"
	if("monthYear".equals(selected)){
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		
		if(month != null && year != null && !month.isEmpty() && !year.isEmpty()){
			try{
				String sDate = year + "-" + month + "-01 00:00:00";
				
				int intYear = Integer.parseInt(year);
				int intMonth = Integer.parseInt(month);
				String eDate;
				
				if(intMonth == 12){
					eDate = (intYear + 1) + "-01 00:00:00";
				}else{
					eDate = intYear + "-" + String.format("%02d", intMonth + 1) + "-01 00:00:00";
				}
			
			
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				
				PreparedStatement ps = conn.prepareStatement(
						"select count(*) as total_tickets, sum(booking_fee) as total_rev from tickets t where t.is_cancelled = 0 and purchase_datetime >= ? and purchase_datetime < ?"
				);
				
				ps.setString(1,sDate);
				ps.setString(2,eDate);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()){ // true if there is at least 1 row in rs
					int ticketCount = rs.getInt("total_tickets");
					double totalRev = rs.getDouble("total_rev");
	
%>
				
	<h3>Sales Report for <%= year %> - <%= month %></h3>
	<p>Tickets Sold: <%= ticketCount %></p>
	<p>Total Revenue: $<%= String.format("%.2f", totalRev) %></p>
				
<%
				
				}else{
					out.println("<p>No sales data found for {month} </p>");
				}
				
				conn.close();
			
			}catch(Exception e){
				out.println("<p> style='color: red;'>Error: " + e + "</p>");
			}
		} else{
			out.println("<p> style='color: red;'>Please select a month and year to generate the sales report.</p>");
		}
	}
%>

<br>
<br>
<form action="adminDashboard.jsp" method="get">
		<input type="submit" value="Admin Dashboard" style="background-color: #fff9c4;">
</form> 

</body>
</html>