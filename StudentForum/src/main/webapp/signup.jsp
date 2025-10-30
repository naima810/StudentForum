<%@ page import="java.sql.*" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (name != null && email != null && password != null && 
        !name.isEmpty() && !email.isEmpty() && !password.isEmpty()) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentforum", "root", ""); // <-- dummy DB name

            // Check if user already exists
            String checkSql = "SELECT * FROM users WHERE email = ?";
            ps = con.prepareStatement(checkSql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Email already registered
                response.sendRedirect("signup1.html?error=email_exists");
            } else {
                // Insert new user
                ps.close();
                String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password); // not hashed for demo

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("login1.html?success=registered");
                } else {
                    response.sendRedirect("signup1.html?error=failed");
                }
            }

        } catch (Exception e) {
            // Optional: print detailed error during testing
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (con != null) try { con.close(); } catch (Exception ignored) {}
        }
    } else {
        response.sendRedirect("signup1.html?error=empty");
    }
%>
