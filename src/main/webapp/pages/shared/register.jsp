<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
<h2>Register</h2>
<form method="post">
    Username: <input type="text" name="username" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    First Name: <input type="text" name="fname" required><br><br>
    Last Name: <input type="text" name="lname" required><br><br>
    <input type="submit" value="Register">
</form>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");

    if (username != null && password != null && fname != null && lname != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TravelReservation", "root", "yourpassword");

            PreparedStatement ps1 = conn.prepareStatement("INSERT INTO users(username, password, role) VALUES (?, ?, 'customer')", Statement.RETURN_GENERATED_KEYS);
            ps1.setString(1, username);
            ps1.setString(2, password);
            ps1.executeUpdate();

            ResultSet rs = ps1.getGeneratedKeys();
            if (rs.next()) {
                int userId = rs.getInt(1);

                PreparedStatement ps2 = conn.prepareStatement("INSERT INTO customers(user_id, fname, lname) VALUES (?, ?, ?)");
                ps2.setInt(1, userId);
                ps2.setString(2, fname);
                ps2.setString(3, lname);
                ps2.executeUpdate();
                out.println("<p>Registration successful! <a href='login.jsp'>Login here</a></p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>