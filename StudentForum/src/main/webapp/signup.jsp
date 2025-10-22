<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="signup.css">
</head>
<body>

<%
String passwordType = "password";
%>

<div class="outer-div">
	
	<div class="form-div">
	<form class="inner-div" action="signup" method="post">
	<div>
	<h1>Register Your Account</h1><hr class="hr"/>
	</div>
		<div class="input">
		<label for="name">Name: </label>
		<input type="text" name="name" placeholder="Enter your name...">
		</div>
		<div class="input">
		<label for="email">Email: </label>
		<input type="email" name="email" placeholder="Enter your email..."/>
		</div>
		<div class="input">
		<label for="password: ">Password: </label>
		<input type="<%= passwordType %>" name="password" placeholder="Password...">
		</div>
		<input class="submit-btn" type="submit" class="button"/>
		<a href="/StudentForum/login.jsp">Already have an account? Log in</a>
	</form>
	</div>
	<div class="img-div"></div>
</div>
</body>
</html>