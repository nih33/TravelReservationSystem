<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Travel Reservation System</title>
</head>

<body>

	<h2 style="margin-bottom: 5px;">Sign In</h2> 
	
	<% if(request.getParameter("error")!=null){ %>
		<p style="color: red"> <b>Sorry, we couldn't find an account with that username and password.</b></p>
	<% } else if(request.getParameter("logout")!=null){%>
		<p style="color: red"> <b>You've been successfully signed out.</b></p>
	<% } %>
	
	
	<form method="post" action="authenticate.jsp">
	
		<label for="usern">Username: </label>
		<input type="text" name="usern"/><br>
		
		<label for="usern">Password: </label>
		<input type="text" name="passw"/><br>
		
		<input type="submit" value="Sign In">
		
	</form>
	
	<!-- SIGN IN HTML W/ TABLE (for reference) -->
	<!-- 
	<br>
	<form method="post" action="authenticate.jsp">
		<table>
			<tr>
				<td>Username</td><td><input type="text" name="usern"></td>
			</tr>
			<tr>
				<td>Password</td><td><input type="text" name="passw"></td>
			</tr>
		</table>
		<input type="submit" value="Sign In">
	</form>
	<br>  
	-->
	
</body>
</html>