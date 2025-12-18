 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us | Student Forum</title>

    <!-- Existing common CSS (navbar, layout, theme) -->
    <link rel="stylesheet" href="Aboutus.css">

</head>
<body>
     <header class="topbar">
        <div class="logo">Student Forum</div>
        <nav class="topnav">
            <a href="Aboutus.jsp">About Us</a>
            <a href="complaint.jsp">Complaint</a>
            <a href="contact.jsp">Contact</a>
        </nav>
            <div class="topbar-profile">
        <% String userName = (String) session.getAttribute("userName"); %>
        	<p>Hello,<% if(userName==null){%>
        		<p>User</p>
        	<%}
        	else{  %>
        		<p><%=userName%></p>
        		<%} %>
        	
        	<div class="topbar-profile-pic"></div>
            </div>
        </header>

        <div class="container">
        <aside class="sidebar">
            <a href="forum.jsp" class="active">Home</a>
            <a href="view.jsp">Explore Questions</a>
            <a href="query.jsp">My Queries</a>
            <a href="myanswers.jsp">My Answers</a>
            <a href="settings.jsp">Settings</a>
        </aside>


    <!-- ================= MAIN CONTENT ================= -->
    <main class="main-content">
        <div class="about-container">
            <h1>About <span>Student Forum</span></h1>

            <p>
                Student Forum is an interactive platform built to support students
                in learning through collaboration. It provides a common space where
                students can ask questions, explore existing discussions, and share
                knowledge with others.
            </p>

            <p>
                Our platform allows students to post their queries, reply to questions,
                and actively participate in discussions. With features like
                <b>My Queries</b> and <b>My Answers</b>, users can easily track their
                contributions and stay organized.
            </p>

            <p>
                Student Forum encourages peer-to-peer learning by connecting students,
                promoting curiosity, and creating a supportive academic community.
            </p>

            <div class="features">
                <div class="feature-box">
                    <h3>Explore Questions</h3>
                    <p>Browse questions asked by students across various topics.</p>
                </div>

                <div class="feature-box">
                    <h3>Ask & Reply</h3>
                    <p>Post your own questions and help others by replying.</p>
                </div>

                <div class="feature-box">
                    <h3>My Queries</h3>
                    <p>View and manage all the questions you have asked.</p>
                </div>

                <div class="feature-box">
                    <h3>My Answers</h3>
                    <p>Keep track of all answers you have submitted.</p>
                </div>
            </div>
            <section class="about-extra">
    <h2>Why Student Forum Matters</h2>
    <p>
        In todays fast-paced academic world, students often struggle to find the right guidance, solutions, and support.
        Student Forum bridges that gap by providing a reliable platform for shared knowledge, instant communication,
        and collaborative learning. Students are not limited to textbooks,they learn from real discussions, real
        problems, and real students.
    </p>

    <h2>Community Driven Approach</h2>
    <p>
        Student Forum is built on the foundation of teamwork. Every question asked has the potential to help not just
        one student, but many others dealing with the same challenges. Every answer strengthens the community and makes
        learning easier and more productive for others.
    </p>

    <ul class="benefits-list">
        <li> Learn faster through shared knowledge and answers</li>
        <li> Build confidence by asking and solving questions</li>
        <li> Stay organized using tracking features</li>
        <li> Connect with like-minded students</li>
        <li> Improve academic and problem-solving skills</li>
    </ul>

    <h2>Our Vision</h2>
    <p>
        Our vision is to create a digital learning ecosystem that inspires curiosity, builds knowledge, and
        connects students beyond classrooms. We aim to grow Student Forum into a nationwide platform transforming
        education through shared intelligence and strong collaboration.
    </p>

    <h2>Our Future Goal</h2>
    <p>
        We plan to integrate advanced features like instant notifications, subject-wise filtering, and expert-verified
        answers to enhance reliability and accessibility. Student Forum will continue evolving as students evolve.
    </p>
   
</section>
            

    <footer class="page-footer">
     &copy;Copyrights 2025 Reserved to KN.
     </footer>
     </main>
</body>
</html>