<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Queries - Student Forum</title>
    <link rel="stylesheet" href="query.css">
</head>
<body>

<!-- -------------- LEFT SIDEBAR ---------------- -->
<aside class="sidebar">
    <h2 class="logo">Student Forum</h2>
    <ul>
        <li><a href="forum.jsp">Home</a></li>
        <li class="active"><a href="view.jsp">Explore Questions</a></li>
        <li  class="active"><a href="query.jsp">My Queries</a></li>
        <li><a href="myanswers.jsp">My Answers</a></li>
        <li><a href="settings.jsp">Settings</a></li>
    </ul>
</aside>

<!-- -------------- MAIN CONTENT ---------------- -->
<main class="content">

    <h1>My Queries</h1>
    <p class="subtitle">All questions you have asked in the community</p>

    <div class="queries-box">

        <%  
            // --- Backend Logic Using Session ID ---
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
        %>
                <p class="error">You are not logged in! <a href="login1.html">Login Here</a></p>
        <%
            } else {

                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum", "root", "");

                    String query = "SELECT * FROM questions WHERE user_id = ? ORDER BY created_at DESC";
                    pst = con.prepareStatement(query);
                    pst.setInt(1, userId);
                    rs = pst.executeQuery();

                    boolean found = false;

                    while (rs.next()) {
                        found = true;
        %>

                        <!-- -------------- INDIVIDUAL QUESTION CARD ---------------- -->
                        <div class="question-card">
                            <h2><%= rs.getString("question_text") %></h2>
                            <p class="category">Category: <%= rs.getString("category") %></p>
                            <p class="desc"><%= rs.getString("description") %></p>
                            <p class="date">Posted on: <%= rs.getString("created_at") %></p>
                        </div>

        <%
                    }

                    if (!found) {
        %>
                        <p class="no-queries">You have not posted any queries yet.</p>
        <%
                    }

                } catch (Exception e) {
                    out.print("<p class='error'>Error: " + e.getMessage() + "</p>");
                }
            } 
        %>

    </div>
</main>

</body>
</html>