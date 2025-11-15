<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vertex Bank | User Profile</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
    }

    .navbar {
      background-color: #0b1220;
      padding: 15px 0;
      box-shadow: 0 2px 15px rgba(0, 0, 0, 0.2);
    }

    .navbar-brand {
      font-weight: 700;
      color: #60a5fa !important;
      font-size: 1.5rem;
    }

    .profile-header {
      background: linear-gradient(135deg, #0b1220, #1e3a8a);
      color: white;
      text-align: center;
      padding: 80px 20px;
      position: relative;
    }

    .profile-card {
      background: white;
      border-radius: 15px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
      margin-top: -70px;
      padding: 30px;
    }

    .section-title {
      color: #1e3a8a;
      font-weight: 700;
      margin-bottom: 20px;
    }

    .btn-primary-custom {
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      color: white;
      border: none;
      padding: 10px 25px;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    .btn-primary-custom:hover {
      transform: translateY(-3px);
      box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
    }

    .info-card {
      background: #f0f9ff;
      border-left: 4px solid #2563eb;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
    }

    .info-label {
      font-weight: 600;
      color: #1e3a8a;
    }

    footer {
      background-color: #0b1220;
      color: #cbd5e1;
      padding: 40px 0 20px;
      margin-top: 60px;
    }
  </style>
</head>

<body>

  <!-- ===== NAVBAR ===== -->
  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
      <a class="navbar-brand" href="index.jsp">Vertex Bank</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item"><a class="nav-link" href="Dashboard">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link active" href="userProfile.jsp">Profile</a></li>
          <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- ===== PROFILE HEADER ===== -->
  <section class="profile-header">
    <h1>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %> 👋</h1>
    <p>Manage your profile, security settings, and contact information.</p>
  </section>

  <!-- ===== PROFILE CONTENT ===== -->
  <div class="container">
    <div class="profile-card shadow-lg">
      <div class="row g-4">
       
        <!-- Right Column: Forms -->
        <div class="col-md-7">
          <!-- Update Contact Info -->
          <h3 class="section-title">Update Contact Info</h3>
          <form action="UpdateContactServlet" method="post" class="mb-5">
            <div class="mb-3">
              <label for="email" class="form-label fw-semibold">Email</label>
              <input type="email" class="form-control" id="email" name="email"
                     value="<%= session.getAttribute("email") != null ? session.getAttribute("email") : "" %>" required>
            </div>
            <div class="mb-3">
              <label for="phone" class="form-label fw-semibold">Phone Number</label>
              <input type="text" class="form-control" id="phone" name="phone"
                     value="<%= session.getAttribute("phone") != null ? session.getAttribute("phone") : "" %>" required>
            </div>
            <button type="submit" class="btn btn-primary-custom">Save Changes</button>
          </form>

          <!-- Reset Password -->
          <h3 class="section-title">Reset Password</h3>
          <form action="ResetPasswordServlet" method="post">
            <div class="mb-3">
              <label for="oldPassword" class="form-label fw-semibold">Current Password</label>
              <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
            </div>
            <div class="mb-3">
              <label for="newPassword" class="form-label fw-semibold">New Password</label>
              <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            <div class="mb-3">
              <label for="confirmPassword" class="form-label fw-semibold">Confirm New Password</label>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-primary-custom">Reset Password</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- ===== FOOTER ===== -->
  <footer class="text-center">
    <div class="container">
      <p class="mb-2">&copy; 2025 Vertex Bank. All rights reserved.</p>
      <p class="text-muted"><small>Smart. Secure. Seamless.</small></p>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
