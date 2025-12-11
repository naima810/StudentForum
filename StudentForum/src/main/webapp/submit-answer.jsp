<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    // Get form data
    int questionId = Integer.parseInt(request.getParameter("questionId"));
    String answerText = request.getParameter("answerText");

    // Get logged-in user ID from session
    Integer userId = (Integer) session.getAttribute("userId");
    if(userId == null){
        response.sendRedirect("login.jsp"); // redirect if not logged in
        return;
    }

    // Insert into answers table
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum","root","");
        
        String insertQuery = "INSERT INTO answers (question_id, user_id, answer_text, created_at) VALUES (?, ?, ?, NOW())";
        PreparedStatement ps = conn.prepareStatement(insertQuery);
        ps.setInt(1, questionId);
        ps.setInt(2, userId);
        ps.setString(3, answerText);

        ps.executeUpdate();

        ps.close();
        conn.close();

        // Redirect back to the question page
        response.sendRedirect("view-answer.jsp?questionId=" + questionId);

    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>
