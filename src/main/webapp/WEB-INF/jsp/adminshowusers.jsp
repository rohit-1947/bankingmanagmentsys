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
<title>Admin-Show all users</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
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
.navbar
{
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

<body id="myPage" data-spy="scroll" data-target=".navbar"
	data-offset="60">
	
	<div class="jumbotron text-center">
		<h1>ONLINE BANKING</h1>
		<p>View All Accounts</p>
	</div>

	<div class="container-fluid">
		<form action="/search" method="get">
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="input-group">
						<input type="number" class="form-control"
							placeholder="Search Account Number" name="account" id="account" />
						<div class="input-group-btn">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<button class="btn btn-primary" type="submit">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		<br> <br>
		<a data-toggle="modal" data-target="#credit-amount"
						type="button" class="btn btn-info">Credit Amount</a>
		<a data-toggle="modal" data-target="#debit-amount" type="button" class="btn btn-danger"> Debit Amount</a>
		<table class="table table-striped">
		<caption>Customer Details</caption>
			<thead>
				<tr>
					<th align="center">Account Number</th>
					<th align="center">User ID</th>
					<th>Email ID</th>
					<th>Name</th>
					<th>Account Type</th>
					<th>Account Balance</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
				List<Account> users = (List<Account>) request.getAttribute("all");
				for (Account u : users) {
					if(u.getUser().getRole().equals("USER") || u.getUser().getRole().equals("MANAGER"))
					{
				%>
				<tr>
					<td><%=u.getAccno()%></td>
					<td><%=u.getUser().getId()%></td>
					<td><%=u.getUser().getEmail()%></td>
					<td><%=u.getUser().getName()%></td>
					<td><%=u.getAccType()%></td>
					<td><%=u.getBal()%></td>
					<%if (u.getUser().getRole().equals("USER") || u.getUser().getRole().equals("MANAGER")) {%>
					<td><a href="/viewdetail?id=<%=u.getUser().getId()%>"
						type="button" class="btn btn-info">View Details</a> &nbsp;&nbsp;
						 <a
						onclick="if(confirm('Are you sure to close the account for <%=u.getUser().getName()%>')){window.location.href='/close?id=<%=u.getUser().getId()%>'}"
						type="button" class="btn btn-danger"><em class="fa fa-trash-o fa-lg"></em></a></td>
						<%} %>
				</tr>
				<%
					}
				}
				%>
			</tbody>

		</table>
	</div>
	
	<div id="credit-amount" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title ">Credit Amount</h4>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>


				<div class="modal-body ">
					<form method="POST" action="/credit">
						<div class="form-group">
							<label for="query">Enter Account Number To Credit:</label> 
							<input class="form-control" type="text" name="accno" id="accno"
								required />
							<label for="query">Enter Amount To Credit:</label> 
							<input class="form-control" type="text" name="amount" id="amount"
								required />
						</div>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input type="submit" id="submit" name="submit"
							value="SUBMIT" />
					</form>
				</div>

			</div>
		</div>
	</div>

<div id="debit-amount" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title ">Credit Amount</h4>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>


				<div class="modal-body ">
					<form method="POST" action="/debit">
						<div class="form-group">
							<label for="query">Enter Account Number To Debit:</label> 
							<input class="form-control" type="text" name="accno" id="accno"
								required />
							<label for="query">Enter Amount To Debit:</label> 
							<input class="form-control" type="text" name="amount" id="amount"
								required />
						</div>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input type="submit" id="submit" name="submit"
							value="SUBMIT" />
					</form>
				</div>

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