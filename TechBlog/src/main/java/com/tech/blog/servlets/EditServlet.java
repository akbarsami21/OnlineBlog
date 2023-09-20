package com.tech.blog.servlets;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@MultipartConfig
public class EditServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();

		// fetch all data form edit profile form
		String userName = req.getParameter("user_name");
		String userPassword = req.getParameter("user_password");
		String userEmail = req.getParameter("user_email");
		String userAbout = req.getParameter("user_about");
		Part part = req.getPart("image");
		String imageName = part.getSubmittedFileName();

		// get the user form the session

		HttpSession s = req.getSession();
		User user = (User) s.getAttribute("currentUser");
		user.setEmail(userEmail);
		user.setName(userName);
		user.setPassword(userPassword);
		user.setAbout(userAbout);
		String oldFile = user.getProfile();
		user.setProfile(imageName);

		// update database
		UserDao u = new UserDao(ConnectionProvider.getConnection());

		boolean ans = u.updateUser(user);

		if (ans) {
			// out.println("<h1>Updated</h1>");
			String path = req.getRealPath("/") + "pics" + File.separator + user.getProfile();
			// delete pic
			String pathOldFile = req.getRealPath("/") + "pics" + File.separator + oldFile;
			if (!oldFile.equals("default.png"))
				Helper.deleteFile(pathOldFile);
			if (Helper.saveFile(part.getInputStream(), path)) {
				Message msg = new Message("Profile Details Updated", "success", "alert-success ");
				;
				s.setAttribute("msg", msg);
			} else {
				Message msg = new Message("Something Went Wrong!!", "error", "alert-primary ");
				s.setAttribute("msg", msg);
			}

		} else {
			Message msg = new Message("Something Went Wrong!!", "error", "alert-primary ");
			s.setAttribute("msg", msg);
		}
		resp.sendRedirect("profile.jsp");

	}

}
