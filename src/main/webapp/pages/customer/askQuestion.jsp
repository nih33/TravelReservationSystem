<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, java.util.*, travel.db.ApplicationDB" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ask a Question</title>
</head>
<body>
<h2>Contact Support</h2>
<form action="${pageContext.request.contextPath}/SubmitQuestionServlet" method="post">
    Subject: <input type="text" name="subject"><br>
    Question:<br>
    <textarea name="question" rows="5" cols="40"></textarea><br>
    <input type="submit" value="Submit">
</form>

<form action="/TravelReservationSystem/pages/customer.jsp" method="get" style="display:inline;">
    <input type="submit" value="Home">
</form>

<form action="/TravelReservationSystem/pages/shared/qa.jsp" method="get" style="display:inline;">
    <input type="submit" value="Back to Q&A">
</form>

</body>
</html>