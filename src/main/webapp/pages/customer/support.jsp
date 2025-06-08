<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, java.util.*, travel.db.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Support</title>
</head>
<body>
<h2>Ask a Question</h2>
<form method="post">
    Subject: <input type="text" name="subject" required><br><br>
    Message:<br>
    <textarea name="message" rows="5" cols="40" required></textarea><br><br>
    <input type="submit" value="Send">
</form>

<%
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    if (subject != null && message != null) {
        // TODO: insert into messages table
        out.println("<p>Message sent successfully! (Stub)</p>");
    }
%>
</body>
</html>

