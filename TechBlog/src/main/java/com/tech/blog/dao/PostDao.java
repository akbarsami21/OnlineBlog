package com.tech.blog.dao;

import java.sql.*;
import com.tech.blog.entities.*;
import java.util.*;

public class PostDao {
	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public ArrayList<Category> getAllCatergories() {
		ArrayList<Category> list = new ArrayList<>();

		try {
			String q = "select * from categories";
			Statement st = this.con.createStatement();
			ResultSet set = st.executeQuery(q);
			while (set.next()) {
				int cid = set.getInt("cid");
				String name = set.getString("name");
				String description = set.getString("description");
				Category c = new Category(cid, name, description);
				list.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean savePost(Post p) {
		boolean f = false;
		try {
			String q = "insert into post(pTittle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(q);
			pstmt.setString(1, p.getpTittle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());

			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<Post> getAllPost() {
		List<Post> list = new ArrayList<>();

		try {
			PreparedStatement pstmt = con.prepareStatement("select * from post order by pid desc");
			ResultSet set = pstmt.executeQuery();
			while (set.next()) {

				int pid = set.getInt("pid");
				String pTittle = set.getString("pTittle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp pDate = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");

				Post post = new Post(pid, pTittle, pContent, pCode, pPic, pDate, catId, userId);
				list.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Post> getPostByCatId(int catId) {
		List<Post> list = new ArrayList<>();

		try {
			PreparedStatement pstmt = con.prepareStatement("select * from post where catId=?");
			pstmt.setInt(1, catId);
			ResultSet set = pstmt.executeQuery();
			while (set.next()) {

				int pid = set.getInt("pid");
				String pTittle = set.getString("pTittle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp pDate = set.getTimestamp("pDate");
				int userId = set.getInt("userId");

				Post post = new Post(pid, pTittle, pContent, pCode, pPic, pDate, catId, userId);
				list.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Post getPostByPostId(int postId) {
		Post post = null;
		String q = "select * from post where pid=?";
		try {
			PreparedStatement pstmt = this.con.prepareStatement(q);
			pstmt.setInt(1, postId);
			ResultSet set = pstmt.executeQuery();

			if (set.next()) {
				int pid = set.getInt("pid");
				String pTittle = set.getString("pTittle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp pDate = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");

				 post = new Post(pid, pTittle, pContent, pCode, pPic, pDate, catId, userId);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}

}
