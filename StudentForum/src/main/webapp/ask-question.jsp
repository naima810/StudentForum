<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ask Question - Student Forum</title>
<link rel="stylesheet" href="ask-question.css">
</head>
<body>

<aside class="sidebar">
    <h2 class="logo">Student Forum</h2>
    <nav>
        <a href="forum.jsp">Home</a>
        <a href="view.jsp">Explore Questions</a>
        <a href="queries.jsp">My Queries</a>
        <a href="answers.jsp">My Answers</a>
        <a href="settings.jsp">Settings</a>
    </nav>
</aside>

<main class="main-content">
<h1>Ask a Question</h1>
<p class="subtitle">Be clear and specific to get the best answers.</p>

<%
    // Get session userId
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("login1.html?error=unauthorized");
        return;
    }

    // Check if POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String questionTitle = request.getParameter("question_title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/studentforum","root","");

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO questions (user_id, question_text, category, description, created_at) VALUES (?, ?, ?, ?, NOW())"
            );

            ps.setInt(1, userId);
            ps.setString(2, questionTitle);
            ps.setString(3, category);
            ps.setString(4, description);

            ps.executeUpdate();
            ps.close();
            conn.close();
			response.sendRedirect("view.jsp");
            out.println("<p style='color:green;'>Question added successfully!</p>");
			

        } catch(Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<!-- The Form -->
<form class="question-form" method="post" action="ask-question.jsp">
    <label>Question Title</label>
    <input type="text" name="question_title" placeholder="Your question here..." required>

    <label>Category/Tag</label>
    <input type="text" name="category" placeholder="e.g., Java, Web Dev" required>

    <label>Description</label>
    <textarea name="description" placeholder="Describe your problem in detail..." required></textarea>

    <button type="submit" class="submit-btn">Submit Question</button>
</form>

</main>
</body>
</html>
