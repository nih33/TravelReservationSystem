<%@ page import="java.sql.*, travel.db.ApplicationDB" %>
<h2>Manage Flights</h2>

<!-- Add Flight -->
<form method="post" action="addFlight.jsp">
    <h4>Add New Flight</h4>
    Flight Number: <input name="flight_number"><br>
    Airline ID: <input name="airline_id"><br>
    Aircraft ID: <input name="aircraft_id"><br>
    From: <input name="dep_airport"><br>
    To: <input name="arr_airport"><br>
    Departure Time: <input type="time" name="dep_time"><br>
    Arrival Time: <input type="time" name="arr_time"><br>
    Days of Week: <input name="days_of_week"><br>
    Is International: <select name="isInternational"><option value="1">Yes</option><option value="0">No</option></select><br>
    Price: <input name="price"><br>
    Stops: <input name="num_stops"><br>
    <input type="submit" value="Add Flight">
</form>

<hr>
<%
// List existing flights
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    con = new travel.db.ApplicationDB().getConnection();
    ps = con.prepareStatement("SELECT * FROM flights");
    rs = ps.executeQuery();
%>
<h3>Existing Flights</h3>
<table border="1">
<tr><th>ID</th><th>Flight #</th><th>From</th><th>To</th><th>Depart</th><th>Arrive</th><th>Delete</th></tr>
<%
    while (rs.next()) {
%>
<tr>
<td><%= rs.getInt("flight_id") %></td>
<td><%= rs.getString("flight_number") %></td>
<td><%= rs.getString("dep_airport") %></td>
<td><%= rs.getString("arr_airport") %></td>
<td><%= rs.getString("dep_time") %></td>
<td><%= rs.getString("arr_time") %></td>
<td>
    <form method="post" action="deleteFlight.jsp">
        <input type="hidden" name="flight_id" value="<%= rs.getInt("flight_id") %>">
        <input type="submit" value="Delete">
    </form>
</td>
</tr>
<% } %>
</table>
<% } catch (Exception e) {
    out.println("Error: " + e);
} finally {
    if (rs != null) rs.close(); if (ps != null) ps.close(); if (con != null) con.close();
} %>

<br><br>
	<form action="repDashboard.jsp" method="get">
		<input type="submit" value="Rep Dashboard" style="background-color: #fff9c4">
	</form> 

