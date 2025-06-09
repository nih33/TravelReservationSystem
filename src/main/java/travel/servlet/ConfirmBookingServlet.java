package travel.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import travel.db.ApplicationDB;

@WebServlet("/ConfirmBookingServlet")
public class ConfirmBookingServlet extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("user_id");
        int flightId = Integer.parseInt(request.getParameter("flightId"));
        String first = request.getParameter("firstName");
        String last = request.getParameter("lastName");
        String idNum = request.getParameter("idNumber");
        String fClass = request.getParameter("flightClass");
        
        double basePrice = fClass.equals("economy") ? 250 : fClass.equals("business") ? 400 : 600;
        double bookingFee = 20;
        double totalPrice = basePrice + bookingFee;
        String ticketId = "T" + System.currentTimeMillis();

        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            String checkSql = "SELECT COUNT(*) FROM tickets t " +
                    "JOIN ticket_flights tf ON t.ticket_id = tf.ticket_id " +
                    "WHERE t.user_id = ? AND tf.flight_id = ? AND t.class = ? AND t.is_cancelled = 0";
            PreparedStatement checkStmt = con.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, flightId);
            checkStmt.setString(3,  fClass);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
            	rs.close();
            	checkStmt.close();
            	con.close();
            	response.getWriter().println("You already have a ticket for this flight.");
            	return;
            }
            rs.close();
            checkStmt.close();
  
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO tickets (ticket_id, user_id, class, total_fare, booking_fee, purchase_datetime, is_cancelled) " +
                            "VALUES (?, ?, ?, ?, ?, NOW(), 0)"
            );

            ps.setString(1, ticketId);
            ps.setInt(2, userId);
            ps.setString(3, fClass);
            ps.setDouble(4, totalPrice);
            ps.setDouble(5, bookingFee);
            ps.executeUpdate();
            ps.close();
            
            // Count existing seats
            PreparedStatement seatCount = con.prepareStatement(
                    "SELECT COUNT(*) AS booked FROM ticket_flights WHERE flight_id = ?"
            );
            seatCount.setInt(1, flightId);
            rs = seatCount.executeQuery();
            int booked = rs.next() ? rs.getInt("booked") : 0;
            rs.close();
            seatCount.close();


            if(booked < 5) { // hard coded capacity as 5
	            PreparedStatement linkFlight = con.prepareStatement(
	                    "INSERT INTO ticket_flights (ticket_id, flight_id, sequence_num, seat_num) VALUES (?, ?, 1, ?)"
	            );
	            linkFlight.setString(1, ticketId);
	            linkFlight.setInt(2,  flightId);
	            linkFlight.setInt(3, booked + 1);
	            linkFlight.executeUpdate();
	            linkFlight.close();
            } else {
            	PreparedStatement waitStmt = con.prepareStatement(
            		    "INSERT INTO waitlist (waitlist_id, user_id, flight_id, request_time) VALUES (?, ?, ?, NOW())"
            		);
            	waitStmt.setString(1, "W" + System.currentTimeMillis()); 
            	waitStmt.setInt(2, userId);
           		waitStmt.setInt(3, flightId);
           		waitStmt.executeUpdate();
           		waitStmt.close();
            }
            
            con.close();
            response.sendRedirect("/TravelReservationSystem/pages/customer/myReservations.jsp");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Booking failed: " + e.getMessage());
            return;
        }
    }
}
