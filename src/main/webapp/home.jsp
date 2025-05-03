<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
</head>

<body>
	<% String user = (String) session.getAttribute("user"); %>
	Welcome back, <%= user %>!
	
	<h2 style="margin-bottom: 5px;">Sign Out</h2> 
	
	<form method="post" action="logout.jsp">
	
		<input type="submit" value="Sign Out"/>
		
	</form>
	
</body>
</html>