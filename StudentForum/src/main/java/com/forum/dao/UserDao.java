package com.forum.dao;

import java.sql.*;
import com.forum.models.User;

public class UserDao {
	private String jdbcURL = "jdbc:mysql://localhost:3306/student";
	private String jdbcUsername = "root";
	private String jdbcPassword = "";
	
	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
	}
	
	public boolean addUser(User user) {
	    String SQLQuery = "INSERT INTO users (uName, uEmail, hashedPassword) VALUES (?, ?, ?)";
	    
	    try (Connection con = getConnection();
	         PreparedStatement stmt = con.prepareStatement(SQLQuery)) {

	        stmt.setString(1, user.getName());
	        stmt.setString(2, user.getEmail());
	        stmt.setString(3, user.getPassword());

	        int rowsInserted = stmt.executeUpdate();

	        if (rowsInserted > 0) {
	            System.out.println("✅ Test Message: User added successfully!");
	        } else {
	            System.out.println("⚠️ Test Message: User was NOT added.");
	        }

	        return rowsInserted > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("❌ Test Message: SQL Exception occurred.");
	        return false;
	    }
	}
	
	public User searchUser(String username, String password) {
		String SQLQuery = "SELECT * FROM users WHERE uEmail = ?";
		User user = null;
		try(
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(SQLQuery)
		){
			pstmt.setString(1, username);
			
			ResultSet res = pstmt.executeQuery();
			if(res.next()) {
				user = new User();
				user.setId(res.getInt("uId"));
				user.setName(res.getString("uName"));
				user.setEmail(res.getString("uEmail"));
				user.setPassword(res.getString("hashedPassword"));
				
			}
			else {
				return null;
			}
			
			return user;
			
		}catch(SQLException e) {
			e.printStackTrace();
	        System.out.println("❌ Test Message: SQL Exception occurred.");
	        return null;
		}
	}


}
