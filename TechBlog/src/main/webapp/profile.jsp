
<%@page import="com.tech.blog.helper.*"%>
<%@page import="com.tech.blog.entities.*"%>
<%@page import="com.tech.blog.dao.*"%>
<%@page import="java.util.*"%>
<%@page errorPage="errorPage.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");

if (user == null) {
	response.sendRedirect("loginPage.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>profile</title>
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

body{
background:url("img/bg1.jpg");
background-size:cover;
background-attachment:fixed;
}
</style>
</head>
<body>

	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="profile.jsp"><span
			class="fa fa-star-half-empty"></span>iFISH</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="profile.jsp"><span
						class="fa fa-home"></span> Home <span class="sr-only">(current)</span>
				</a></li>

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
	<%
	Message m = (Message) session.getAttribute("msg");
	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%>" role="alert">
		<%=m.getContent()%></div>
	<%
	session.removeAttribute("msg");
	}
	%>


	<!-- main body of the page -->

	<main>
		<div class="container">
			<div class="row">
				<!-- first col -->
				<div class="col-md-4 mt-4">
					<!-- categories -->
					<div class="list-group">
						<a href="#" onclick="getPosts(0,this)"
							class=" c-link list-group-item list-group-item-action active"> All
							Posts </a>
						<%
						PostDao pd = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> list1 = pd.getAllCatergories();
						for (Category cc : list1) {
						%>
						<a href="#" onclick="getPosts(<%=cc.getCid()%>,this)"
							class=" c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
						<%
						}
						%>

					</div>
				</div>
				<!-- second col -->
				<div class="col-md-8">
					<!-- posts -->
					<div class="container text-center mt-3" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					<div class="container-fluid" id="post-container"></div>
				</div>

			</div>


		</div>

	</main>

	<!--end  main body of the page -->

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
	<script>
		$(document).ready(function() {
			let editStatus = false;

			$('#edit-profile-button').click(function() {

				if (editStatus == false) {

					$("#profile-details").hide()
					$("#profile-edit").show()
					editStatus = true;
					$(this).text("Back")
				} else {

					$("#profile-details").show()
					$("#profile-edit").hide()
					editStatus = false;
					$(this).text("Edit")
				}
			})

		});
	</script>

	<!-- now add post js -->
<script>
            $(document).ready(function (e) {
                //
                $("#add-post-form").on("submit", function (event) {
                    //this code gets called when form is submitted....
                    event.preventDefault();
                    console.log("you have clicked on submit..")
                    let form = new FormData(this);
                    //now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success ..
                            console.log(data);
                            if (data.trim() == 'done')
                            {
                                swal("Good job!", "saved successfully", "success");
                            } else
                            {
                                swal("Error!!", "Something went wrong try again...", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error..
                            swal("Error!!", "Something went wrong try again...", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>

	<!-- loading post using ajax -->
	<script>
	
	function getPosts(catId,temp){
		$("#loader").show();
		$("#post-container").hide();
		
		$(".c-link").removeClass('active')
		$.ajax({
			url : "LoadPosts.jsp",
			data: {cid: catId},
			success : function(data, textStatus, jqXHR) {
				console.log(data)
				$("#loader").hide();
				$("#post-container").show();
				$('#post-container').html(data)
				$(temp).addClass('active')
			}

		})
		
	}
		$(document).ready(function(e) {
			let allPostRef=$('.c-link')[0]
			getPosts(0,allPostRef)
		})
	</script>

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
			},
			error:function(jqXHR,textStatus,errorThrown){
			console.log(data)	
			}
		 })
		}
		
		</script>
</body>
</html>