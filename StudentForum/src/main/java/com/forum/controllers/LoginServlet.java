package com.forum.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import jakarta.servlet.http.*;

import com.forum.models.User;
import com.forum.dao.UserDao;

@WebServlet("/login")

public class LoginServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException,IOException {
		String email = request.getParameter("email");
		String  password = request.getParameter("password");
		
		UserDao dao = new UserDao();
		User user = dao.searchUser(email, password);
		if(user!= null && user.getPassword().equals(password)) {
			System.out.println(":) User found");
		}else {
		if(user == null ) {
			System.out.println("❌User not found");
		}
		
		else if(!user.getPassword().equals(password)) {
	        System.out.println("❌Password is wrong");
		}
		
		else {
			System.out.println("❌Unknown error");
		}
		}
	}
};
