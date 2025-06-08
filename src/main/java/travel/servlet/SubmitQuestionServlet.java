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

@WebServlet("/SubmitQuestionServlet")
public class SubmitQuestionServlet extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = (String) request.getSession().getAttribute("user");
        String q = request.getParameter("question");

        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            PreparedStatement ps = con.prepareStatement("INSERT INTO questions (username, question_text) VALUES (?, ?)");
            ps.setString(1, user);
            ps.setString(2, q);
            ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("qa.jsp");
    }
}
