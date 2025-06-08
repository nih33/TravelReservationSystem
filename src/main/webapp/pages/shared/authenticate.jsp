<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> Authentication </title>
</head>
<body>

	<% try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		String username = request.getParameter("usern");
		String password = request.getParameter("passw");
		
		String str = "SELECT * FROM users u WHERE username = ? AND password = ?";
		
		PreparedStatement stmt = con.prepareStatement(str);
		stmt.setString(1,username);
		stmt.setString(2,password);
		
		ResultSet result = stmt.executeQuery();
		
		if(result.next()){
			String role = result.getString("role");
			int userId = result.getInt("user_id");
			
			session.setAttribute("user", username);
			session.setAttribute("user_id", userId);
			session.setAttribute("role", role);
			
			if("admin".equals(role)){
				response.sendRedirect("/TravelReservationSystem/pages/admin/adminDashboard.jsp");
			}else if("rep".equals(role)){
				response.sendRedirect("/TravelReservationSystem/pages/rep/repDashboard.jsp");
			}else{
				response.sendRedirect("/TravelReservationSystem/pages/customer/home.jsp");
			}
		}else{
			response.sendRedirect("login.jsp?error=1");
		}
	%>
	
	<%} catch (Exception e) {
			out.print(e);
	}%>
			
</body>
</html>