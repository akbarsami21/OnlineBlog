package com.tech.blog.servlets;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.*;
import java.sql.*;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();

		// fetch data from form
		String check = req.getParameter("check");

		if (check == null) {
			out.println("Box Not Checked");
		} else {
			String name = req.getParameter("user_name");
			String email = req.getParameter("user_email");
			String password = req.getParameter("user_password");
			String gender = req.getParameter("gender");
			String about = req.getParameter("about");

			// create userdao object to add jdbc
			UserDao dao = new UserDao(ConnectionProvider.getConnection());

			// value add in database
			User user = new User(name, email, password, gender, about);
			if (dao.saveUser(user)) {
				out.println("done");
			} else {
				out.println("error");
			}
		}
	}

}
