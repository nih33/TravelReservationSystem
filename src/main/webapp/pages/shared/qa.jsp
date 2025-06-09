<%@ page import="java.sql.*, travel.db.ApplicationDB" %>
<%
String role = (String) session.getAttribute("role");
%>
<form method="get" action="/TravelReservationSystem/pages/shared/qa.jsp">
    Search by keyword: <input type="text" name="q"><input type="submit" value="Search"/>
</form>

<%if("customer".equals(role)) { %>
	<form action="/TravelReservationSystem/pages/customer/home.jsp" method="get" style="display:inline;">
	    <input type="submit" value="Home">
	</form>
<% } %>

<a href="/TravelReservationSystem/pages/customer/askQuestion.jsp">Ask a Question</a>
<hr>
<%
String keyword = request.getParameter("q");
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = new travel.db.ApplicationDB().getConnection();
    String query = "SELECT * FROM questions";
    if (keyword != null && !keyword.isEmpty()) {
        query += " WHERE question_text LIKE ?";
        ps = con.prepareStatement(query);
        ps.setString(1, "%" + keyword + "%");
    } else {
        ps = con.prepareStatement(query);
    }
    rs = ps.executeQuery();

    while (rs.next()) {
        int qid = rs.getInt("question_id");
        String qtext = rs.getString("question_text");
        String ans = rs.getString("answer_text");
%>
	<p><b>Q:</b> <%= qtext %></p>
	<p><b>A:</b> <%= ans == null ? "Awaiting response..." : ans %></p>
<%
	    if ("rep".equals(role)) {
	    	if(ans == null) {
%>
			<form method="post" action="${pageContext.request.contextPath}/ReplyToQuestionServlet">
			    <input type="hidden" name="questionId" value="<%= qid %>">
			    <textarea name="answer" rows="2" cols="40"></textarea><br>
			    <input type="submit" value="Reply">
			</form>
<% 
    		} 
%>
		<form method="post" action="${pageContext.request.contextPath}/DeleteQuestionServlet" onsubmit="return confirm('Are you sure you want to delete this question?');">
		    <input type="hidden" name="questionId" value="<%= qid %>">
		    <input type="submit" value="Delete Question" style="color: red;">
		</form>
<%
    	} // end if rep
%>
<hr>
<% 
	} // end while
} catch (Exception e) {
    out.println("Error: " + e);
} finally {
    if (rs != null) rs.close(); if (ps != null) ps.close(); if (con != null) con.close();
}
%>

<%
    if ("rep".equals(role)) {
%>
    <br><br>
	<form action="/TravelReservationSystem/pages/rep/repDashboard.jsp" method="get">
		<input type="submit" value="Rep Dashboard" style="background-color: #fff9c4">
	</form> 
<%
    }
%>
