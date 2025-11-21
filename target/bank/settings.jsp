<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="com.bank.models.User, com.bank.models.UserSettings" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserSettings settings = (UserSettings) request.getAttribute("settings");
    if (settings == null) {
        settings = (UserSettings) session.getAttribute("userSettings");
        if (settings == null) {
            settings = new com.bank.models.UserSettings();
        }
    }

    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Account Settings | Vertex Bank</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
    }
    .navbar { background-color: #0b1220; }
    .navbar-brand { color: #60a5fa !important; font-weight: 700; }
    .settings-section {
      background: white;
      border-radius: 15px;
      padding: 25px;
      box-shadow: 0 10px 30px rgba(15, 23, 42, 0.08);
      margin-bottom: 25px;
    }
    .settings-section h5 {
      color: #0f172a;
      margin-bottom: 15px;
      font-weight: 700;
    }
    .form-check-input:checked {
      background-color: #2563eb;
      border-color: #2563eb;
    }
    .badge-pill {
      border-radius: 50px;
      padding: 6px 14px;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark py-2 mb-4">
    <div class="container-fluid">
      <a class="navbar-brand" href="Dashboard"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item"><a class="nav-link" href="Dashboard">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link" href="profile">Profile</a></li>
          <li class="nav-item"><a class="nav-link active" aria-current="page" href="settings">Settings</a></li>
          <li class="nav-item"><a class="nav-link" href="Support.jsp">Support</a></li>
          <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container pb-5">
    <div class="mb-4">
      <h2 class="fw-bold">Account Settings</h2>
      <p class="text-muted">Manage how Vertex Bank communicates with you and protects your account.</p>
    </div>

    <% if (success != null) { %>
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i><%= success %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>

    <form action="settings" method="post">
      <div class="settings-section">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5><i class="bi bi-bell-fill text-primary me-2"></i> Notification Preferences</h5>
          <span class="badge bg-primary badge-pill">Stay informed</span>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="emailAlerts" name="emailAlerts" <%= settings.isEmailAlerts() ? "checked" : "" %>>
              <label class="form-check-label" for="emailAlerts">
                Email alerts for transactions and important updates
              </label>
            </div>
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="smsAlerts" name="smsAlerts" <%= settings.isSmsAlerts() ? "checked" : "" %>>
              <label class="form-check-label" for="smsAlerts">
                SMS alerts for large transfers and OTP codes
              </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="pushNotifications" name="pushNotifications" <%= settings.isPushNotifications() ? "checked" : "" %>>
              <label class="form-check-label" for="pushNotifications">
                Push notifications in the mobile app
              </label>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="marketingEmails" name="marketingEmails" <%= settings.isMarketingEmails() ? "checked" : "" %>>
              <label class="form-check-label" for="marketingEmails">
                Keep me posted about new features and offers
              </label>
            </div>
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="loginAlerts" name="loginAlerts" <%= settings.isLoginAlerts() ? "checked" : "" %>>
              <label class="form-check-label" for="loginAlerts">
                Notify me whenever a new device logs into my account
              </label>
            </div>
          </div>
        </div>
      </div>

      <div class="settings-section">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5><i class="bi bi-shield-lock-fill text-success me-2"></i> Security</h5>
          <span class="badge bg-success badge-pill">Recommended</span>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="autoLogout" name="autoLogout" <%= settings.isAutoLogout() ? "checked" : "" %>>
              <label class="form-check-label" for="autoLogout">
                Automatically log me out after 10 minutes of inactivity
              </label>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="biometricLogin" name="biometricLogin" <%= settings.isBiometricLogin() ? "checked" : "" %>>
              <label class="form-check-label" for="biometricLogin">
                Enable biometric login on supported devices
              </label>
            </div>
          </div>
        </div>
      </div>

      <div class="settings-section">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5><i class="bi bi-palette-fill text-warning me-2"></i> Appearance</h5>
          <span class="badge bg-warning text-dark badge-pill">Preview</span>
        </div>
        <div class="row">
          <div class="col-md-4">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="theme" id="themeLight" value="light" <%= "light".equals(settings.getTheme()) ? "checked" : "" %>>
              <label class="form-check-label" for="themeLight">
                Light Mode
              </label>
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="theme" id="themeDark" value="dark" <%= "dark".equals(settings.getTheme()) ? "checked" : "" %>>
              <label class="form-check-label" for="themeDark">
                Dark Mode
              </label>
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="theme" id="themeSystem" value="system" <%= "system".equals(settings.getTheme()) ? "checked" : "" %>>
              <label class="form-check-label" for="themeSystem">
                Follow System
              </label>
            </div>
          </div>
        </div>
      </div>

      <div class="text-end">
        <button type="submit" class="btn btn-primary px-5 py-2">
          <i class="bi bi-save me-2"></i>Save Preferences
        </button>
      </div>
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

