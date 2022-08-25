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
	List<Transaction> list = (List<Transaction>) request.getAttribute("usertransac");
	%>
	
	<div class="jumbotron text-center">
		<h1>ONLINE BANKING</h1>
		<p>View All Transactions</p>
	</div>
			<div  class="container-fluid">
				<h3 class="text-center">TRANSACTIONS</h3>
				<table class="table table-striped">
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