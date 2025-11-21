<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vertex Bank | Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark py-2">
    <div class="container-fluid">
        <a class="navbar-brand" href="Dashboard"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="Support.jsp"><i class="bi bi-headset"></i> Support</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card p-4">
                <div class="login-container text-center">
                    <h2>Welcome Back</h2>
                    <p class="text-muted mb-4">Sign in to access your Vertex Bank account</p>

                    <form action="login" method="post">
                        <div class="mb-3 text-start">
                            <label for="email" class="form-label">Email address</label>
                            <input type="email" class="form-control" id="email" name= "email" placeholder="you@example.com" required>
                        </div>

                        <div class="mb-3 text-start">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" name="pass" class="form-control" id="password" placeholder="********" required>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="remember">
                                <label class="form-check-label" for="remember">Remember me</label>
                            </div>
                            <a href="Support.jsp#contact">Forgot password?</a>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2">Login</button>
                    </form>
                    <%
                        String message = (String) request.getAttribute("message");
                        if(message != null && !message.trim().isEmpty()) {
                            out.print("<div class='alert alert-info'>" + message + "</div>");
                        }
                    %>
                    <p class="mt-4 mb-0">Don't have an account? <a href="signup.jsp">Sign up</a></p>
                    <a href="index.jsp" class="d-block mt-3">← Back to Home</a>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
