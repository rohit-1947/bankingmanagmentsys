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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
body {
	font: 400 15px Lato, sans-serif;
	line-height: 1.8;
	color: #818181;
    margin:50px 0px; padding:0px;
    text-align:center;
    align:center;
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
form{
   display: inline-block;
   width:800px;
   text-align:center;
   margin-left:150px;
}
h3
{
width:600px;
margin-left:260px;}
</style>
</head>
<body>
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
					<li class="active"><a href="/">Back To Login</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="jumbotron text-center">
		<h1>ONLINE BANKING</h1>
		<p>Easier way to manage funds from home</p>
	</div>

	<div class="container-fluid">
			<div class="col-md-6 text-center">
				<h3><center>CREATE A NEW ACCOUNT INSTANTLY</center></h3>
				<br />
				<form action="/register" method="post" onsubmit="return validate()"
					style="background-color: white;">
					<div class="form-group">
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
						onclick="capthcha()" class="btn btn-success" value="REGISTER" />
					<p>After Registering you will have to login</p>
				</form>
			</div>
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