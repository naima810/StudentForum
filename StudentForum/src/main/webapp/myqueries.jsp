<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Questions - Student Forum</title>
<link rel="stylesheet" href="myqueries.css">
</head>
<body>

<aside class="sidebar">
    <h2 class="logo">Student Forum</h2>
    <nav>
        <a href="forum.jsp">Home</a>
        <a href="view.jsp">Explore Questions</a>
        <a href="myqueries.jsp">My Queries</a>
        <a href="answers.jsp">My Answers</a>
        <a href="settings.jsp">Settings</a>
    </nav>
</aside>

<main class="main-content">
<h1>My Questions</h1>

<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if(userId == null){
        out.println("<p style='color:red;'>Please log in to see your questions.</p>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/studentforum","root","");
            
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM questions WHERE user_id=? ORDER BY created_at DESC"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                String questionTitle = rs.getString("question_text");
                String category = rs.getString("category");
                String description = rs.getString("description");
                Timestamp createdAt = rs.getTimestamp("created_at");
%>
    <div class="question-card" style="background:white; padding:20px; border-radius:12px; margin-bottom:20px; box-shadow:0px 3px 12px rgba(0,0,0,0.08);">
        <h3><%= questionTitle %></h3>
        <p><strong>Category:</strong> <%= category %></p>
        <p><strong>Asked on:</strong> <%= createdAt %></p>
        <p><%= description %></p>
    </div>
<%
            }

            rs.close();
            ps.close();
            conn.close();
        } catch(Exception e){
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

</main>
</body>
</html>
