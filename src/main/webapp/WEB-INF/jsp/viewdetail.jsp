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

.container-fluid {
	padding: 60px 50px;
}
.jumbotron {
	background-color: #f4511e;
	color: #fff;
	padding: 100px 25px;
	font-family: Montserrat, sans-serif;
}

.bg-grey {
	background-color: #f6f6f6;
}
</style>
</head>

<body id="myPage" data-spy="scroll" data-target=".navbar"
	data-offset="60">
	<%
	User user = (User) request.getAttribute("userdetail");
	List<Transaction> list = (List<Transaction>) request.getAttribute("usertransac");
	%>
	<div class="jumbotron text-center">
		<h1>VIEW DETAILS</h1>
	</div>
		<div class="row">
			<div class="col-md-4 shadow-lg">
				<h3 class="text-center">USER DETAILS</h3>
				<table class="table">
				<caption>User Details</caption>
					<tbody>
						<tr>
							<td><h5>
									<strong>User ID:</strong>
								</h5></td>
							<td><%=user.getId()%>
						</tr>
						<tr>
							<td><h5>
									<strong>Name:</strong>
								</h5></td>
							<td><%=user.getName()%></td>
						</tr>
						<tr>
							<td><h5>
									<strong>Acc No.:</strong>
								</h5></td>
							<td><%=user.getAccount().getAccno()%></td>
						</tr>
						<tr>
							<td><h5>
									<strong>IFSC:</strong>
								</h5></td>
							<td><%=user.getAccount().getIfsc()%></td>
						</tr>
						<tr>
							<td><h5>
									<strong>BAL:</strong>
								</h5></td>
							<td>Rs.<%=user.getAccount().getBal()%>/-
							</td>
						</tr>
						<tr>
							<td><h5>
									<strong>Address:</strong>
								</h5></td>
							<td><%=user.getAddress()%></td>
						</tr>
						<tr>
							<td><h5>
									<strong>State:</strong>
								</h5></td>
							<td><%=user.getState()%></td>
						</tr>
						<tr>
							<td><h5>
									<strong>Email:</strong>
								</h5></td>
							<td><%=user.getEmail()%></td>
						</tr>
						<tr>
							<td><h5>
									<strong>Phone:</strong>
								</h5></td>
							<td><%=user.getPhone()%></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-md-8 shadow-lg">
				<h3 class="text-center">TRANSACTIONS</h3>
				<table class="table">
				<caption>Transaction Details</caption>
					<thead class="thead-light">
						<tr>
							<th scope="col">ID</th>
							<th scope="col">FROM</th>
							<th scope="col">TO</th>
							<th scope="col">MODE</th>
							<th scope="col">TYPE</th>
							<th scope="col">DATE</th>
							<th scope="col">AMOUNT</th>
						</tr>
					</thead>
					<tbody>
						<%
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/YYYY hh:mm:ss");
						for (Transaction t : list) {
						%>
						<tr>
							<td><%=t.getId()%></td>
							<td><%=t.getFrom()%></td>
							<td><%=t.getTo()%></td>
							<td><%=t.getMode()%></td>
							<td><%=t.getType()%></td>
							<td><%=t.getDate().format(formatter)%></td>
							<td><%=t.getAmount()%></td>
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