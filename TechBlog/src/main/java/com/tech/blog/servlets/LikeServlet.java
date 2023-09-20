package com.tech.blog.servlets;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;
public class LikeServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		String operation=req.getParameter("operation");
		int uid=Integer.parseInt(req.getParameter("uid"));
		int pid=Integer.parseInt(req.getParameter("pid"));
		//out.println(operation);
		//out.println(uid);
		//out.println(pid);
		LikeDao dao=new LikeDao(ConnectionProvider.getConnection());
		if(operation.equals("like")) {
			boolean f=dao.insertLike(pid, uid);
			out.println(f);
		}
	}

}
