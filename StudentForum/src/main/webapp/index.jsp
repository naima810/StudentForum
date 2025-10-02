<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Forum</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
	<nav>
		<div class="logo-set">
		<img class="logo" src="studentforum-logo.png">
		<p>Student Forum
		</div>
		<button class="login-button">Login</button>
		<h1>Hello github</h1>
		<p>So much tension setting up git</p>
	</nav>
	<form action="signup" method="post">
		<label for="name">Name : </label>
		<input type="text" name="name"/><br/>
		<label for="email">Email : </label>
		<input type="text" name="email"/>
		<label for="password">Password : </label>
		<input type="password" name="password"/><br/>
		<input type = "submit"/>
	</form>
</body>
</html>