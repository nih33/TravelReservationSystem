<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket Edit</title>
</head>
<body>

	<form method="post">
    	<input type="hidden" name="actionSelect" value="editTicket">
    		Enter Ticket ID to Edit: <input type="text" name="ticketID" required>
    	<input type="submit" value="Edit Ticket">
	</form>

	<%
	
	String ticketID = request.getParameter("ticketID");
	if ("editTicket".equals(request.getParameter("actionSelect")) && ticketID != null && request.getParameter("updateTicket") == null) {
		ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
	    PreparedStatement ps = conn.prepareStatement("SELECT * FROM tickets WHERE ticket_id = ?");
	    ps.setString(1, ticketID);
	    ResultSet ticket = ps.executeQuery();
	    if (ticket.next()) {
	    	
	%>
	
	<h3>Editing Ticket ID: <%= ticketID %></h3>
	
	<form method="post">
	    Flight ID: <input type="number" name="editFlightID" value="<%= ticket.getInt("flight_id") %>" required><br>
	    Class:
	    <select name="editClass" required>
	        <option value="economy" <%= "economy".equals(ticket.getString("class")) ? "selected" : "" %>>Economy</option>
	        <option value="business" <%= "business".equals(ticket.getString("class")) ? "selected" : "" %>>Business</option>
	        <option value="first" <%= "first".equals(ticket.getString("class")) ? "selected" : "" %>>First</option>
	    </select><br>
	    Total Fare: <input type="number" name="editFare" value="<%= ticket.getDouble("total_fare") %>" required><br>
	    Booking Fee: <input type="number" name="editFee" value="<%= ticket.getDouble("booking_fee") %>" required><br>
	
	    <input type="hidden" name="actionSelect" value="editTicket">
	    <input type="hidden" name="ticketID" value="<%= ticketID %>">
	    <input type="submit" name="updateTicket" value="Update Ticket">
	    
	</form>
	
	<%
	    }
	    conn.close();
	}
	%>
	
	<%
	if ("editTicket".equals(request.getParameter("actionSelect")) && request.getParameter("updateTicket") != null) {
	    try {
	        String tID = request.getParameter("ticketID");
	        int newFlightID = Integer.parseInt(request.getParameter("editFlightID"));
	        String newClass = request.getParameter("editClass");
	        double newFare = Double.parseDouble(request.getParameter("editFare"));
	        double newFee = Double.parseDouble(request.getParameter("editFee"));
	
	        ApplicationDB db = new ApplicationDB();
	        Connection conn = db.getConnection();
	
	        PreparedStatement ps = conn.prepareStatement(
	            "UPDATE tickets SET flight_id = ?, class = ?, total_fare = ?, booking_fee = ? WHERE ticket_id = ?"
	        );
	        ps.setInt(1, newFlightID);
	        ps.setString(2, newClass);
	        ps.setDouble(3, newFare);
	        ps.setDouble(4, newFee);
	        ps.setString(5, tID);
	
	        int rows = ps.executeUpdate();
	        if (rows == 1) {
	            out.println("<p style='color: green;'>Ticket updated successfully.</p>");
	        } else {
	            out.println("<p style='color: orange;'>No ticket updated.</p>");
	        }
	
	        conn.close();
	    } catch (Exception e) {
	        out.println("<p style='color: red;'>Update Error: " + e + "</p>");
	    }
	}
	%>


<br><br>
<form action="repDashboard.jsp" method="get">
		<input type="submit" value="Rep Dashboard" style="background-color: #fff9c4;">
</form> 

</body>
</html>