<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.bank.models.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vertex Bank | User Profile</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/style.css">

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

    .navbar-brand .logo-img {
      height: 50px;
      width: auto;
      max-width: 180px;
      object-fit: contain;
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

<%
  User user = (User) request.getAttribute("user");
  if (user == null) {
      user = (User) session.getAttribute("user");
  }
  if (user == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  String success = (String) request.getAttribute("success");
  String error = (String) request.getAttribute("error");
%>

  <!-- ===== NAVBAR ===== -->
  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
      <a class="navbar-brand" href="index.jsp"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item"><a class="nav-link" href="Dashboard">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link active" href="profile">Profile</a></li>
          <li class="nav-item"><a class="nav-link" href="settings">Settings</a></li>
          <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- ===== PROFILE HEADER ===== -->
  <section class="profile-header">
    <h1>Welcome, <%= (user.getFullName() != null && !user.getFullName().isEmpty()) ? user.getFullName() : user.getUsername() %> 👋</h1>
    <p>Manage your profile, security settings, and contact information.</p>
  </section>

  <!-- ===== PROFILE CONTENT ===== -->
  <div class="container">
    <div class="profile-card shadow-lg">

      <% if (success != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
          <i class="bi bi-check-circle-fill me-1"></i> <%= success %>
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      <% } %>

      <% if (error != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-1"></i> <%= error %>
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      <% } %>

      <div class="row g-4">
        <!-- Left Column -->
        <div class="col-md-5">
          <div class="info-card">
            <p class="info-label mb-1">Full Name</p>
            <h5><%= user.getFullName() != null ? user.getFullName() : "Not provided" %></h5>

            <p class="info-label mb-1 mt-3">Username</p>
            <p><%= user.getUsername() %></p>

            <p class="info-label mb-1 mt-3">Email</p>
            <p><%= user.getEmail() != null ? user.getEmail() : "Not provided" %></p>

            <p class="info-label mb-1 mt-3">Phone</p>
            <p><%= user.getPhone() != null ? user.getPhone() : "Not provided" %></p>

            <p class="info-label mb-1 mt-3">Address</p>
            <p><%= user.getAddress() != null ? user.getAddress() : "Add your address to stay updated" %></p>
          </div>

          <div class="info-card">
            <p class="info-label mb-1">Account Status</p>
            <span class="badge <%= "ACTIVE".equalsIgnoreCase(user.getStatus()) ? "bg-success" : "bg-warning" %>">
              <%= user.getStatus() %>
            </span>

            <p class="info-label mb-1 mt-3">Role</p>
            <span class="badge bg-primary"><%= user.getRole() %></span>

            <hr>
            <p class="mb-2">Need to fine-tune notifications or security?</p>
            <a href="settings" class="btn btn-primary-custom w-100">Open Settings</a>
          </div>
        </div>

        <!-- Right Column: Forms -->
        <div class="col-md-7">
          <h3 class="section-title">Update Contact Info</h3>
          <form action="profile" method="post" class="mb-5">
            <input type="hidden" name="action" value="contact">
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="fullName" class="form-label fw-semibold">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName"
                       value="<%= user.getFullName() != null ? user.getFullName() : "" %>" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="email" class="form-label fw-semibold">Email</label>
                <input type="email" class="form-control" id="email" name="email"
                       value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="phone" class="form-label fw-semibold">Phone Number</label>
                <input type="text" class="form-control" id="phone" name="phone"
                       value="<%= user.getPhone() != null ? user.getPhone() : "" %>" required>
              </div>
              <div class="col-12 mb-3">
                <label for="address" class="form-label fw-semibold">Mailing Address</label>
                <textarea class="form-control" id="address" name="address" rows="3"
                          placeholder="Apartment, Street, City, Country"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
              </div>
            </div>
            <button type="submit" class="btn btn-primary-custom">Save Changes</button>
          </form>

          <h3 class="section-title">Reset Password</h3>
          <form action="profile" method="post">
            <input type="hidden" name="action" value="password">
            <div class="mb-3">
              <label for="currentPassword" class="form-label fw-semibold">Current Password</label>
              <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
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
