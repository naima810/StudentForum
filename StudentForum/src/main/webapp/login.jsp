<%@ page import="java.sql.*" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null && !email.isEmpty() && !password.isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum", "root", ""); // <-- change DB name

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("userName", rs.getString("name"));
                session.setAttribute("userEmail", email);

                response.sendRedirect("forum.jsp"); // redirect to next page
            } else {
                response.sendRedirect("login1.html?error=invalid");
            }

        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (con != null) try { con.close(); } catch (Exception ignored) {}
        }
    } else {
        response.sendRedirect("login.html?error=empty");
    }
%>
