package com.forum.controllers;

import jakarta.servlet.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;


import com.forum.dao.UserDao;
import com.forum.models.User;

import jakarta.servlet.http.*;

@WebServlet("/signup")

public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
		User user = new User();
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));
		user.setPassword(request.getParameter("password"));
		
		UserDao dao = new UserDao();
		boolean success = dao.addUser(user);
		
		if(success) {
			
			response.getWriter().printf("Success registering user");
		}
		else {
			response.getWriter().println(success);
			response.getWriter().println("Error registering user");
		}
	}
}
