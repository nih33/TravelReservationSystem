package travel.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import travel.db.ApplicationDB;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketId = request.getParameter("ticketId");

        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement("UPDATE tickets SET is_cancelled = 1, total_fare = 0, booking_fee = 0 WHERE ticket_id = ?");
            ps.setString(1, ticketId);
            ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }

        response.sendRedirect("/TravelReservationSystem/pages/customer/myReservations.jsp");
    }
}
