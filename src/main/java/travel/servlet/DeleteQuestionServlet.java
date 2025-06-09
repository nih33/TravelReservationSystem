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

/**
 * Servlet implementation class DeleteQuestionServlet
 */
@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteQuestionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String qidStr = request.getParameter("questionId");

		if (qidStr == null || qidStr.trim().isEmpty()) {
			response.getWriter().println("Missing question ID.");
			return;
		}

		int qid = Integer.parseInt(qidStr);

		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			PreparedStatement ps = con.prepareStatement("DELETE FROM questions WHERE question_id = ?");
			ps.setInt(1, qid);
			int rowsAffected = ps.executeUpdate();

			ps.close();
			con.close();

			if (rowsAffected > 0) {
				response.sendRedirect("/TravelReservationSystem/pages/shared/qa.jsp");  // Redirect to updated Q&A page
			} else {
				response.getWriter().println("Question not found.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error deleting question: " + e.getMessage());
		}
	}

}
