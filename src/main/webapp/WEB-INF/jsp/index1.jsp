<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Online Banking</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
body {
	font: 400 15px Lato, sans-serif;
	line-height: 1.8;
	color: #818181;
	margin: 0;
	padding: 0;
	font-family: poppins;
	background: url("https://i.postimg.cc/ZnWtB7jg/2.jpg");
	-webkit-background-size: cover;
	background-size: cover;
	background-position: center center;
	background-repeat: no-repeat;
	height: 100vh;
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


<body data-spy="scroll" data-target=".navbar" data-offset="60">

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
				<ul class="nav navbar-nav navbar-right" id="navi">
				<%
				if (session.getAttribute("userid") == null) {
				%>
					<li id="reg"><a href="/signup">Register</i></a></li>
					<li id="home" class="active"><a href="/">HOME</a></li>
					<%
				}
					else if (String.valueOf(session.getAttribute("role")).equals("USER")) {
					%>
					<li><a href="/dashboard">CHECK BALANCE</a></li>
					<li><a href="/fundtransfer">FUND TRANSFER</a></li>
					<li><a href="/upitransfer">UPI</a></li>
					<li><a href="/loan">LOAN</a></li>
					<li><a href="/passbook">PASSBOOK</a></li>
					<li><a href="/profile">PROFILE</a></li>
					<li><a
						onclick="if(confirm('Are you sure you want to log out')){window.location.href='/logout'}">LOGOUT</a></li>
					<%
					}else if (String.valueOf(session.getAttribute("role")).equals("ADMIN")) {
					%>
					<li><a href="/showall">MANAGE USERS</a></li>
					<li class="active"><a href="/getallquery">MANAGE QUERY</a></li>
					<li><a href="/adminloan">VIEW LOAN APPLICATIONS</a></li>
					<li><a href="/adminprofile">PROFILE</a></li>
					<%
					}else
					{
					%>
					<li><a href="/Managerdashboard">Home</a></li>
					<li class="active" id="reg"><a href="/loan">Loan</a>
					<ul>
					<li class="active" id="ram"><a href="/AcceptedLoans">Accepted Loans</a></li>
					<li class="active" id="ram"><a href="/PendingLoans">Pending Loans</a></li>
					</ul></li>
					<li class="active" id="reg"><a href="/Tickets">Tickets</a>
					<ul>
					<li class="active" id="ram"><a href="/SolvedTickets">Solved Tickets</a></li>
					<li class="active" id="ram"><a href="/PendingTickets">Pending Loans</a></li>
					</ul></li>
					<li><a href="/profile">PROFILE</a></li>
					<li><a
						onclick="if(confirm('Are you sure you want to log out')){window.location.href='/logout'}">LOGOUT</a></li>
					<%} %>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container-fluid">
		<%
		if (session.getAttribute("userid") == null) {
		%>
		<div class="row">
			<div class="col-md-6 text-center">
				<h3>LOGIN TO YOUR ACCOUNT</h3>
				<br />
				<form action="/login" method="POST" onsubmit="return captcha()"
					style="background-color: white;">
					<div class="form-group">
						<input class="form-control" type="text" name="username"
							placeholder="Login Email" required />
					</div>
					<div class="form-group">
						<input class="form-control" type="password" name="password"
							placeholder="Password" required />
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <a class="text-center"
						onclick="alert('Visit your nearest bank branch to reset your password')">Forgot
						Password</a> <br /> 
						<input type="submit" onclick="capthcha()"
						class="btn btn-success" />
				</form>
			</div>
		<%
		} else {
		%>
		<div>
			<h1>Transfer Funds, Withdraw Funds, Receive Funds, Check Balance
				from comfort of your home</h1>
		</div>
		<%
		}
		%>
	</div>
	</div>

	<script type="text/javascript">
		function captcha() {
			var n1 = Math.floor(Math.random() * 10);
			var n2 = Math.floor(Math.random() * 10);
			var result = parseInt(prompt("Enter the Result for verification: "
					+ n1 + " + " + n2));
			if (result == (n1 + n2)) {
				return true;
			} else {
				alert("Verification failed!! Try Again!");
				return false;
			}
		}

		function validate() {
			var emailregex = /^\w+([\.-]?\w+)@\w+([\.-]?\w+)(\.\w{2,3})+$/;
			var x = document.getElementById("email").value;
			if (document.getElementById("phone").value.length == 10
					&& document.getElementById("address").value.length >= 5
					&& document.getElementById("password").value.length >= 8
					&& document.getElementById("aadharproof").value.length == 12
					&& document.getElementById("pin").value.length == 4
					&& document.getElementById("name").value.length >= 3) {
				if (x.match(emailregex)) {
					if(prompt(" Please enter the 4 digit pin again.") == 
						document.getElementById("pin").value.trim()){
						
						var n1 = Math.floor(Math.random() * 10) + 1;
						var n2 = Math.floor(Math.random() * 10) + 1;
						var result = parseInt(prompt("Enter the Result for verification: "
								+ n1 + " + " + n2 + " = "));
						if (result == (n1 + n2)) {
							alert("Registration Successfull ! Now you can Login");
							return true;
						} else {
							alert("Verification failed!! Try Again!");
							return false;
						}
					}else{
						alert("Pin do not match try again");
						return false;
					}

				} else {
					alert("Invalid Form Data");
					return false;
				}
			} else {
				alert("Invalid Form Data");
				return false;
			}

		}
	</script>

	<footer class="container-fluid text-center">
		<a href="/" title="To Top"> <span
			class="glyphicon glyphicon-chevron-up"></span>
		</a>
		<p>Online Banking</p>
	</footer>
</body>
</html>