<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="travel.db.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin User Management</title>
</head>
<body>

	<!-- Dropdown form to choose an action -->
	<form method="post">
		<label for="actionSelect">Choose Action: </label>
		<select name="actionSelect" id="actionSelect" required>
			<option value="">-- Select --</option>
			<option value="add">Add User</option>
			<option value="edit">Edit User</option>
			<option value="delete">Delete User</option>
		</select>
		
		<input type="submit" value="Go">
	</form>

<%
	// reads selected action
	String action = request.getParameter("actionSelect");
		

	// ADD USER
	if("add".equals(action)){
		
%>
		<h3>Add User</h3>
		<form method="post" action="adminUserManagement.jsp">
			<input type="hidden" name="actionSelect" value="add">
			<!-- Form to enter username, password, role -->
			Username: <input type="text" name="newUsern" required>
			Password: <input type="password" name="newPassw" required>
			Role: 
			<select name="newRole" required>
				<option value="customer">Customer</option>
				<option value="rep">Rep</option>
			</select>
			<input type="submit" name="addUser" value="Add User">
			
		</form>
	
<%
		
		if(request.getParameter("addUser") != null){
			
			// read form data
			String usern = request.getParameter("newUsern");
			String passw = request.getParameter("newPassw");
			String role = request.getParameter("newRole");
				
			try{
				// insert new user
				ApplicationDB db = new ApplicationDB();
				Connection conn = db.getConnection();
				
				PreparedStatement stmt = conn.prepareStatement(
						"INSERT INTO users (role, username, password) VALUES (?, ?, ?)");
				stmt.setString(1,role);
				stmt.setString(2,usern);
				stmt.setString(3,passw);
				stmt.executeUpdate();
					
				out.println("<p style='color: blue;'> User added successfully.</p>");
				conn.close();
					
			} catch(Exception e){
				out.println("<p style='color: red;'> Error: " + e + "</p>");
			}
						
		}
		
	// EDIT USER
	}else if("edit".equals(action)){
		try{
			
			// display all users in database
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select user_id, username, password, role from users");
			
	%>
			<h3>Select a User to Edit</h3>
			<table border="1">
				<tr><th>ID</th><th>Username</th><th>Password</th><th>Role</th></tr>
	<%	
			while(rs.next()){
	%>
				<tr> 
					<td><%= rs.getInt("user_id") %></td>
					<td><%= rs.getString("username") %></td>
					<td><%= rs.getString("password") %></td>
					<td><%= rs.getString("role") %></td>
				</tr>
	<%
			}
	%>
				
			</table>
			
			<!-- Form to enter userID to edit -->
			<form method="post">
				<input type="hidden" name="actionSelect" value="edit">
				Enter User ID to Edit: <input type="number" name="userID" required>
				<input type="submit" value="Edit">
			</form>
		
	<%
			conn.close();
	
		}catch(Exception e){
			out.println("Error: " + e);
		}
	
		try{
			
			// get user information to edit
			int uid = 0;
			String uidStr = request.getParameter("userID");
			if(uidStr != null && request.getParameter("updateUser") == null){
				uid = Integer.parseInt(uidStr);
			}
			
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("select * from users where user_id= ?");
			ps.setInt(1,uid);
			ResultSet user = ps.executeQuery();
			
			// display user's current info (editable)
			if(user.next()){
	%>
				<h3>Editing User ID: <%= uid %></h3>
				<form method="post">
					Username: <input type="text" name="editUsern" value="<%= user.getString("username") %>" required> <br>
					Password: <input type="password" name="editPass" value="<%= user.getString("password") %>"required> <br>
					Role:
					<select name="editRole" required>
                    	<option value="customer" <%= "customer".equals(user.getString("role")) ? "selected" : "" %>>Customer</option>
                    	<option value="rep" <%= "rep".equals(user.getString("role")) ? "selected" : "" %>>Rep</option>
               		</select>
               		
               		<input type="hidden" name="actionSelect" value="edit">
                	<input type="hidden" name="userID" value="<%= uid %>">
                	<input type="submit" name="updateUser" value="Update">
					
				</form>
	<% 
			}
			conn.close();
		} catch(Exception e){
			out.println("Error: " + e);
		}
	
		// update user information in database
		if ("edit".equals(action) && request.getParameter("updateUser") != null) {
		    try {
		        int uid = Integer.parseInt(request.getParameter("userID"));
		        String newUsern = request.getParameter("editUsern");
		        String newPass = request.getParameter("editPass");
		        String newRole = request.getParameter("editRole");
		
		        ApplicationDB db = new ApplicationDB();
		        Connection conn = db.getConnection();
		
		        PreparedStatement ps = conn.prepareStatement(
		            "UPDATE users SET username = ?, password = ?, role = ? WHERE user_id = ?");
		        ps.setString(1, newUsern);
		        ps.setString(2, newPass);
		        ps.setString(3, newRole);
		        ps.setInt(4, uid);
		
		        int rows = ps.executeUpdate();
		        if (rows == 1) {
		            out.println("<p style='color: green;'>User updated successfully.</p>");
		        } else {
		            out.println("<p style='color: orange;'>No user updated.</p>");
		        }
		
		        conn.close();
		    } catch (Exception e) {
		        out.println("<p style='color: red;'>Update Error: " + e + "</p>");
		    }
		}

	// DELETE USER
	}else if("delete".equals(action)){
		try{
			ApplicationDB db = new ApplicationDB();
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select user_id, username, role from users");
%>		
		<h3>Select User to Delete</h3>
		<table border="1">
				<tr><th>ID</th><th>Username</th><th>Role</th></tr>
<%	
			while(rs.next()){
%>
				<tr> 
					<td><%= rs.getInt("user_id") %></td>
					<td><%= rs.getString("username") %></td>
					<td><%= rs.getString("role") %></td>
				</tr>
<%
			}
%>
		</table>
		
		<!-- Form to enter userID to delete -->
		<form method="post">
			<input type="hidden" name="actionSelect" value="delete">
			Enter User ID to Delete: <input type="number" name="deleteUserID" required>
			<input type="submit" name="confirmDelete" value=Delete>
		</form>
		
<% 
		conn.close();
		}catch(Exception e){
		out.println("Error: " + e);
		}
	}
	
	// update user information in database
	if ("delete".equals(action) && request.getParameter("confirmDelete") != null) {
		try {
			int deleteID = Integer.parseInt(request.getParameter("deleteUserID"));
		
		    ApplicationDB db = new ApplicationDB();
		    Connection conn = db.getConnection();
	
		    PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE user_id = ?");
		    ps.setInt(1,deleteID);
		
		    int rows = ps.executeUpdate();
		    if (rows == 1) {
	            out.println("<p style='color: green;'>User deleted successfully.</p>");
		    } else {
		        out.println("<p style='color: orange;'>No user deleted.</p>");
		    }
		
		    conn.close();
		} catch (Exception e) {
		    out.println("<p style='color: red;'>Update Error: " + e + "</p>");
		}
	}
	
	
%>
	<br>
	<br>
	<form action="adminDashboard.jsp" method="get">
		<input type="submit" value="Admin Dashboard" style="background-color: #fff9c4;">
	</form>
	
</body>
</html>
