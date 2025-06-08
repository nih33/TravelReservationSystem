<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, java.util.*, travel.db.ApplicationDB" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancel Ticket</title>
</head>
<body>
<h2>Cancel Your Ticket</h2>
<form action="CancelTicketServlet" method="post">
    Ticket Number: <input type="text" name="ticketNumber"><br>
    <input type="submit" value="Cancel Ticket">
</form>
</body>
</html>