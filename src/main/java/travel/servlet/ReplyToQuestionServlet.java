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


@WebServlet("/ReplyToQuestionServlet")
public class ReplyToQuestionServlet extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        String answer = request.getParameter("answer");

        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE questions SET answer_text = ? WHERE question_id = ?");
            ps.setString(1, answer);
            ps.setInt(2, questionId);
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("qa.jsp");
    }
}

