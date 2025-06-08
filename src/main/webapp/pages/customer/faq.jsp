<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, java.util.*, travel.db.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQs</title>
</head>
<body>
<h2>Search FAQs</h2>
<form method="get">
    Keyword: <input type="text" name="keyword"><br><br>
    <input type="submit" value="Search">
</form>

<%
    String keyword = request.getParameter("keyword");
    if (keyword != null) {
        // TODO: search messages table for answers that match keyword
        out.println("<p>Showing results for: " + keyword + "</p>");
    }
%>
<p>[Search results will go here]</p>
</body>
</html>