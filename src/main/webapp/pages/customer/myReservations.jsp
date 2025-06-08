<%@ page import="java.sql.*, travel.db.ApplicationDB" %>
<%
    int userId = (int) session.getAttribute("user_id"); // Ensure user_id is correctly set in session
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Query adjusted to match column names
		ps = con.prepareStatement(
    		"SELECT t.ticket_id, t.class, t.purchase_datetime, t.total_fare, t.is_cancelled, " +
    		"f.dep_airport, f.arr_airport, tf.seat_num " +
    		"FROM tickets t " +
    		"JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
    		"JOIN flights f ON tf.flight_id = f.flight_id " +
    		"WHERE t.user_id = ?"
		);
        ps.setInt(1, userId); // Use userId as an integer
        rs = ps.executeQuery();
%>
<% String user = (String) session.getAttribute("user"); %>
<h2><%= user %>'s Reservations</h2>
<table border="1">
<tr><th>Flight</th><th>From</th><th>To</th><th>Class</th><th>Time</th><th>Total Price</th><th>Seat #</th><th>Cancel</th></tr>
<%
    while (rs.next()) {
        String ticketId = rs.getString("ticket_id");
        String from = rs.getString("dep_airport");
        String to = rs.getString("arr_airport");
        String fClass = rs.getString("class"); // updated column name
        Timestamp bookingTime = rs.getTimestamp("purchase_datetime"); // updated column name
        double totalPrice = rs.getDouble("total_fare"); // updated column name
        int seatNum = rs.getInt("seat_num");
        boolean isCancelled = rs.getBoolean("is_cancelled");
%>
<tr>
    <td><%= ticketId %></td>
    <td><%= from %></td>
    <td><%= to %></td>
    <td><%= fClass %></td>
    <td><%= bookingTime %></td>
    <td><%= totalPrice %></td>
    <td><%= seatNum == 0 ? "N/A" : seatNum %></td>
    <td>
    <% if (!isCancelled && !fClass.equals("economy")) { %>
        <form action="CancelBookingServlet" method="post">
            <input type="hidden" name="ticketId" value="<%= ticketId %>"/>
            <input type="submit" value="Cancel"/>
        </form>
    <% } else if (isCancelled){ %>
        Cancelled
    <% } else{ %>
    	N/A
    <% } %>
    </td>
</tr>
<%
    }
} catch (Exception e) { out.println("Error: " + e); }
finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (con != null) con.close();
}
%>
</table>

<!-- Back to Home Button -->
<form action="home.jsp">
    <button type="submit">Back to Home</button>
</form>
