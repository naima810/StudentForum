<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Explore Questions - Student Forum</title>
<link rel="stylesheet" href="view.css">
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <h2 class="logo">Student Forum</h2>
    <ul>
        <li><a href="forum.jsp">Home</a></li>
        <li class="active"><a href="view.jsp">Explore Questions</a></li>
        <li><a href="query.jsp">My Queries</a></li>
        <li><a href="myanswers.jsp">My Answers</a></li>
        <li><a href="settings.jsp">Settings</a></li>
    </ul>
</aside>

<main class="content">
<h1 class="title">Explore Questions</h1>

<div class="search-box">
    <input type="text" placeholder="Search questions...">
    <button>Search</button>
</div>

<a href="ask-question.jsp"><button class="ques-plus">+</button></a>

<div class="question-list">

<%
    // DB connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum","root","");

    String query = "SELECT q.id AS question_id, q.question_text, q.category, q.created_at, " +
                   "u.name AS author_name, COUNT(a.id) AS total_answers " +
                   "FROM questions q " +
                   "JOIN users u ON q.user_id = u.id " +
                   "LEFT JOIN answers a ON a.question_id = q.id " +
                   "GROUP BY q.id, q.question_text, q.category, q.created_at, u.name " +
                   "ORDER BY q.created_at DESC";

    PreparedStatement ps = conn.prepareStatement(query);
    ResultSet rs = ps.executeQuery();

    while(rs.next()) {
        int qid = rs.getInt("question_id");
        String qtext = rs.getString("question_text");
        String category = rs.getString("category");
        String authorName = rs.getString("author_name");
        Timestamp createdAt = rs.getTimestamp("created_at");
        int totalAnswers = rs.getInt("total_answers");
%>

<div class="question-card">
    <h3 class="q-title"><%= qtext %></h3>
    <p class="q-meta">
        Asked by <span class="q-author"><%= authorName %></span> 
        | Question ID: <span class="q-id"><%= qid %></span> 
        | <span class="q-date"><%= createdAt %></span>
    </p>
    <div class="q-footer">
        <span class="tag"><%= category %></span>
        <span class="answers"><%= totalAnswers %> Answers</span>
        <a href="view-answer.jsp?questionId=<%= qid %>"><button>View Answers</button></a>
    </div>
</div>

    
<%
    }
    rs.close(); ps.close(); conn.close();
%>

</div>
</main>
</body>
</html>
