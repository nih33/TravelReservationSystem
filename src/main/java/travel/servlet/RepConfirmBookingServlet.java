package travel.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;
import java.util.UUID;

import travel.db.ApplicationDB;

@WebServlet("/RepConfirmBookingServlet")
public class RepConfirmBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String flightIdStr = request.getParameter("flightId");

        if (userIdStr == null || flightIdStr == null || userIdStr.trim().isEmpty() || flightIdStr.trim().isEmpty()) {
            response.getWriter().println("Missing flight ID or user ID.");
            return;
        }

        int userId = Integer.parseInt(userIdStr);
        int flightId = Integer.parseInt(flightIdStr);
        String first = request.getParameter("firstName");
        String last = request.getParameter("lastName");
        String idNum = request.getParameter("idNumber");
        String fClass = request.getParameter("flightClass");

        double price;
        switch (fClass) {
            case "business": price = 400; break;
            case "first": price = 600; break;
            default: price = 200;
        }

        double bookingFee = 20.00;
        String ticketId = "T" + UUID.randomUUID().toString().replace("-", "").substring(0, 10);

        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // duplicate check
            String checkSql = "SELECT COUNT(*) FROM tickets t " +
                    "JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
                    "WHERE t.user_id = ? AND tf.flight_id = ?";
		    PreparedStatement checkStmt = con.prepareStatement(checkSql);
		    checkStmt.setInt(1, userId);
		    checkStmt.setInt(2, flightId);
		    ResultSet rs = checkStmt.executeQuery();
		
		    if (rs.next() && rs.getInt(1) > 0) {
		    	rs.close();
		    	checkStmt.close();
		    	con.close(); // also close the connection
		    	response.getWriter().println("User already has a ticket for this flight.");
		    	return;
		    }
		    rs.close();
		    checkStmt.close();
            
		    // insert ticket
            String insertTicket = "INSERT INTO tickets (ticket_id, user_id, class, total_fare, booking_fee, purchase_datetime, is_cancelled) " +
                    "VALUES (?, ?, ?, ?, ?, NOW(), 0)";
            PreparedStatement ps1 = con.prepareStatement(insertTicket);
            ps1.setString(1, ticketId);
            ps1.setInt(2, userId);
            ps1.setString(3, fClass);
            ps1.setDouble(4, price);
            ps1.setDouble(5, bookingFee);
            ps1.executeUpdate();
            ps1.close();


            String insertTF = "INSERT INTO ticket_flights (ticket_id, flight_id, sequence_num, seat_num) VALUES (?, ?, 1, NULL)";
            PreparedStatement ps2 = con.prepareStatement(insertTF);
            ps2.setString(1, ticketId);
            ps2.setInt(2, flightId);
            ps2.executeUpdate();
            ps2.close();

            con.close();
            
            // Redirect to the repBooking.jsp page with a query string to indicate booking confirmation
            response.sendRedirect("repBooking.jsp?bookingConfirmed=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Booking failed: " + e.getMessage());
            return;
        }
    }
}
