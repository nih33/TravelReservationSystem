<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, travel.db.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Flight for User</title>
</head>
<body>

<%
    // Check if the booking has been confirmed by looking for the query parameter
    String bookingConfirmed = request.getParameter("bookingConfirmed");
    if ("true".equals(bookingConfirmed)) {
%>
    <p style="color: green; font-weight: bold;">Booking confirmed! Your ticket has been successfully booked.</p>
    <!-- Go back to home page button -->
    <form action="home.jsp" method="get">
        <input type="submit" value="Go Back to Home"/>
    </form>
<%
    } else {
        // Get the flight number from the request
        String flightNum = request.getParameter("flightNum");

        // Database connection setup
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // Establish connection to the database
            con = new travel.db.ApplicationDB().getConnection();
            ps = con.prepareStatement("SELECT * FROM flights WHERE flight_number = ?");
            ps.setString(1, flightNum);
            rs = ps.executeQuery();

            if (!rs.next()) {  // Flight not found
%>
        <p style="color:red;">No flight found with number <%= flightNum %></p>
        <!-- Back to search flight page button -->
        <form action="repBookSearch.jsp" method="get">
            <input type="submit" value="Search Again">
        </form>
        <!-- Back to home page button -->
        <form action="home.jsp" method="get">
            <input type="submit" value="Back to Home"/>
        </form>
<%
            } else {  // Flight found
                int flightId = rs.getInt("flight_id");
%>
<h2>Confirm Booking for Flight <%= flightNum %></h2>
<form action="RepConfirmBookingServlet" method="post">
    <input type="hidden" name="flightId" value="<%= flightId %>">
    User ID: <input type="number" name="userId" required><br>
    First Name: <input type="text" name="firstName" required><br>
    Last Name: <input type="text" name="lastName" required><br>
    Flight ID: <input type="text" name="idNumber" required><br>
    Class: 
    <select name="flightClass">
        <option value="economy">Economy</option>
        <option value="business">Business</option>
        <option value="first">First</option>
    </select><br>
    <input type="submit" value="Confirm Booking">
</form>
<%
            }
            // Close database resources
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

	<br><br>
	<form action="adminDashboard.jsp" method="get">
		<input type="submit" value="Admin Dashboard" style="background-color: #fff9c4">
	</form> 

</body>
</html>
