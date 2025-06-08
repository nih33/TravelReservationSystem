<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.sql.*, java.util.*, java.sql.Time, travel.db.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Results</title>
</head>
<body>
<h2>Flight Results</h2>

<%
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String airline = request.getParameter("airline");
    String maxStops = request.getParameter("stops");
    String maxPrice = request.getParameter("price");
    String depAfter = request.getParameter("depAfter");
    String arrBefore = request.getParameter("arrBefore");
    String role = (String) session.getAttribute("role");

    out.println("<p>Showing results from " + from + " to " + to + "</p>");
%>

<!-- Filter Form -->
<form method="get" action="flightResults.jsp">
    <input type="hidden" name="from" value="<%= from %>">
    <input type="hidden" name="to" value="<%= to %>">
    Airline: <input type="text" name="airline" value="<%= airline != null ? airline : "" %>"><br>
    Max Stops: <input type="number" name="stops" min="0" max="3" value="<%= maxStops != null ? maxStops : "" %>"><br>
    Max Price: <input type="number" name="price" value="<%= maxPrice != null ? maxPrice : "" %>"><br>
    Earliest Departure (HH:MM): <input type="time" name="depAfter" value="<%= depAfter != null ? depAfter : "" %>"><br>
    Latest Arrival (HH:MM): <input type="time" name="arrBefore" value="<%= arrBefore != null ? arrBefore : "" %>"><br>
    <input type="submit" value="Apply Filters">
</form>

<form action="home.jsp" method="get" style="margin-top: 10px;">
    <input type="submit" value="Home">
</form>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        StringBuilder query = new StringBuilder("SELECT * FROM flights WHERE dep_airport = ? AND arr_airport = ?");
        List<Object> params = new ArrayList<>();
        params.add(from);
        params.add(to);

        if (airline != null && !airline.isEmpty()) {
            query.append(" AND airline_id = ?");
            params.add(airline);
        }
        if (maxStops != null && !maxStops.isEmpty()) {
            query.append(" AND num_stops <= ?");
            params.add(Integer.parseInt(maxStops));
        }
        if (maxPrice != null && !maxPrice.isEmpty()) {
            query.append(" AND price <= ?");
            params.add(Double.parseDouble(maxPrice));
        }
        if (depAfter != null && !depAfter.isEmpty()) {
            query.append(" AND dep_time >= ?");
            params.add(Time.valueOf(depAfter + ":00"));
        }
        if (arrBefore != null && !arrBefore.isEmpty()) {
            query.append(" AND arr_time <= ?");
            params.add(Time.valueOf(arrBefore + ":00"));
        }

        ps = con.prepareStatement(query.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        rs = ps.executeQuery();

        out.println("<table border='1'>");
        out.println("<tr><th>Airline</th><th>Flight #</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th><th>Days</th><th>Price</th><th>Stops</th><th>Action</th></tr>");

        boolean found = false;
        while (rs.next()) {
            found = true;
            int flightId = rs.getInt("flight_id");
            String flightNum = rs.getString("flight_number");
            String airlineId = rs.getString("airline_id");
            String dep = rs.getString("dep_airport");
            String arr = rs.getString("arr_airport");
            String depTime = rs.getString("dep_time");
            String arrTime = rs.getString("arr_time");
            String days = rs.getString("days_of_week");
            double price = rs.getDouble("price");
            int stops = rs.getInt("num_stops");

            out.println("<tr>");
            out.println("<td>" + airlineId + "</td>");
            out.println("<td>" + flightNum + "</td>");
            out.println("<td>" + dep + "</td>");
            out.println("<td>" + arr + "</td>");
            out.println("<td>" + depTime + "</td>");
            out.println("<td>" + arrTime + "</td>");
            out.println("<td>" + days + "</td>");
            out.println("<td>$" + price + "</td>");
            out.println("<td>" + stops + "</td>");
            out.println("<td>");

            // Regular user booking
            out.println("<form action='bookFlight.jsp' method='get' style='display:inline;'>");
            out.println("<input type='hidden' name='flightId' value='" + flightId + "'/>");
            out.println("<input type='submit' value='Book'/>");
            out.println("</form>");

            out.println("</td></tr>");
        }

        if (!found) {
            out.println("<tr><td colspan='10'>No flights found.</td></tr>");
        }

        out.println("</table>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

<%-- Rep-only "Book for User" option below the table --%>
<% if ("rep".equals(role)) { %>
    <form action="repBookSearch.jsp" method="get" style="margin-top: 20px;">
        <input type="submit" value="Book Flight for User">
    </form>
<% } %>

</body>
</html>
