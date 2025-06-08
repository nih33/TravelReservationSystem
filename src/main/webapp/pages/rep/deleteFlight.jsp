<%@ page import="java.sql.*, travel.db.ApplicationDB" %>
<%
String flightIdStr = request.getParameter("flight_id");

try {
    Connection con = new travel.db.ApplicationDB().getConnection();
    PreparedStatement ps = con.prepareStatement("DELETE FROM flights WHERE flight_id = ?");
    ps.setInt(1, Integer.parseInt(flightIdStr));
    ps.executeUpdate();
    ps.close();
    con.close();
    response.sendRedirect("repFlightManager.jsp");
} catch (Exception e) {
    out.println("Error deleting flight: " + e.getMessage());
}
%>
