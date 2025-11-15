<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vertex Bank | Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(to right, #0b1220, #1e3a8a);
      color: #e2e8f0;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .login-container {
      background-color: #fff;
      color: #1e293b;
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
      width: 100%;
      max-width: 420px;
    }

    .login-container h2 {
      font-weight: 700;
      margin-bottom: 25px;
      color: #1e3a8a;
    }

    .btn-primary {
      background-color: #2563eb;
      border: none;
    }

    .btn-primary:hover {
      background-color: #1d4ed8;
    }

    a {
      text-decoration: none;
      color: #2563eb;
    }

    a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body>
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
        <a href="#">Forgot password?</a>
      </div>

      <button type="submit" class="btn btn-primary w-100 py-2">Login</button>
    </form>

    <p class="mt-4 mb-0">Don't have an account? <a href="signup.jsp">Sign up</a></p>
    <a href="index.jsp" class="d-block mt-3">← Back to Home</a>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
