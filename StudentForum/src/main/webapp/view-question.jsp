<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<title>Question Details</title>
<link rel="stylesheet" href="view-question.css">
</head>
<body>

<%
    String qid = request.getParameter("id");
    if (qid == null) {
        out.print("<p style='color:red;'>Invalid question ID</p>");
        return;
    }

    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        out.print("<p style='color:red;'>You must be logged in to answer.</p>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/studentforum","root","");

        // If form submitted (POST)
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String answerText = request.getParameter("answer_text");

            PreparedStatement insert = conn.prepareStatement(
                "INSERT INTO answers (question_id, user_id, answer_text, created_at) VALUES (?, ?, ?, NOW())"
            );
            insert.setInt(1, Integer.parseInt(qid));
            insert.setInt(2, userId);
            insert.setString(3, answerText);
            insert.executeUpdate();
            insert.close();

            response.sendRedirect("view-question.jsp?id=" + qid);
            return;
        }

        // Fetch question
        PreparedStatement qst = conn.prepareStatement(
            "SELECT q.*, u.username FROM questions q JOIN users u ON q.user_id = u.id WHERE q.id = ?"
        );
        qst.setInt(1, Integer.parseInt(qid));
        ResultSet qdata = qst.executeQuery();

        if (!qdata.next()) {
            out.print("<p style='color:red;'>Question not found.</p>");
            return;
        }
%>

<h1><%= qdata.getString("question_text") %></h1>
<p><strong>Category:</strong> <%= qdata.getString("category") %></p>
<p><strong>Description:</strong></p>
<p><%= qdata.getString("description") %></p>
<p><em>Asked by: <%= qdata.getString("username") %></em></p>

<hr>

<h2>Answers</h2>

<%
        // Load answers
        PreparedStatement ast = conn.prepareStatement(
            "SELECT a.*, u.username FROM answers a JOIN users u ON a.user_id = u.id WHERE a.question_id = ? ORDER BY a.created_at DESC"
        );
        ast.setInt(1, Integer.parseInt(qid));
        ResultSet answers = ast.executeQuery();

        while (answers.next()) {
%>

<div style="border:1px solid #ccc; padding:10px; margin:10px 0;">
    <p><%= answers.getString("answer_text") %></p>
    <p><em>Answered by: <%= answers.getString("username") %></em></p>
</div>

<%
        }

        conn.close();
    } catch(Exception e){
        out.print("Error: " + e.getMessage());
    }
%>

<hr>

<h2>Your Answer</h2>

<form method="post">
    <textarea name="answer_text" required placeholder="Write your answer..." style="width:100%; height:120px;"></textarea>
    <button type="submit">Submit Answer</button>
</form>

</body>
</html>
