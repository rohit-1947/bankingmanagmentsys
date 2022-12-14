<%@page import="com.obms.model.RaiseTicket"%>
<%@page import="com.obms.model.Account"%>
<%@page import="com.obms.model.User"%>
<%@page import="java.util.List"%>
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
<title>Admin-Show all Query</title>
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
</style>
</head>

<body>

	<div class="jumbotron text-center">
		<h1>ONLINE BANKING</h1>
		<h3>View All Tickets</h3>
	</div>

	<div class="container-fluid">
		<br />
		<table class="table table-striped">
		<caption>Query Details</caption>
			<thead>
				<tr>
					<th>Query ID</th>
					<th>User ID</th>
					<th>Email ID</th>
					<th>Name</th>
					<th>Date</th>
					<th>status</th>
					<th>query</th>
				</tr>
			</thead>
			<tbody>
				<%
				List<RaiseTicket> list = (List<RaiseTicket>) request.getAttribute("querylist");
				for (RaiseTicket u : list) {
				%>
				<tr>
					<td><%=u.getId()%></td>
					<td><%=u.getUser().getId()%></td>
					<td><%=u.getUser().getEmail()%></td>
					<td><%=u.getUser().getName()%></td>
					<td><%=u.getDateTime()%></td>
					<td><%=u.getStatus()%></td>
					<td><%=u.getQuery()%></td>
					<td><a href="/viewdetail?id=<%=u.getUser().getId()%>"
						type="button" class="btn btn-info">View Details</a></td>
					<%
					if (!u.getStatus().equals("complete")) {
					%>
					<td><a
						onclick="if(confirm('Are you sure you have resolved the issue <%=u.getId()%>'))
						{window.location.href='/status?id=<%=u.getId()%>'}"
						type="button" class="btn btn-danger"> Complete</a></td>
					<%
					}
					%>
				</tr>
				<%
				}
				%>
			</tbody>

		</table>
	</div>

	<footer class="container-fluid text-center">
		<a href="#myPage" title="To Top"> <span
			class="glyphicon glyphicon-chevron-up"></span>
		</a>
		<p>Online Banking</p>
	</footer>

</body>

</html>