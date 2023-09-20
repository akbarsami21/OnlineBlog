
<%@page import="com.tech.blog.helper.*"%>
<%@page import="com.tech.blog.entities.*"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page errorPage="errorPage.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%
User user = (User) session.getAttribute("currentUser");

if (user == null) {
	response.sendRedirect("loginPage.jsp");
}
%>
<%
int postId = Integer.parseInt(request.getParameter("postId"));
PostDao d = new PostDao(ConnectionProvider.getConnection());
Post p = d.getPostByPostId(postId);
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=p.getpTittle()%></title>

<!--css-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<style>
.banner-background {
	clip-path: polygon(50% 0%, 100% 0, 100% 95%, 60% 99%, 25% 96%, 0 100%, 0 0);
}

.post-tittle {
	font-weight: 100;
	font-size: 25px;
}

.post-content {
	font-weight: 100;
	font-size: 20px;
}

.post-date {
	font-style: italic;
	font-weight: bold;
}

.post-user-info {
	font-size: 20px;
}

.row-user {
	border: 1px solid #e2e2e2;
	padding-top: 15px;
}

body {
	background: url("img/bg1.jpg");
	background-size: cover;
	background-attachment: fixed;
}
</style>


</head>
<body>


	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href=profile.jsp><span
			class="fa fa-star-half-empty"></span>iFISH</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="profile.jsp"><span class="fa fa-home"></span> Home <span
						class="sr-only">(current)</span> </a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="fa fa-check-square"></span>
						Categories </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Java Programming</a> <a
							class="dropdown-item" href="#">Python Programming</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">WebTechnology</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Database Programming</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-user"></span> Contact</a></li>

				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#add-post-modal"><span
						class="fa fa-universal-access"></span> Post</a></li>


			</ul>
			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-modal"><span
						class="fa fa-user-circle"></span> <%=user.getName()%></a></li>

				<li class="nav-item"><a class="nav-link" href="LogOutServlet"><span
						class="fa fa-sign-out"></span> LogOut</a></li>

			</ul>
		</div>
	</nav>
	<!-- end of navbar -->

	<!-- main content of the body -->

	<div class="container">
		<div class="row my-4">
			<div class="col-md-8 offset-md-2">

				<div class="card">
					<div class="card-header bg-dark text-white">
						<h4 class="post-tittle"><%=p.getpTittle()%></h4>


					</div>
					<div class="card-body">
						<img class="card-img-top my-2" src="img/<%=p.getpPic()%>"
							alt="Card image cap">

						<div class="row my-2 row-user">
							<div class="col-md-8">
								<%
								UserDao ud = new UserDao(ConnectionProvider.getConnection());
								%>
								<p class="post-user-info">
									<a href="#!"><%=ud.getUserByUserId(p.getUserId()).getName()%></a>
									has posted
								</p>
							</div>

							<div class="col-md-4">
								<p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
							</div>
						</div>

						<p class="post-content"><%=p.getpContent()%></p>
						<br> <br>
						<div class="post-code">
							<pre><%=p.getpCode()%></pre>
						</div>

					</div>
					<div class="card-footer text-center">
						<%
						LikeDao dao = new LikeDao(ConnectionProvider.getConnection());
						%>
						<a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)"
							class="btn btn-outline-primary btn-sm"><i
							class="fa fa-thumbs-o-up "></i><span class="like-counter"><%=dao.countLikeOnPost(p.getPid())%></span></a>
						<a href="#!" class="btn btn-outline-primary btn-sm"><i
							class="fa fa-commenting-o "></i><span>20</span></a>



					</div>
					<div class="card-footer">
						<div class="fb-comments"
							data-href="http://localhost:8080/TechBlog/showPost.jsp?postId=<%=p.getPid()%>"
							data-width="" data-numposts="5"></div>

					</div>
				</div>
			</div>


		</div>


	</div>




	<!-- end of main content of the body -->

	<!-- profilemodal -->

	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">iFISH</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 150px;">

						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
						<br>

						<!-- Details -->
						<div id="profile-details">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">ID:</th>
										<th scope="col"><%=user.getId()%></th>

									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row">Name :</th>
										<td><%=user.getName()%></td>

									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>

									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>

									</tr>
									<tr>
										<th scope="row">Registered On :</th>
										<td><%=user.getDateTime().toString()%></td>

									</tr>
								</tbody>
							</table>
						</div>


						<!-- profile-edit -->
						<div id="profile-edit" style="display: none">

							<h3 class="mt-2">Edit CareFully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">

								<table class="table">
									<tr>
										<td>ID:</td>
										<td><%=user.getId()%></td>
									</tr>

									<tr>
										<td>Email:</td>
										<td><input type="email" class="form-control"
											name="user_email" value=<%=user.getEmail()%>></td>
									</tr>


									<tr>
										<td>Name:</td>
										<td><input type="text" name="user_name"
											class="form-control" value=<%=user.getName()%>></td>
									</tr>

									<tr>
										<td>Password:</td>
										<td><input type="password" name="user_password"
											class="form-control" value=<%=user.getPassword()%>></td>
									</tr>

									<tr>
										<td>Gender:</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>

									<tr>
										<td>About:</td>
										<td><textarea rows="2" cols="" class="form-control"
												name="user_about"><%=user.getAbout()%></textarea></td>
									</tr>

									<tr>
										<td>New Profile:</td>
										<td><input type="file" name="image" class="form-control"></td>
									</tr>
								</table>
								<div class="container">
									<button type="submit" class="btn btn-info">Save</button>

								</div>
							</form>
						</div>

					</div>


				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- add post modal -->
	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Post Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="post"
						class="">
						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>---Select Category---</option>
								<%
								PostDao postd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postd.getAllCatergories();
								for (Category c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>

						</div>
						<div class="form-group">
							<input name="pTittle" type="text" placeholder="Enter Tittle"
								class="form-control">

						</div>

						<div class="form-group">
							<textarea name="pContent" class="form-control"
								placeholder="Enter Your Content" style="height: 200px;"></textarea>

						</div>

						<div class="form-group">
							<textarea name="pCode" class="form-control"
								placeholder="Enter Your Code (if any)" style="height: 200px;"></textarea>

						</div>

						<div class="form-group">
							<label>Select Your Pic</label><br> <input type="file"
								name="pic">

						</div>
						<div class="container text-center">
							<button type="submit" class="btn btn-info">Post</button>

						</div>
					</form>

				</div>

			</div>
		</div>
	</div>
	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"
		integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script type="text/javascript"></script>

	<script>
		function doLike(pid,uid){
			
		 const d={
				 
				 uid:uid,
		 pid:pid,
		 operation:'like'
		 }
		 $.ajax({
			
			url:"LikeServlet",
			data: d,
			success:function(data,textStatus,jqXHR){
				
				console.log(data)
				if(data.trim()=='true'){
					let c=$(".like-counter").html();
					c++;
					$('.like-counter').html(c);
				}
			},
			error:function(jqXHR,textStatus,errorThrown){
			console.log(data)	
			}
		 })
		}
		
		</script>



</body>
</html>