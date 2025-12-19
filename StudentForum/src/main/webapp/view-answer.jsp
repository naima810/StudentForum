<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    int questionId = 0;
    if(request.getParameter("questionId") != null){
        questionId = Integer.parseInt(request.getParameter("questionId"));
    }

    // DB connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum","root","");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Question - Student Forum</title>
<link rel="stylesheet" href="view-answer.css">
</head>
<body>

<aside class="sidebar">
    <h2 class="logo">Student Forum</h2>
    <ul>
        <li><a href="view.jsp">Home</a></li>
        <li class="active"><a href="view.jsp">Explore Questions</a></li>
        <li><a href="query.jsp">My Queries</a></li>
        <li><a href="answers.jsp">My Answers</a></li>
        <li><a href="settings.jsp">Settings</a></li>
    </ul>
</aside>

<main class="content">
<div class="content-area">
    <h2 class="page-title">Question & Answers</h2>

<!-- Fetch Question -->
<div class="question-box">
<%
    String qQuery = "SELECT q.id AS question_id, q.question_text, q.category, q.description, q.image_path, q.created_at, u.name AS author_name " +
                    "FROM questions q JOIN users u ON q.user_id = u.id WHERE q.id = ?";
    PreparedStatement psQ = conn.prepareStatement(qQuery);
    psQ.setInt(1, questionId);
    ResultSet rsQ = psQ.executeQuery();
    if(rsQ.next()) {
%>
    <div class="q-meta-top">
        <span class="q-id">Question ID : <%= rsQ.getInt("question_id") %></span>
        <span class="q-author"><%= rsQ.getString("author_name") %></span>
    </div>

    
    <h3 class="question-title"><%= rsQ.getString("question_text") %></h3>
    <p class="question-desc"><%= rsQ.getString("description") %></p>

    <% 
        String imgPath = rsQ.getString("image_path"); 
        if(imgPath != null && !imgPath.isEmpty()){ %>
           <img src="<%= imgPath %>" alt="Question Image" class="question-image">
    <% } %>

    <div class="q-meta-bottom">
    	<span class="tag"><%= rsQ.getString("category") %></span>
        <span class="q-date"><%= rsQ.getDate("created_at") %></span>
    </div>
<%
    } else { out.println("<p>Question not found!</p>"); }
    rsQ.close(); psQ.close();
%>
</div>

<!-- Fetch Answers -->
<h3 class="answers-heading">All Answers</h3>
<%
String aQuery = "SELECT a.id AS answer_id, a.answer_text, a.created_at, u.name AS author_name " +
                "FROM answers a JOIN users u ON a.user_id = u.id " +
                "WHERE a.question_id = ? ORDER BY a.created_at ASC";
PreparedStatement psA = conn.prepareStatement(aQuery);
psA.setInt(1, questionId);
ResultSet rsA = psA.executeQuery();
boolean found = false;
while(rsA.next()){
	found = true;
%>
<div class="answer-box">
    <div class="answer-meta-top">
        <span class="answer-author"><%= rsA.getString("author_name") %></span>
    </div>
    <p class="answer-text"><%= rsA.getString("answer_text") %></p>
    <div class="answer-meta-bottom">
        <span class="answer-date"><%= rsA.getDate("created_at") %></span>
    </div>
</div>
<%
}
if(!found){
	%>
	<p class="no-answers">There has been no answers yet. Be the first to answer.</p>
<%
}
rsA.close(); psA.close();
%>


    <!-- Add Answer Form -->
    <h3 class="answers-heading">Write Your Answer</h3>
    <form  class="answer-form" action="submit-answer.jsp" method="post" onsubmit="return requireLogin(event, <%= (session.getAttribute("userId") != null) %>)">
    <input type="hidden" name="questionId" value="<%= questionId %>">
    <textarea name="answerText" placeholder="Write your answer..." required></textarea>
    <button type="submit" class="submit-btn" data-loggedin="<%= (session.getAttribute("userId") != null) %>">Post Answer</button>
</form>


</div>
<div id="loginModal" class="modal">
    <div class="modal-box">
        <h3>Login Required</h3>
        <p>You need to log in to post an answer.</p>
        <div class="modal-actions">
        <%
    // Get the current page URL with query string
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

<%
    conn.close();
%>
<script src="login-modal.js"></script>

</body>
</html>
