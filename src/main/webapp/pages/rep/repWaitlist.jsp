<%@ page import="java.sql.*, travel.db.ApplicationDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Waitlists by Flight</title>
</head>
<body>
    <h2>Waitlists by Flight</h2>

    <form method="get" action="repWaitlist.jsp">
        Flight Number: <input type="text" name="flightNum">
        <input type="submit" value="View Waitlist">
    </form>

    <%
    String flightNum = request.getParameter("flightNum");
    if (flightNum != null && !flightNum.isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = new travel.db.ApplicationDB().getConnection();
            ps = con.prepareStatement(
                    "SELECT w.user_id, u.username, c.fname, c.lname, w.request_time " +
                    "FROM waitlist w " +
                    "JOIN users u ON w.user_id = u.user_id " +
                    "LEFT JOIN customers c ON w.user_id = c.user_id " +
                    "WHERE w.flight_number = ?"
                );
            ps.setString(1, flightNum);
            rs = ps.executeQuery();
    %>

    <h3>Waitlist for Flight <%= flightNum %></h3>
    <table border="1">
        <tr><th>User ID</th><th>Username</th><th>First Name</th><th>Last Name</th><th>Request Time</th></tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("fname") %></td>
            <td><%= rs.getString("lname") %></td>
            <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("request_time")) %></td>
        </tr>
        <%
            }
        %>
    </table>

    <%
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>

	<br><br>
	<form action="repDashboard.jsp" method="get">
		<input type="submit" value="Rep Dashboard" style="background-color: #fff9c4">
	</form> 
</body>
</html>
