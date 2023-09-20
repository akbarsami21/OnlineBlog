package com.tech.blog.dao;

import java.sql.*;
import com.tech.blog.entities.User;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	// method to insert user to database

	public boolean saveUser(User user) {

		boolean f = false;
		try {
			// user to database

			String query = "insert into userinfo(name,email,password,gender,about) values(?,?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());

			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// get user by username & password

	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;
		try {
			String query = "select * from userinfo where email=? and password=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet set = pstmt.executeQuery();

			if (set.next()) {
				user = new User();

				// data from database
				String name = set.getString("name");
				user.setName(name);
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	
	public boolean updateUser(User user) {
		boolean f=false;
		try {
			
			String q="update userinfo set name=?, email=?, password=?, gender=? ,about=?, profile=? where id=?";
			PreparedStatement pstmt=con.prepareStatement(q);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			pstmt.setString(6, user.getProfile());
			pstmt.setInt   (7, user.getId());
			
			pstmt.executeUpdate();
			f=true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	public User getUserByUserId(int id) {
		User user=null;
		
		try {
			String q="select * from userinfo where id=?";
			PreparedStatement pstmt=this.con.prepareStatement(q);
			pstmt.setInt(1, id);
			ResultSet set=pstmt.executeQuery();
			if(set.next()) {
				user = new User();

				// data from database
				String name = set.getString("name");
				user.setName(name);
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
}
