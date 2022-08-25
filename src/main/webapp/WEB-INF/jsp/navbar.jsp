<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false" errorPage="error.jsp"%>
<!DOCTYPE html>
<html lang="en">

<%
if (session.getAttribute("userid") == null) {
	response.sendRedirect("/");
}
%>
<head>
<title>Dashboard</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
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
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand">Online Banking</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<%
					if (session.getAttribute("userid") == null) {
					%>
					<li id="reg"><a href="/signup">Register</a></li>
					<li id="home" class="active"><a href="/">HOME</a></li>
					
					<%
					}
					else if (String.valueOf(session.getAttribute("role")).equals("ADMIN"))
					{
					%>
					<li><a href="/AdminDashboard">HOME</a></li>
					<li id="reg"><a href="/showall">MANAGE USERS  <i class="fa fa-caret-down"></i></a>
					<ul>
					<li id="ram"><a data-toggle="modal" data-target="#add-user-modal"
			data-ticket-type="premium-access">Add Users</a></li>
					<li id="ram"><a data-toggle="modal" data-target="#add-manager-modal"
			data-ticket-type="premium-access">Add Managers</a></li>
					<li id="ram"><a href="/showall">View All</a></li>
					</ul></li>
					<li id="reg"><a>TICKETS  <i class="fa fa-caret-down"></i></a>
					<ul>
					<li id="ram"><a href="/SolvedTickets">Solved Tickets</a></li>
					<li id="ram"><a href="/PendingTickets">Pending Tickets</a></li>
					</ul></li>
					<li><a href="/adminloan">VIEW LOAN APPLICATIONS</a></li>
					<li><a href="/getAllTransactions">TRANSACTIONS</a></li>
					<li><a href="/adminprofile">PROFILE</a></li>
					<li><a
						onclick="if(confirm('Are you sure you want to log out')){window.location.href='/logout';}">LOGOUT</a></li>
					<%
					}
					else
					{
					%>
					<li><a href="/dashboard">CHECK BALANCE</a></li>
					<li><a href="/fundtransfer">FUND TRANSFER</a></li>
					<li><a href="/upitransfer">UPI</a></li>
					<li><a href="/loan">LOAN</a></li>
					<li><a href="/passbook">PASSBOOK</a></li>
					<li><a href="/profile">PROFILE</a></li>
					<li><a onclick="if(confirm('Are you sure you want to log out')){window.location.href='/logout';}">LOGOUT</a></li>	
					<%
					}
					%>			
				</ul>
			</div>
		</div>
	</nav>
	<!--user Model  Start-->
	<div id="add-user-modal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h2 align="center" class="modal-title">ADD USER</h2>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>


				<div class="modal-body ">
						<div class="container-fluid">
			<div class="col-md-12 text-center">
				<h3>CREATE A NEW ACCOUNT INSTANTLY</h3>
				<br/>
				<form action="/register" method="post" onsubmit="return validate()"
					style="background-color: white;">
					<div class="form-group">
						<input class="form-control" type="hidden" name="role"
							id="role" value="USER"/>
							<input class="form-control" type="hidden" name="acctype"
							id="acctype" value="SAVINGS"/>
					</div>
					<div class="form-group">
						<input class="form-control" type="email" name="email" id="email"
							placeholder="Email" required />
					</div>
					<div class="form-group">
						<input class="form-control" type="text" name="name" id="name"
							placeholder="Name (Greater than 3 characters)" required />
					</div>
					<div class="form-group">
						<input class="form-control" type="tel" name="phone" id="phone"
							placeholder="Phone" required />
					</div>
					<div class="form-group">
						<select class="form-control" name="state" id="state" required>
							<option value="Jharkhand">Jharkhand</option>
							<option value="West Bengal">West Bengal</option>
							<option value="Orissa">Orissa</option>
							<option value="Andhra Pradesh">Andhra Pradesh</option>
						</select>
					</div>
					<div class="form-group">
						<input class="form-control" type="text" name="address"
							id="address" placeholder="Address (Greater than 6 characters)"
							required />
					</div>
					<div class="form-group">
						<input class="form-control" type="number" name="aadharproof"
							id="aadharproof" placeholder="Aadhar ID (12 digits)" required />
					</div>
					<div class="form-group">
						<input class="form-control" type="password" name="pin" id="pin"
							placeholder="Create a 4 digit PIN " required />
					</div>
					<div class="form-group">
						<input class="form-control" type="password" name="password"
							id="password"
							placeholder="Password (Min 8 characters, at least 1 lowercase and uppercase letter and one digit)"
							required />
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit"
						class="btn btn-success" value="REGISTER" />
				</form>
				</div>
				</div>
			</div>

			</div>
		</div>
	</div>
	<!--Manager Model  Start-->
	
	<div id="add-manager-modal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h2 align="center" class="modal-title">ADD MANAGER</h2>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>


				<div class="modal-body ">
						<div class="container-fluid">
			<div class="col-md-12 text-center">
				<h3>CREATE A NEW ACCOUNT INSTANTLY</h3>
				<br/>
				<form action="/register" method="post" onsubmit="return validate()"
					style="background-color: white;">
					<div class="form-group">
						<input class="form-control" type="hidden" name="role"
							id="role" value="MANAGER"/>
							<input class="form-control" type="hidden" name="acctype"
							id="acctype" value="NONE_M"/>
					</div>
					<div class="form-group">
						<input class="form-control" type="email" name="email" id="email"
							placeholder="Email" required />
					</div>
					<div class="form-group">
						<input class="form-control" type="text" name="name" id="name"
							placeholder="Name (Greater than 3 characters)" required />
					</div>
					<div class="form-group">
						<input class="form-control" type="tel" name="phone" id="phone"
							placeholder="Phone" required />
					</div>
					<div class="form-group">
						<select class="form-control" name="state" id="state" required>
							<option value="Jharkhand">Jharkhand</option>
							<option value="West Bengal">West Bengal</option>
							<option value="Orissa">Orissa</option>
							<option value="Andhra Pradesh">Andhra Pradesh</option>
						</select>
					</div>
					<div class="form-group">
						<input class="form-control" type="text" name="address"
							id="address" placeholder="Address (Greater than 6 characters)"
							required />
					</div>
					<div class="form-group">
						<input class="form-control" type="number" name="aadharproof"
							id="aadharproof" placeholder="Aadhar ID (12 digits)" required />
					</div>
					<div class="form-group">
						<input class="form-control" type="password" name="pin" id="pin"
							placeholder="Create a 4 digit PIN " required />
					</div>
					<div class="form-group">
						<input class="form-control" type="password" name="password"
							id="password"
							placeholder="Password (Min 8 characters, at least 1 lowercase and uppercase letter and one digit)"
							required />
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit"
						class="btn btn-success" value="REGISTER" />
				</form>
				</div>
				</div>
	</div>

			</div>
		</div>
	</div>
	

</body>


</html>