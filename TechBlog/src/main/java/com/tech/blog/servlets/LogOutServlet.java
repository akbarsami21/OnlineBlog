package com.tech.blog.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.sql.*;

import com.tech.blog.entities.Message;

public class LogOutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		HttpSession s = req.getSession();
		s.removeAttribute("currentUser");

		Message m = new Message("Log Out SuccessFully", "success", "alert-success");
		s.setAttribute("msg", m);
		resp.sendRedirect("loginPage.jsp");
	}

}
