<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Explore Questions - Student Forum</title>
<link rel="stylesheet" href="view.css">
<script>
function toggleAnswers(id) {
    var div = document.getElementById("answers-" + id);
    div.style.display = (div.style.display === "none") ? "block" : "none";
}
</script>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <h2 class="logo">Student Forum</h2>
    <ul>
        <li><a href="forum.jsp">Home</a></li>
        <li class="active"><a href="view.jsp">Explore Questions</a></li>
        <li><a href="myqueries.jsp">My Queries</a></li>
        <li><a href="answers.jsp">My Answers</a></li>
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
    // Connect to DB
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum","root","");

    // Fetch questions (most recent first)
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM questions ORDER BY created_at DESC");
    ResultSet rs = ps.executeQuery();

    while(rs.next()) {
        int qid = rs.getInt("id");
        String qtext = rs.getString("question_text");
        String category = rs.getString("category");

        // Fetch answers for this question
        PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM answers WHERE question_id=? ORDER BY created_at ASC");
        ps2.setInt(1, qid);
        ResultSet rs2 = ps2.executeQuery();

        List<String> answers = new ArrayList<>();
        while(rs2.next()){
            answers.add(rs2.getString("answer_text"));
        }
%>
    <div class="question-card">
        <h3 class="q-title"><%= qtext %></h3>
        <div class="q-footer">
            <span class="tag"><%= category %></span>
            <span class="answers"><%= answers.size() %> Answers</span>
           <a href="view-question.jsp?id=<%= rs.getInt("id") %>"> <button>Show Answers</button></a>
        </div>
        <div id="answers-<%= qid %>" style="display:none; margin-top:10px;">
            <% for(String ans : answers){ %>
                <p>A: <%= ans %></p>
            <% } %>
        </div>
    </div>
<%
        rs2.close(); ps2.close();
    }
    rs.close(); ps.close(); conn.close();
%>

</div>
</main>
</body>
</html>
