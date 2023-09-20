package com.tech.blog.servlets;

import java.io.*;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

public class LogInServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		//fetch from login page email and password
		String UserEmail=req.getParameter("email");
		String userPassword=req.getParameter("password");
	
	    UserDao dao=new UserDao(ConnectionProvider.getConnection());
	   User u= dao.getUserByEmailAndPassword(UserEmail, userPassword);
	   if(u==null) {
		   //out.println("Invalid Details. Try Again!!");
		   
		   Message msg=new Message("Invalid Details. Try Again!!","error","alert-primary ");
	      HttpSession s=req.getSession();
	      s.setAttribute("msg", msg);
		   resp.sendRedirect("loginPage.jsp");
	   
	   }else {
		   
		   HttpSession s=req.getSession();
		   s.setAttribute("currentUser", u);
			resp.sendRedirect("profile.jsp");
	   }
	}

}
