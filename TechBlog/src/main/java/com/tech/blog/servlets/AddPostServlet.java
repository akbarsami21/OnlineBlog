package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
@MultipartConfig
public class AddPostServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		int cid=Integer.parseInt(req.getParameter("cid"));
		String pTittle=req.getParameter("pTittle");
		String pContent=req.getParameter("pContent");
		String pCode=req.getParameter("pCode");
		Part part=req.getPart("pic");
		
		//getting current user id
		HttpSession session=req.getSession();
		User user=(User) session.getAttribute("currentUser");
		out.println("Your Tittle: "+pTittle);
		out.println(part.getSubmittedFileName());
		
		Post p=new Post(pTittle,pContent,pCode,part.getSubmittedFileName(),null,cid, user.getId());
	PostDao pd=new PostDao(ConnectionProvider.getConnection());
	if (pd.savePost(p)) {

        String path = req.getRealPath("/") + "img" + File.separator + part.getSubmittedFileName();
        Helper.saveFile(part.getInputStream(), path);
        out.println("done");
    } else {
        out.println("error");
    }
	}

}
