<%@ page import="java.sql.*" %>
<%
    // KEEP THIS EXACT JAVA CODE
    String msg = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://caboose.proxy.rlwy.net:26818/railway",
                "postgres", "BrhPaWAOXpWOYCwYtgFQvszsbOgeLfpw"
            );

            PreparedStatement stmt = conn.prepareStatement(
                "SELECT p.Description FROM Contact c JOIN Profile p ON p.Contact_ID = c.id WHERE c.email = ? AND p.password = ?"
            );
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                session.setAttribute("userEmail", email);
                session.setAttribute("userDescription", rs.getString("Description"));
                response.sendRedirect("home.jsp");
                return;
            } else {
                msg = "Invalid email or password.";
            }

            conn.close();
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
            font-family: 'Poppins', sans-serif;
        }

        body {
            min-height: 100vh;
            
            display: flex;
        }

        .container {
            display: flex;
            width: 100%;
            min-height: 100vh;
            backdrop-filter: blur(5px);
        }

        .hero-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.1);
        }

        .hero-image {
            max-width: 500px;
            width: 80%;
            filter: drop-shadow(0 10px 20px rgba(0, 0, 0, 0.2));
            animation: float 3s ease-in-out infinite;
        }

        .login-section {
            flex: 1;
            background: rgba(255, 255, 255, 0.95);
            padding: 4rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            box-shadow: -20px 0 40px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 2.5rem;
            color: #2d3436;
            margin-bottom: 2rem;
            margin-left:7.4rem ;
            font-weight: 600;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        input {
            padding: 1rem 1.5rem;
            border: 2px solid #eee;
            border-radius: 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #ff8a00;
            box-shadow: 0 0 0 4px rgba(255, 138, 0, 0.1);
        }

        button {
            padding: 1rem 2rem;
            background: linear-gradient(45deg, #ff8a00, #ff6b6b);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 138, 0, 0.3);
        }

        .signup {
            margin-left: 9rem;
            margin-top: 2rem;
            color: #666;
        }

        .signup a {
            color: #ff8a00;
            font-weight: 600;
            text-decoration: none;
        }

        .error-message {
            padding: 1rem;
            background: #ffe3e3;
            color: #dc3545;
            border-radius: 10px;
            border: 1px solid #ffc9c9;
            animation: bounceIn 0.5s ease;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        @keyframes bounceIn {
            0% { transform: scale(0.9); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .hero-section {
                padding: 4rem 2rem;
            }

            .login-section {
                padding: 2rem;
                box-shadow: 0 -10px 30px rgba(0, 0, 0, 0.1);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="hero-section">
            <img src="Logo-removebg-preview.png" alt="App Logo" class="hero-image">
        </div>

        <div class="login-section">
            <h1>Welcome Back</h1>
            <form method="POST">
                <input type="email" name="email" placeholder="Email Address" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit">Login</button>
                
                <% if (!msg.isEmpty()) { %>
                    <div class="error-message"><%= msg %></div>
                <% } %>
            </form>
            <div class="signup">
                Don't have an account? <a href="createAccount.jsp">Sign up</a>
            </div>
        </div>
    </div>
</body>
</html>