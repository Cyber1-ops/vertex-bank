<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vertex Bank | Sign Up</title>
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

    .signup-container {
      background-color: #fff;
      color: #1e293b;
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
      width: 100%;
      max-width: 480px;
    }

    .signup-container h2 {
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
  <div class="signup-container">
    <h2 class="text-center">Create Account</h2>
    <p class="text-center text-muted mb-4">Join Vertex Bank in just a few steps</p>

    <form action="signup" method="post">
      <div class="mb-3">
        <label for="fullname" class="form-label">Full Name</label>
        <input type="text" class="form-control" id="fullname" placeholder="John Doe" name="name" required>
      </div>
      
        <div class="mb-3">
        <label for="fullname" class="form-label">Username</label>
        <input type="text" class="form-control" id="fullname" placeholder="John Doe" name="username" required>
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">Email address</label>
        <input type="email" name="email" class="form-control" id="email" placeholder="you@example.com" required>
      </div>

      <div class="mb-3">
        <label for="phone" class="form-label">Phone Number</label>
        <input type="tel" name ="tel" class="form-control" id="phone" placeholder="+971 50 123 4567" required>
      </div>

      <div class="mb-3">
        <label for="password" class="form-label">Create Password</label>
        <input type="password" name="pass" class="form-control" id="password" placeholder="********" required>
      </div>

      <div class="mb-4">
        <label for="confirm" class="form-label">Confirm Password</label>
        <input type="password" class="form-control" id="confirm" placeholder="********" required>
      </div>

      <button type="submit" class="btn btn-primary w-100 py-2">Create Account</button>
    </form>

    <p class="text-center mt-4 mb-0">Already have an account? <a href="login.html">Login</a></p>
    <p class="text-center"><a href="home.html">← Back to Home</a></p>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
