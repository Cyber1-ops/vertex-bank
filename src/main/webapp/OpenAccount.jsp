 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 🔒 Session check
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open New Account | Vertex Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e0e7ff 100%);
            color: #1e293b;
            min-height: 100vh;
        }

        .navbar {
            background-color: #0b1220;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            color: #60a5fa !important;
            font-size: 1.4rem;
        }

        .nav-link {
            color: #e2e8f0 !important;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: #60a5fa !important;
        }

        .page-header {
            background: linear-gradient(135deg, #0b1220, #1e3a8a, #2563eb);
            color: white;
            padding: 60px 0;
            margin-bottom: 50px;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="40" fill="rgba(255,255,255,0.05)"/></svg>');
            opacity: 0.3;
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .form-container {
            max-width: 900px;
            margin: 0 auto 80px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .form-progress {
            background: linear-gradient(90deg, #2563eb, #60a5fa);
            height: 6px;
        }

        .form-content {
            padding: 50px 60px;
        }

        .section-title {
            color: #1e3a8a;
            font-weight: 700;
            font-size: 1.4rem;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #e0e7ff;
            display: flex;
            align-items: center;
        }

        .section-title::before {
            content: "";
            width: 8px;
            height: 30px;
            background: linear-gradient(135deg, #2563eb, #60a5fa);
            border-radius: 4px;
            margin-right: 15px;
        }

        .form-label {
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 16px;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: #60a5fa;
            box-shadow: 0 0 0 4px rgba(96, 165, 250, 0.1);
        }

        .form-control:hover, .form-select:hover {
            border-color: #cbd5e1;
        }

        .input-group-text {
            background: linear-gradient(135deg, #e0e7ff, #dbeafe);
            border: 2px solid #e2e8f0;
            color: #1e3a8a;
            font-weight: 600;
            border-radius: 10px 0 0 10px;
        }

        .btn-submit {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            border: none;
            color: white;
            padding: 16px 50px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(37, 99, 235, 0.4);
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
        }

        .alert-info {
            background: linear-gradient(135deg, #dbeafe, #e0e7ff);
            border: 2px solid #93c5fd;
            border-radius: 12px;
            color: #1e40af;
            padding: 16px 20px;
            font-weight: 500;
        }

        .info-card {
            background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
            border-left: 4px solid #2563eb;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .info-card h5 {
            color: #1e3a8a;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .info-card ul {
            margin-bottom: 0;
            padding-left: 20px;
        }

        .info-card li {
            color: #475569;
            margin-bottom: 8px;
        }

        footer {
            background-color: #0b1220;
            color: #cbd5e1;
            padding: 40px 0;
            margin-top: auto;
        }

        footer a {
            color: #60a5fa;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: #93c5fd;
        }

        .footer-divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, #475569, transparent);
            margin: 20px 0;
        }

        @media (max-width: 768px) {
            .form-content {
                padding: 30px 25px;
            }

            .page-header h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

<!-- 🔹 Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark py-3">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Vertex Bank</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="Dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔹 Page Header -->
<div class="page-header">
    <div class="container text-center">
        <h1>Open Your New Account</h1>
        <p>Join Vertex Bank today and experience the future of digital banking</p>
    </div>
</div>

<!-- 🔹 Form Container -->
<div class="container">
    <div class="form-container">
        <div class="form-progress"></div>
        
        <div class="form-content">
            <% if (message != null) { %>
                <div class="alert alert-info mb-4">
                    <strong>📢 </strong><%= message %>
                </div>
            <% } %>

            <div class="info-card">
                <h5>📋 What You'll Need</h5>
                <ul>
                    <li>Valid passport and ID number</li>
                    <li>Current residential address</li>
                    <li>Monthly income information</li>
                    <li>Approximately 5 minutes to complete</li>
                </ul>
            </div>

            <form action="open-account" method="post">
                
                <!-- Personal Details Section -->
                <div class="section-title">Personal Information</div>

                <div class="mb-4">
                    <label for="fullName" class="form-label">Full Name *</label>
                    <input type="text" class="form-control" id="fullName" name="full_name" 
                           placeholder="Enter your full legal name" required>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label for="phone" class="form-label">Phone Number *</label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               placeholder="+971 50 123 4567" required>
                    </div>
                    <div class="col-md-6">
                        <label for="dob" class="form-label">Date of Birth *</label>
                        <input type="date" class="form-control" id="dob" name="dob" required>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <label for="age" class="form-label">Age *</label>
                        <input type="number" class="form-control" id="age" name="age" 
                               min="18" max="120" placeholder="18" required>
                    </div>
                    <div class="col-md-4">
                        <label for="nationality" class="form-label">Nationality *</label>
                        <input type="text" class="form-control" id="nationality" name="nationality" 
                               placeholder="e.g., UAE" required>
                    </div>
                    <div class="col-md-4">
                        <label for="passportNumber" class="form-label">Passport Number *</label>
                        <input type="text" class="form-control" id="passportNumber" name="passport_number" 
                               placeholder="A12345678" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="idNumber" class="form-label">Emirates ID / National ID *</label>
                    <input type="text" class="form-control" id="idNumber" name="id_number" 
                           placeholder="784-1234-1234567-8" required>
                </div>

                <div class="mb-4">
                    <label for="address" class="form-label">Residential Address *</label>
                    <textarea class="form-control" id="address" name="address" rows="3" 
                              placeholder="Enter your complete address" required></textarea>
                </div>

                <div class="mb-5">
                    <label for="monthlyIncome" class="form-label">Monthly Income *</label>
                    <div class="input-group">
                        <span class="input-group-text">AED</span>
                        <input type="number" class="form-control" id="monthlyIncome" name="monthly_income" 
                               min="0" step="0.01" placeholder="10000.00" required>
                    </div>
                </div>

                <!-- Account Details Section -->
                <div class="section-title">Account Configuration</div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label for="accountType" class="form-label">Account Type *</label>
                        <select class="form-select" id="accountType" name="account_type" required>
                            <option value="">Choose your account type...</option>
                            <option value="SAVINGS">💰 Savings Account</option>
                            <option value="CURRENT">📊 Current Account</option>
                            <option value="FIXED_DEPOSIT">🔒 Fixed Deposit Account</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="currency" class="form-label">Base Currency *</label>
                        <select class="form-select" id="currency" name="currency" required>
                            <option value="">Select currency...</option>
                            <option value="AED">🇦🇪 AED - UAE Dirham</option>
                            <option value="USD">🇺🇸 USD - US Dollar</option>
                            <option value="EUR">🇪🇺 EUR - Euro</option>
                        </select>
                    </div>
                </div>

                <div class="mb-5">
                    <label for="initialDeposit" class="form-label">Initial Deposit *</label>
                    <div class="input-group">
                        <span class="input-group-text">AED</span>
                        <input type="number" class="form-control" id="initialDeposit" name="initial_deposit" 
                               min="0" step="0.01" placeholder="5000.00" required>
                    </div>
                </div>

                <div class="d-grid mt-5">
                    <button type="submit" class="btn-submit">
                        Create My Account →
                    </button>
                </div>

                <p class="text-center text-muted mt-4 mb-0">
                    <small>By creating an account, you agree to our Terms of Service and Privacy Policy</small>
                </p>
            </form>
        </div>
    </div>
</div>

<!-- 🔹 Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4 mb-md-0">
                <h5 class="fw-bold mb-3" style="color: #60a5fa;">Vertex Bank</h5>
                <p class="mb-0">Smart. Secure. Seamless.<br>Your trusted digital banking partner.</p>
            </div>
            <div class="col-md-4 mb-4 mb-md-0">
                <h6 class="fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="Dashboard">Dashboard</a></li>
                    <li class="mb-2"><a href="index.jsp">Home</a></li>
                    <li class="mb-2"><a href="Support.jsp">Support</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h6 class="fw-bold mb-3">Contact Us</h6>
                <p class="mb-1">📍 123 Finance Street, Dubai, UAE</p>
                <p class="mb-1">📧 support@vertexbank.com</p>
                <p class="mb-0">📞 +971 500 123 456</p>
            </div>
        </div>
        <div class="footer-divider"></div>
        <div class="text-center">
            <p class="mb-0">&copy; 2025 Vertex Bank. All rights reserved.</p>
            <small class="text-muted">Designed with ❤️ by Vertex Tech Team</small>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

using this style : <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vertex Bank | Smart Digital Banking</title>

  <!-- Bootstrap CSS -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
    rel="stylesheet">

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
    }

    /* ===== NAVBAR ===== */
    .navbar {
      background-color: #0b1220;
      box-shadow: 0 2px 15px rgba(0, 0, 0, 0.2);
      padding: 15px 0;
    }

    .navbar-brand {
      font-weight: 700;
      color: #60a5fa !important;
      font-size: 1.5rem;
      letter-spacing: 0.5px;
    }

    .nav-link {
      color: #e2e8f0 !important;
      margin: 0 10px;
      font-weight: 500;
      transition: all 0.3s ease;
      position: relative;
    }

    .nav-link::after {
      content: '';
      position: absolute;
      bottom: -5px;
      left: 50%;
      transform: translateX(-50%);
      width: 0;
      height: 2px;
      background: #60a5fa;
      transition: width 0.3s ease;
    }

    .nav-link:hover::after {
      width: 80%;
    }

    .nav-link:hover {
      color: #60a5fa !important;
    }

    .btn-nav-login {
      background-color: transparent;
      border: 2px solid #60a5fa;
      color: #60a5fa !important;
      padding: 8px 25px;
      border-radius: 8px;
      margin-left: 10px;
      transition: all 0.3s ease;
    }

    .btn-nav-login:hover {
      background-color: #60a5fa;
      color: #0b1220 !important;
      transform: translateY(-2px);
    }

    .btn-nav-signup {
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      color: white !important;
      padding: 8px 25px;
      border-radius: 8px;
      margin-left: 10px;
      transition: all 0.3s ease;
      border: none;
    }

    .btn-nav-signup:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
    }

    /* ===== HERO SECTION ===== */
    .hero {
      background: linear-gradient(135deg, #0b1220 0%, #1e3a8a 50%, #2563eb 100%);
      color: white;
      text-align: center;
      padding: 120px 20px;
      position: relative;
      overflow: hidden;
    }

    .hero::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="40" fill="rgba(255,255,255,0.03)"/></svg>');
      opacity: 0.5;
    }

    .hero-content {
      position: relative;
      z-index: 1;
    }

    .hero h1 {
      font-size: 3.5rem;
      font-weight: 700;
      margin-bottom: 20px;
      animation: fadeInUp 0.8s ease;
    }

    .hero p {
      font-size: 1.3rem;
      opacity: 0.95;
      margin-bottom: 30px;
      animation: fadeInUp 1s ease;
    }

    .hero-buttons .btn {
      margin: 10px;
      padding: 15px 40px;
      font-size: 1.1rem;
      border-radius: 10px;
      font-weight: 600;
      animation: fadeInUp 1.2s ease;
    }

    .btn-hero-primary {
      background: white;
      color: #1e3a8a;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-hero-primary:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 20px rgba(255, 255, 255, 0.3);
      color: #1e3a8a;
    }

    .btn-hero-secondary {
      background: transparent;
      color: white;
      border: 2px solid white;
      transition: all 0.3s ease;
    }

    .btn-hero-secondary:hover {
      background: white;
      color: #1e3a8a;
      transform: translateY(-3px);
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* ===== STATS SECTION ===== */
    .stats-section {
      background: linear-gradient(135deg, #1e3a8a, #2563eb);
      color: white;
      padding: 60px 0;
      margin-top: -50px;
      position: relative;
      z-index: 2;
    }

    .stat-card {
      text-align: center;
      padding: 20px;
    }

    .stat-number {
      font-size: 3rem;
      font-weight: 700;
      margin-bottom: 10px;
    }

    .stat-label {
      font-size: 1.1rem;
      opacity: 0.9;
    }

    /* ===== SERVICES SECTION ===== */
    .section-title {
      font-size: 2.5rem;
      font-weight: 700;
      color: #1e3a8a;
      margin-bottom: 15px;
    }

    .section-subtitle {
      color: #64748b;
      font-size: 1.1rem;
      margin-bottom: 50px;
    }

    .features .card {
      border: none;
      border-radius: 15px;
      transition: all 0.3s ease;
      background: white;
      height: 100%;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .features .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 40px rgba(37, 99, 235, 0.15);
    }

    .card-icon {
      width: 70px;
      height: 70px;
      background: linear-gradient(135deg, #dbeafe, #bfdbfe);
      border-radius: 15px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      margin: 0 auto 20px;
    }

    /* ===== BENEFITS SECTION ===== */
    .benefits-section {
      background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
      padding: 80px 0;
    }

    .benefit-item {
      display: flex;
      align-items: start;
      margin-bottom: 30px;
    }

    .benefit-icon {
      width: 50px;
      height: 50px;
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
      font-size: 1.3rem;
      margin-right: 20px;
      flex-shrink: 0;
    }

    .benefit-content h5 {
      color: #1e3a8a;
      font-weight: 700;
      margin-bottom: 8px;
    }

    .benefit-content p {
      color: #475569;
      margin-bottom: 0;
    }

    /* ===== PRODUCTS SECTION ===== */
    .product-card {
      background: white;
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 5px 25px rgba(0, 0, 0, 0.08);
      transition: all 0.3s ease;
      height: 100%;
      border-top: 4px solid #2563eb;
    }

    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 45px rgba(37, 99, 235, 0.2);
    }

    .product-card h4 {
      color: #1e3a8a;
      font-weight: 700;
      margin-bottom: 15px;
    }

    .product-features {
      list-style: none;
      padding: 0;
      margin: 20px 0;
    }

    .product-features li {
      padding: 10px 0;
      color: #475569;
      position: relative;
      padding-left: 30px;
    }

    .product-features li::before {
      content: "✓";
      position: absolute;
      left: 0;
      color: #2563eb;
      font-weight: bold;
      font-size: 1.2rem;
    }

    /* ===== CTA SECTION ===== */
    .cta-section {
      background: linear-gradient(135deg, #0b1220, #1e3a8a);
      color: white;
      padding: 80px 0;
      text-align: center;
    }

    .cta-section h2 {
      font-size: 2.5rem;
      font-weight: 700;
      margin-bottom: 20px;
    }

    .cta-section p {
      font-size: 1.2rem;
      opacity: 0.9;
      margin-bottom: 30px;
    }

    /* ===== FOOTER ===== */
    footer {
      background-color: #0b1220;
      color: #cbd5e1;
      padding: 60px 0 20px;
    }

    .footer-brand {
      font-size: 1.5rem;
      font-weight: 700;
      color: #60a5fa;
      margin-bottom: 15px;
    }

    .footer-section h6 {
      color: #60a5fa;
      font-weight: 700;
      margin-bottom: 20px;
      font-size: 1.1rem;
    }

    .footer-links {
      list-style: none;
      padding: 0;
    }

    .footer-links li {
      margin-bottom: 12px;
    }

    .footer-links a {
      color: #cbd5e1;
      text-decoration: none;
      transition: all 0.3s ease;
      display: inline-block;
    }

    .footer-links a:hover {
      color: #60a5fa;
      transform: translateX(5px);
    }

    .footer-divider {
      height: 1px;
      background: linear-gradient(90deg, transparent, #475569, transparent);
      margin: 40px 0 30px;
    }

    .social-links {
      display: flex;
      gap: 15px;
      margin-top: 20px;
    }

    .social-icon {
      width: 40px;
      height: 40px;
      background: #1e3a8a;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #60a5fa;
      text-decoration: none;
      transition: all 0.3s ease;
    }

    .social-icon:hover {
      background: #60a5fa;
      color: #0b1220;
      transform: translateY(-3px);
    }

    .footer-bottom {
      text-align: center;
      padding-top: 20px;
      border-top: 1px solid #1e3a8a;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
      .hero h1 {
        font-size: 2.5rem;
      }

      .hero p {
        font-size: 1.1rem;
      }

      .section-title {
        font-size: 2rem;
      }

      .stat-number {
        font-size: 2rem;
      }
    }
  </style>
</head>

<body>
  <!-- ===== NAVIGATION BAR ===== -->
  <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
      <a class="navbar-brand" href="index.jsp">Vertex Bank</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
          <li class="nav-item"><a class="nav-link" href="#products">Products</a></li>
          <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
          <li class="nav-item"><a class="nav-link" href="Support.jsp">Support</a></li>
          <li class="nav-item"><a class="btn btn-nav-login" href="login.jsp">Login</a></li>
          <li class="nav-item"><a class="btn btn-nav-signup" href="signup.jsp">Sign Up</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- ===== HERO SECTION ===== -->
  <section id="home" class="hero">
    <div class="hero-content">
      <div class="container">
        <h1>Smart. Secure. Seamless.</h1>
        <p>Experience the future of banking with cutting-edge technology and unparalleled service</p>
        <div class="hero-buttons">
          <a href="signup.jsp" class="btn btn-hero-primary">Open Account</a>
          <a href="#services" class="btn btn-hero-secondary">Learn More</a>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== STATS SECTION ===== -->
  <section class="stats-section">
    <div class="container">
      <div class="row">
        <div class="col-md-3 col-6">
          <div class="stat-card">
            <div class="stat-number">500K+</div>
            <div class="stat-label">Happy Customers</div>
          </div>
        </div>
        <div class="col-md-3 col-6">
          <div class="stat-card">
            <div class="stat-number">$2.5B</div>
            <div class="stat-label">Assets Managed</div>
          </div>
        </div>
        <div class="col-md-3 col-6">
          <div class="stat-card">
            <div class="stat-number">50+</div>
            <div class="stat-label">Countries Served</div>
          </div>
        </div>
        <div class="col-md-3 col-6">
          <div class="stat-card">
            <div class="stat-number">24/7</div>
            <div class="stat-label">Customer Support</div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== SERVICES SECTION ===== -->
  <section id="services" class="py-5 features">
    <div class="container text-center">
      <h2 class="section-title">Our Banking Services</h2>
      <p class="section-subtitle">Comprehensive financial solutions tailored to your needs</p>

      <div class="row g-4">
        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <div class="card-icon">💳</div>
              <h5 class="card-title fw-bold mb-3">Digital Banking</h5>
              <p class="card-text">Access your accounts 24/7 from anywhere in the world. Transfer funds, pay bills, and manage your finances with just a few clicks.</p>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <div class="card-icon">📈</div>
              <h5 class="card-title fw-bold mb-3">Wealth Management</h5>
              <p class="card-text">Grow your wealth with AI-powered insights, personalized investment strategies, and expert financial advisory services.</p>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <div class="card-icon">🛡️</div>
              <h5 class="card-title fw-bold mb-3">Secure Transactions</h5>
              <p class="card-text">Bank with confidence using military-grade encryption, biometric authentication, and real-time fraud detection.</p>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <div class="card-icon">🌍</div>
              <h5 class="card-title fw-bold mb-3">Global Banking</h5>
              <p class="card-text">Send and receive money internationally with competitive exchange rates and minimal fees across 50+ countries.</p>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <div class="card-icon">💰</div>
              <h5 class="card-title fw-bold mb-3">Smart Savings</h5>
              <p class="card-text">Achieve your financial goals faster with high-interest savings accounts and automated savings tools.</p>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <div class="card-icon">🎯</div>
              <h5 class="card-title fw-bold mb-3">Personalized Service</h5>
              <p class="card-text">Get dedicated support from our expert team available 24/7 via chat, phone, or in-person consultations.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== BENEFITS SECTION ===== -->
  <section class="benefits-section">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-6 mb-4 mb-md-0">
          <h2 class="section-title">Why Choose Vertex Bank?</h2>
          <p class="section-subtitle">Experience banking that puts you first</p>

          <div class="benefit-item">
            <div class="benefit-icon">1</div>
            <div class="benefit-content">
              <h5>Cutting-Edge Technology</h5>
              <p>Leverage the latest fintech innovations for seamless banking experiences across all devices.</p>
            </div>
          </div>

          <div class="benefit-item">
            <div class="benefit-icon">2</div>
            <div class="benefit-content">
              <h5>Transparent Pricing</h5>
              <p>No hidden fees, no surprises. Just clear, honest pricing for all our services.</p>
            </div>
          </div>

          <div class="benefit-item">
            <div class="benefit-icon">3</div>
            <div class="benefit-content">
              <h5>Award-Winning Support</h5>
              <p>Our customer service team has been recognized as the best in the industry for 5 consecutive years.</p>
            </div>
          </div>

          <div class="benefit-item">
            <div class="benefit-icon">4</div>
            <div class="benefit-content">
              <h5>Sustainable Banking</h5>
              <p>We're committed to environmental responsibility and ethical banking practices.</p>
            </div>
          </div>
        </div>

        <div class="col-md-6 text-center">
          <img src="https://cdn.pixabay.com/photo/2017/06/10/07/18/bank-2388022_960_720.png" 
               class="img-fluid rounded" alt="Banking Innovation" style="max-width: 450px;">
        </div>
      </div>
    </div>
  </section>

  <!-- ===== PRODUCTS SECTION ===== -->
  <section id="products" class="py-5">
    <div class="container">
      <div class="text-center mb-5">
        <h2 class="section-title">Our Account Types</h2>
        <p class="section-subtitle">Find the perfect account for your financial needs</p>
      </div>

      <div class="row g-4">
        <div class="col-md-4">
          <div class="product-card">
            <h4>💎 Savings Account</h4>
            <p class="text-muted mb-3">Earn competitive interest while keeping your funds accessible</p>
            <ul class="product-features">
              <li>Up to 4.5% annual interest rate</li>
              <li>No minimum balance required</li>
              <li>Free unlimited transfers</li>
              <li>Mobile and online banking</li>
              <li>Deposit insurance up to $250,000</li>
            </ul>
            <a href="signup.jsp" class="btn btn-nav-signup w-100 mt-3">Open Account</a>
          </div>
        </div>

        <div class="col-md-4">
          <div class="product-card">
            <h4>📊 Current Account</h4>
            <p class="text-muted mb-3">Perfect for everyday transactions and business needs</p>
            <ul class="product-features">
              <li>Unlimited transactions</li>
              <li>Free debit card with rewards</li>
              <li>Overdraft protection available</li>
              <li>Business tools and invoicing</li>
              <li>Priority customer support</li>
            </ul>
            <a href="signup.jsp" class="btn btn-nav-signup w-100 mt-3">Open Account</a>
          </div>
        </div>

        <div class="col-md-4">
          <div class="product-card">
            <h4>🔒 Fixed Deposit</h4>
            <p class="text-muted mb-3">Guaranteed returns with flexible term options</p>
            <ul class="product-features">
              <li>Interest rates up to 6.5%</li>
              <li>Terms from 6 months to 5 years</li>
              <li>Guaranteed fixed returns</li>
              <li>Automatic renewal options</li>
              <li>Loan against FD available</li>
            </ul>
            <a href="signup.jsp" class="btn btn-nav-signup w-100 mt-3">Open Account</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== ABOUT SECTION ===== -->
  <section id="about" class="py-5 bg-light">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-6 mb-4 mb-md-0">
          <h2 class="section-title">About Vertex Bank</h2>
          <p class="lead mb-4">Building trust through innovation and transparency</p>
          <p>Founded in 2020, Vertex Bank has quickly become a leader in digital banking solutions. We combine cutting-edge technology with traditional banking values to provide secure, innovative, and user-friendly financial services.</p>
          <p>Our mission is to democratize banking by making sophisticated financial tools accessible to everyone, while maintaining the highest standards of security and customer service.</p>
          <div class="mt-4">
            <a href="#contact" class="btn btn-nav-signup">Contact Us</a>
          </div>
        </div>
        <div class="col-md-6">
          <div class="row g-3">
            <div class="col-6">
              <div class="p-4 bg-white rounded shadow-sm text-center">
                <h3 class="text-primary fw-bold">100%</h3>
                <p class="mb-0 text-muted">Digital</p>
              </div>
            </div>
            <div class="col-6">
              <div class="p-4 bg-white rounded shadow-sm text-center">
                <h3 class="text-primary fw-bold">A+</h3>
                <p class="mb-0 text-muted">Security Rating</p>
              </div>
            </div>
            <div class="col-6">
              <div class="p-4 bg-white rounded shadow-sm text-center">
                <h3 class="text-primary fw-bold">4.9★</h3>
                <p class="mb-0 text-muted">App Rating</p>
              </div>
            </div>
            <div class="col-6">
              <div class="p-4 bg-white rounded shadow-sm text-center">
                <h3 class="text-primary fw-bold">5+</h3>
                <p class="mb-0 text-muted">Years Experience</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== CTA SECTION ===== -->
  <section class="cta-section">
    <div class="container">
      <h2>Ready to Experience Better Banking?</h2>
      <p>Join over 500,000 satisfied customers who trust Vertex Bank</p>
      <div class="d-flex justify-content-center gap-3 flex-wrap">
        <a href="signup.jsp" class="btn btn-hero-primary">Open Free Account</a>
        <a href="#services" class="btn btn-hero-secondary">Explore Services</a>
      </div>
    </div>
  </section>

  <!-- ===== FOOTER ===== -->
  <footer id="contact">
    <div class="container">
      <div class="row">
        <!-- Brand Section -->
        <div class="col-md-4 mb-4">
          <div class="footer-brand">Vertex Bank</div>
          <p class="mb-3">Smart. Secure. Seamless.<br>Your trusted digital banking partner for a better financial future.</p>
          <div class="social-links">
            <a href="#" class="social-icon" aria-label="Facebook">f</a>
            <a href="#" class="social-icon" aria-label="Twitter">𝕏</a>
            <a href="#" class="social-icon" aria-label="LinkedIn">in</a>
            <a href="#" class="social-icon" aria-label="Instagram">📷</a>
          </div>
        </div>

        <!-- Quick Links -->
        <div class="col-md-2 col-6 mb-4">
          <div class="footer-section">
            <h6>Quick Links</h6>
            <ul class="footer-links">
              <li><a href="#home">Home</a></li>
              <li><a href="#services">Services</a></li>
              <li><a href="#products">Products</a></li>
              <li><a href="#about">About Us</a></li>
              <li><a href="login.jsp">Login</a></li>
            </ul>
          </div>
        </div>

        <!-- Services -->
        <div class="col-md-2 col-6 mb-4">
          <div class="footer-section">
            <h6>Services</h6>
            <ul class="footer-links">
              <li><a href="#services">Digital Banking</a></li>
              <li><a href="#services">Investments</a></li>
              <li><a href="#services">Loans</a></li>
              <li><a href="#services">Insurance</a></li>
              <li><a href="#services">Cards</a></li>
            </ul>
          </div>
        </div>

        <!-- Support -->
        <div class="col-md-4 mb-4">
          <div class="footer-section">
            <h6>Contact Us</h6>
            <ul class="footer-links" style="list-style: none; padding: 0;">
              <li style="margin-bottom: 12px;">📍 123 Finance Street<br>&nbsp;&nbsp;&nbsp;&nbsp;Dubai, UAE 00000</li>
              <li style="margin-bottom: 12px;">📧 support@vertexbank.com</li>
              <li style="margin-bottom: 12px;">📞 +971 500 123 456</li>
              <li>🕐 24/7 Support Available</li>
            </ul>
          </div>
        </div>
      </div>

      <div class="footer-divider"></div>

      <div class="footer-bottom">
        <p class="mb-2">&copy; 2025 Vertex Bank. All rights reserved.</p>
        <p class="text-muted mb-0">
          <small>
        <p class="text-muted mb-0">
          <small>
            <a href="#" class="text-muted me-3" style="text-decoration: none;">Privacy Policy</a>
            <a href="#" class="text-muted me-3" style="text-decoration: none;">Terms of Service</a>
            <a href="#" class="text-muted" style="text-decoration: none;">Cookie Policy</a>
          </small>
        </p>
      </div>
    </div>
  </footer>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });

    // Add active class to nav links on scroll
    window.addEventListener('scroll', () => {
      let current = '';
      const sections = document.querySelectorAll('section[id]');
      
      sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;
        if (pageYOffset >= sectionTop - 200) {
          current = section.getAttribute('id');
        }
      });

      document.querySelectorAll('.nav-link').forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === `#${current}`) {
          link.classList.add('active');
        }
      });
    });
  </script>
</body>
</html>