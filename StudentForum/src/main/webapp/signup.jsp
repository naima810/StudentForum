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
	<form action="signup" method="post">
	<h1>Signup Page</h1>
		<label for="name">Name: </label>
		<input type="text" name="name" placeholder="Enter your name...">
		<label for="email">Email: </label>
		<input type="email" name="email" placeholder="Enter your email..."/>
		<label for="password: ">Password: </label>
		<input type="password" name="password" placeholder="Password..."/>
		<input type="submit" class="button"/>
	</form>
</body>
</html>