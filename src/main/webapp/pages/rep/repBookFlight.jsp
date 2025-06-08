<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, travel.db.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Flight</title>
</head>
<body>
<h2>Booking Confirmation</h2>

<%
    int flightId = Integer.parseInt(request.getParameter("flightId"));

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        String query = "SELECT * FROM flights WHERE flight_id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, flightId);
        rs = ps.executeQuery();

        if (rs.next()) {
            String airline = rs.getString("airline_id");
            String flightNum = rs.getString("flight_number");
            String from = rs.getString("dep_airport");
            String to = rs.getString("arr_airport");
            String depTime = rs.getString("dep_time");
            String arrTime = rs.getString("arr_time");

            out.println("<p><strong>Airline:</strong> " + airline + "</p>");
            out.println("<p><strong>Flight Number:</strong> " + flightNum + "</p>");
            out.println("<p><strong>From:</strong> " + from + "</p>");
            out.println("<p><strong>To:</strong> " + to + "</p>");
            out.println("<p><strong>Departure Time:</strong> " + depTime + "</p>");
            out.println("<p><strong>Arrival Time:</strong> " + arrTime + "</p>");

            // Button to go to booking.jsp
            out.println("<form method='post' action='booking.jsp'>");
            out.println("<input type='hidden' name='flightId' value='" + flightId + "'/>");
            out.println("<input type='submit' value='Continue to Passenger Details'/>");
            out.println("</form>");
        } else {
            out.println("<p>Flight not found.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

	<br><br>
	<form action="repDashboard.jsp" method="get">
		<input type="submit" value="Rep Dashboard" style="background-color: #fff9c4">
	</form> 

</body>
</html>