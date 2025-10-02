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
		try {
			Connection con = getConnection();
			PreparedStatement stmt = con.prepareStatement(SQLQuery);
			
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			
			int rowsInserted = stmt.executeUpdate();
			return rowsInserted>0;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
