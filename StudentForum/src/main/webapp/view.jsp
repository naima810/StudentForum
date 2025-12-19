<%@ page import="java.sql.*, java.util.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    boolean isLoggedIn = (userId != null);

    String searchQuery = request.getParameter("q");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Explore Questions - Student Forum</title>
<link rel="stylesheet" href="view.css">
</head>
<body>

<!-- Side-bar -->
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

<!-- Search Form -->
<form method="get" action="view.jsp" class="search-box">
    <input type="text" name="q" placeholder="Search questions..." value="<%= searchQuery != null ? searchQuery : "" %>">
    <button type="submit">Search</button>
</form>

<!-- Ask Question Button -->
<a href="javascript:void(0)"
   class="ask-btn"
   onclick="requireLogin(event, <%= isLoggedIn %>, 'ask-question.jsp')">

    <span class="ask-label">Ask Question</span>
    <span class="ask-icon">+</span>
</a>

<div class="question-list">

<%
    // DB connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum","root","");

    String query = "SELECT q.id AS question_id, q.question_text, q.category, q.created_at, " +
                   "u.name AS author_name, COUNT(a.id) AS total_answers " +
                   "FROM questions q " +
                   "JOIN users u ON q.user_id = u.id " +
                   "LEFT JOIN answers a ON a.question_id = q.id ";

    if(searchQuery != null && !searchQuery.trim().isEmpty()) {
        query += "WHERE q.question_text LIKE ? OR q.category LIKE ? ";
    }

    query += "GROUP BY q.id, q.question_text, q.category, q.created_at, u.name " +
             "ORDER BY q.created_at DESC";

    PreparedStatement ps = conn.prepareStatement(query);

    if(searchQuery != null && !searchQuery.trim().isEmpty()) {
        String likeQuery = "%" + searchQuery.trim() + "%";
        ps.setString(1, likeQuery);
        ps.setString(2, likeQuery);
    }

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
    rs.close();
    ps.close();
    conn.close();
%>

</div>

<!-- Login Modal -->
<div id="loginModal" class="modal">
    <div class="modal-box">
        <h3>Login Required</h3>
        <p>You need to log in to ask a question.</p>

        <div class="modal-actions">
            <%
                String currentURL = request.getRequestURI();
                String queryString = request.getQueryString();
                if(queryString != null){
                    currentURL += "?" + queryString;
                }
                String redirectURL = java.net.URLEncoder.encode(currentURL, "UTF-8");
            %>

            <a href="login1.html?redirect=<%= redirectURL %>" class="login-btn">Login</a>
            <button class="cancel-btn" onclick="closeLoginModal()">Cancel</button>
        </div>
    </div>
</div>

</main>
<script src="login-modal.js"></script>
</body>
</html>
