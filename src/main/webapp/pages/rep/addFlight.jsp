<%@ page import="java.sql.*, travel.db.ApplicationDB" %>
<%
String flight_number = request.getParameter("flight_number");
String airline_id = request.getParameter("airline_id");
String aircraft_id = request.getParameter("aircraft_id");
String dep_airport = request.getParameter("dep_airport");
String arr_airport = request.getParameter("arr_airport");
String dep_time = request.getParameter("dep_time");
String arr_time = request.getParameter("arr_time");
String days = request.getParameter("days_of_week");
String isIntl = request.getParameter("isInternational");
String priceStr = request.getParameter("price");
String stopsStr = request.getParameter("num_stops");

try {
    Connection con = new travel.db.ApplicationDB().getConnection();
    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO flights (flight_number, airline_id, aircraft_id, dep_airport, arr_airport, dep_time, arr_time, days_of_week, isInternational, price, num_stops) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    );
    ps.setString(1, flight_number);
    ps.setString(2, airline_id);
    ps.setString(3, aircraft_id);
    ps.setString(4, dep_airport);
    ps.setString(5, arr_airport);
    ps.setString(6, dep_time);
    ps.setString(7, arr_time);
    ps.setString(8, days);
    ps.setInt(9, Integer.parseInt(isIntl));
    ps.setDouble(10, Double.parseDouble(priceStr));
    ps.setInt(11, Integer.parseInt(stopsStr));
    ps.executeUpdate();
    ps.close();
    con.close();
    response.sendRedirect("repFlightManager.jsp");
} catch (Exception e) {
    out.println("Error adding flight: " + e.getMessage());
}
%>
