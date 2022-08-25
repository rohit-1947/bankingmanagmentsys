<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.obms.model.User"%>
<%@page import="com.obms.model.Transaction"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%
if (session.getAttribute("userid") == null) {
	response.sendRedirect("/");
}
%>
<%@include file="navbar.jsp"%>
<head>
<title>Admin- User details</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
body {
	font: 400 15px Lato, sans-serif;
	line-height: 1.8;
	color: #818181;
}

.jumbotron {
	background-color: #f4511e;
	color: #fff;
	padding: 100px 25px;
	font-family: Montserrat, sans-serif;
}

.container-fluid {
	padding: 60px 50px;
}

.bg-grey {
	background-color: #f6f6f6;
}
#ram{
display:none;
background-color: #f6f6f6;}
#myNavbar a {
  color: black;
  padding: 14px 20px;
  text-decoration: none;
  display: block;
}
#ram a:hover {background-color: #ddd;}
#reg:hover #ram {display: block;}
.navbar #myNavbar{
  position: absolute;
  right: 0;
  left: auto;
}
#home{
padding-right:20px;
}

</style>
</head>

<body>
	<div class="jumbotron text-center">
		<h1>ONLINE BANKING</h1>
		<h3>View All Users</h3>
	</div>
	<%
	List<User> list = (List<User>) request.getAttribute("allusers");
	%>
			<div  class="container-fluid">
				<h3 class="text-center">VIEW ALL USERS</h3>
				<table class="table table-striped">
				<caption>Users Details</caption>
					<thead class="thead-light">
						<tr>
							<th scope="col">ID</th>
							<th scope="col">AADHAR PROOF</th>
							<th scope="col">ADDRESS</th>
							<th scope="col">EMAIL</th>
							<th scope="col">NAME</th>
							<th scope="col">PHONE</th>
							<th scope="col">ROLE</th>
							<th scope="col">STATE</th>
							<th scope="col">ACCOUNT NUMBER</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (User t : list) {
						%>
						<tr>
							<td><%=t.getId()%></td>
							<td><%=t.getAadharproof()%></td>
							<td><%=t.getAddress()%></td>
							<td><%=t.getEmail()%></td>
							<td><%=t.getName()%></td>
							<td><%=t.getPhone()%></td>
							<td><%=t.getRole()%></td>
							<td><%=t.getState()%></td>
							<td><%=t.getAccount().getAccno()%></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<footer class="container-fluid text-center">
		<a href="#myPage" title="To Top"> <span
			class="glyphicon glyphicon-chevron-up"></span>
		</a>
		<p>Online Banking</p>
	</footer>



</body>

</html>