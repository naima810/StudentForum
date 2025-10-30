<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login1.html?error=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Forum - Home</title>
    <link rel="stylesheet" href="forum.css">
</head>
<body>
    <header class="topbar">
        <div class="logo">Student Forum</div>
        <nav class="topnav">
            <a href="about.jsp">About Us</a>
            <a href="complaint.jsp">Complaint</a>
            <a href="contact.jsp">Contact</a>
        </nav>
        <div class="topbar-profile">
        	<p>Hello, name!</p>
        	<div class="topbar-profile-pic"></div>
        </div>
  <!--      
  		<div class="topbar-search">
        	<input type="text" placeholder="Enter to search...">
        	<input type="submit" class="topbar-search-btn">
        </div>
         -->
    </header>

    <div class="container">
        <aside class="sidebar">
            <a href="home.jsp" class="active">Home</a>
            <a href="forum-feed.jsp">Explore Questions</a>
            <a href="myQueries.jsp">My Queries</a>
            <a href="myAnswers.jsp">My Answers</a>
            <a href="settings.jsp">Settings</a>
        </aside>

        <main class="content">
		<div class="hero">
    		<div class="hero-content">
        		<h1>Welcome to <span class="highlight">Student Forum</span></h1>
        		<p>Your space to <strong>ask questions</strong>, <strong>share answers</strong>, and <span class="soft-highlight">grow together</span>.</p>
        		<p class="subtext">Manage your queries, track discussions, and connect with curious minds.</p>
        	<div class="hero-btns">
        		<button class="join">Join Us</button>
        		<button class="forum-btn">Explore Community</button>
        	</div>
    		</div>
		</div>
		<section class="features">
  			<div class="feature-card card-blue">
    			  <div class="vertical-text">ASK QUESTIONS</div>
  			</div>

 			 <div class="feature-card card-cyan">
  				  <div class="vertical-text">VOTE THE ANSWERS</div>
    				<div class="feature-image">
    		</div>
  		</div>

  		<div class="feature-card card-yellow">
  		  <div class="vertical-text">ANSWER QUESTIONS</div>
    		<div class="feature-image">
    	</div>
  		</div>

		</section>
		
		<section class="content-img-sec">
			<div class="content-img">
			</div>
			<div class="img-content">
			  	<h1>Connect. Learn. Grow Together.</h1>
  				<p>Join students from every field sharing ideas, solving doubts, and helping each other succeed. This is your space to ask, discuss, and discover what you’ve been missing.</p>
  				<button>Ask a Question</button>
			</div>
		</section>
		
          <section class="cards-sec">
          <h1>Discover Our Diverse Community</h1>
          <div class="cards">
                <div class="card">
                    <p>Computer Science</p>
                </div>
                <div class="card">
                    <p>Data structures & Algorithms</p>
                </div>
                <div class="card">
                    <p>Dynamic Programming</p>
                </div>
                <div class="card">
                    <p>Object Oriented Programming</p>
                </div>
                <div class="card">
                    <p>Computer Architecture</p>
                </div>
                <div class="card">
                    <p>Database Management</p>
                </div>
                </div>
            </section> 
            
            <footer>
    &copy;Copyrights 2025 Reserved to KN.    </footer>
        </main>
        
    </div>
    
</body>
</html>
