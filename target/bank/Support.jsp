<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Support & Help Center | Vertex Bank</title>

  <!-- Bootstrap CSS -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
    rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

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

    .navbar-brand .logo-img {
      height: 50px;
      width: auto;
      max-width: 180px;
      object-fit: contain;
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

    /* ===== HERO SECTION ===== */
    .support-hero {
      background: linear-gradient(135deg, #0b1220 0%, #1e3a8a 50%, #2563eb 100%);
      color: white;
      text-align: center;
      padding: 100px 20px 80px;
      position: relative;
      overflow: hidden;
    }

    .support-hero::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="40" fill="rgba(255,255,255,0.03)"/></svg>');
      opacity: 0.5;
    }

    .support-hero-content {
      position: relative;
      z-index: 1;
    }

    .support-hero h1 {
      font-size: 3rem;
      font-weight: 700;
      margin-bottom: 20px;
    }

    .support-hero p {
      font-size: 1.2rem;
      opacity: 0.95;
      margin-bottom: 30px;
    }

    /* ===== SEARCH BOX ===== */
    .search-box {
      max-width: 700px;
      margin: 0 auto;
      position: relative;
    }

    .search-box input {
      width: 100%;
      padding: 18px 60px 18px 25px;
      border-radius: 50px;
      border: none;
      font-size: 1.1rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    }

    .search-box input:focus {
      outline: none;
      box-shadow: 0 10px 40px rgba(96, 165, 250, 0.3);
    }

    .search-box button {
      position: absolute;
      right: 8px;
      top: 50%;
      transform: translateY(-50%);
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      border: none;
      color: white;
      padding: 10px 25px;
      border-radius: 50px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .search-box button:hover {
      transform: translateY(-50%) scale(1.05);
      box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
    }

    /* ===== QUICK LINKS ===== */
    .quick-links {
      background: white;
      padding: 60px 0;
    }

    .section-title {
      font-size: 2.5rem;
      font-weight: 700;
      color: #1e3a8a;
      margin-bottom: 15px;
      text-align: center;
    }

    .section-subtitle {
      color: #64748b;
      font-size: 1.1rem;
      margin-bottom: 50px;
      text-align: center;
    }

    .quick-link-card {
      background: white;
      border: 2px solid #e2e8f0;
      border-radius: 15px;
      padding: 30px;
      text-align: center;
      transition: all 0.3s ease;
      height: 100%;
      cursor: pointer;
    }

    .quick-link-card:hover {
      transform: translateY(-5px);
      border-color: #2563eb;
      box-shadow: 0 10px 30px rgba(37, 99, 235, 0.15);
    }

    .quick-link-icon {
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

    .quick-link-card h5 {
      color: #1e3a8a;
      font-weight: 700;
      margin-bottom: 10px;
    }

    .quick-link-card p {
      color: #64748b;
      margin-bottom: 0;
    }

    /* ===== FAQ SECTION ===== */
    .faq-section {
      background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
      padding: 80px 0;
    }

    .faq-item {
      background: white;
      border-radius: 12px;
      margin-bottom: 15px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      overflow: hidden;
      transition: all 0.3s ease;
    }

    .faq-item:hover {
      box-shadow: 0 5px 20px rgba(37, 99, 235, 0.1);
    }

    .faq-question {
      padding: 25px;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-weight: 600;
      color: #1e3a8a;
      transition: all 0.3s ease;
    }

    .faq-question:hover {
      background: #f8fafc;
    }

    .faq-question::after {
      content: '+';
      font-size: 1.5rem;
      color: #2563eb;
      transition: transform 0.3s ease;
    }

    .faq-question.active::after {
      transform: rotate(45deg);
    }

    .faq-answer {
      padding: 0 25px;
      max-height: 0;
      overflow: hidden;
      transition: all 0.3s ease;
      color: #475569;
    }

    .faq-answer.active {
      padding: 0 25px 25px;
      max-height: 500px;
    }

    /* ===== CONTACT SECTION ===== */
    .contact-section {
      background: white;
      padding: 80px 0;
    }

    .contact-card {
      background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
      border-radius: 20px;
      padding: 40px;
      text-align: center;
      height: 100%;
      border: 2px solid #bfdbfe;
      transition: all 0.3s ease;
    }

    .contact-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 30px rgba(37, 99, 235, 0.15);
      border-color: #2563eb;
    }

    .contact-icon {
      width: 80px;
      height: 80px;
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      margin: 0 auto 20px;
      color: white;
    }

    .contact-card h4 {
      color: #1e3a8a;
      font-weight: 700;
      margin-bottom: 15px;
    }

    .contact-card p {
      color: #475569;
      margin-bottom: 20px;
    }

    .contact-info {
      font-weight: 600;
      color: #2563eb;
      font-size: 1.1rem;
    }

    /* ===== CONTACT FORM ===== */
    .contact-form {
      background: white;
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 5px 25px rgba(0, 0, 0, 0.08);
    }

    .form-label {
      font-weight: 600;
      color: #1e3a8a;
      margin-bottom: 8px;
    }

    .form-control, .form-select {
      border: 2px solid #e2e8f0;
      border-radius: 10px;
      padding: 12px;
      transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
      border-color: #2563eb;
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .btn-submit {
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      color: white;
      padding: 15px 40px;
      border-radius: 10px;
      font-weight: 600;
      border: none;
      transition: all 0.3s ease;
      width: 100%;
    }

    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
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
      .support-hero h1 {
        font-size: 2rem;
      }

      .support-hero p {
        font-size: 1rem;
      }

      .section-title {
        font-size: 2rem;
      }

      .search-box input {
        padding: 15px 20px;
        font-size: 1rem;
      }

      .search-box button {
        position: static;
        transform: none;
        width: 100%;
        margin-top: 10px;
      }
    }
  </style>
</head>

<body>

<%
  User sessionUser = (User) session.getAttribute("user");
%>
  <!-- ===== NAVIGATION BAR ===== -->
  <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
      <a class="navbar-brand" href="index.jsp"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="index.jsp#services">Services</a></li>
          <li class="nav-item"><a class="nav-link" href="index.jsp#products">Products</a></li>
          <li class="nav-item"><a class="nav-link" href="Support.jsp">Support</a></li>
          <% if (sessionUser != null) { %>
            <li class="nav-item text-white fw-semibold ms-2">
              Hi, <%= sessionUser.getFullName() != null ? sessionUser.getFullName() : sessionUser.getUsername() %>
            </li>
            <li class="nav-item"><a class="nav-link" href="profile">Profile</a></li>
            <li class="nav-item"><a class="nav-link" href="settings">Settings</a></li>
            <li class="nav-item"><a class="btn btn-nav-login" href="Dashboard">Dashboard</a></li>
            <li class="nav-item"><a class="btn btn-nav-signup" href="logout">Logout</a></li>
          <% } else { %>
            <li class="nav-item"><a class="btn btn-nav-login" href="login.jsp">Login</a></li>
            <li class="nav-item"><a class="btn btn-nav-signup" href="signup.jsp">Sign Up</a></li>
          <% } %>
        </ul>
      </div>
    </div>
  </nav>

  <!-- ===== HERO SECTION ===== -->
  <section class="support-hero">
    <div class="support-hero-content">
      <div class="container">
        <h1>How Can We Help You?</h1>
        <p>Search our knowledge base or get in touch with our support team</p>
        
        <div class="search-box">
          <input type="text" placeholder="Search for help articles, FAQs, or topics..." id="searchInput">
          <button onclick="searchHelp()">Search</button>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== QUICK LINKS ===== -->
  <section class="quick-links">
    <div class="container">
      <h2 class="section-title">Quick Help Topics</h2>
      <p class="section-subtitle">Find answers to the most common questions</p>

      <div class="row g-4">
        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="scrollToFAQ()">
            <div class="quick-link-icon">🔐</div>
            <h5>Account Security</h5>
            <p>Password reset, 2FA, security tips</p>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="scrollToFAQ()">
            <div class="quick-link-icon">💳</div>
            <h5>Transactions</h5>
            <p>Transfers, payments, history</p>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="scrollToFAQ()">
            <div class="quick-link-icon">📱</div>
            <h5>Mobile Banking</h5>
            <p>App features, login issues</p>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="scrollToFAQ()">
            <div class="quick-link-icon">💰</div>
            <h5>Account Types</h5>
            <p>Savings, current, fixed deposits</p>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="scrollToFAQ()">
            <div class="quick-link-icon">🌍</div>
            <h5>International</h5>
            <p>Wire transfers, forex rates</p>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="scrollToFAQ()">
            <div class="quick-link-icon">📊</div>
            <h5>Statements</h5>
            <p>Download, view, export</p>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="scrollToFAQ()">
            <div class="quick-link-icon">🎯</div>
            <h5>Loans & Credit</h5>
            <p>Applications, EMI, eligibility</p>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="quick-link-card" onclick="window.location.href='settings'">
            <div class="quick-link-icon">⚙️</div>
            <h5>Settings</h5>
            <p>Profile, notifications, limits</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== FAQ SECTION ===== -->
  <section class="faq-section" id="faq">
    <div class="container">
      <h2 class="section-title">Frequently Asked Questions</h2>
      <p class="section-subtitle">Get instant answers to common queries</p>

      <div class="row">
        <div class="col-lg-8 mx-auto">
          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              How do I reset my password?
            </div>
            <div class="faq-answer">
              Click on "Forgot Password" on the login page, enter your registered email address, and follow the instructions sent to your email. The reset link is valid for 24 hours. If you don't receive the email, check your spam folder or contact support.
            </div>
          </div>

          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              What are the transaction limits?
            </div>
            <div class="faq-answer">
              Daily transaction limits vary by account type: Savings Account - $10,000, Current Account - $50,000, Premium Account - $100,000. You can request limit increases by contacting your relationship manager or through the mobile app settings.
            </div>
          </div>

          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              How long do international transfers take?
            </div>
            <div class="faq-answer">
              International wire transfers typically take 1-3 business days depending on the destination country and the receiving bank. Transfers within the UAE and GCC countries are usually completed within 24 hours. Real-time tracking is available in your dashboard.
            </div>
          </div>

          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              How do I enable two-factor authentication?
            </div>
            <div class="faq-answer">
              Go to Settings > Security > Two-Factor Authentication in your account. Choose between SMS, email, or authenticator app. We strongly recommend using an authenticator app for enhanced security. Follow the on-screen instructions to complete setup.
            </div>
          </div>

          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              What should I do if I notice unauthorized transactions?
            </div>
            <div class="faq-answer">
              Immediately contact our 24/7 fraud hotline at +971 500 123 456 or use the "Report Fraud" feature in the mobile app. We'll temporarily freeze your account and investigate. You're protected by our Zero Liability policy for unauthorized transactions reported within 60 days.
            </div>
          </div>

          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              How can I download my account statements?
            </div>
            <div class="faq-answer">
              Log into your account, go to Accounts > Statements, select the date range, and click Download. Statements are available in PDF and Excel formats. You can download statements for up to 7 years of transaction history.
            </div>
          </div>

          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              What are your customer service hours?
            </div>
            <div class="faq-answer">
              Our customer service team is available 24/7 via phone, live chat, and email. Phone support: +971 500 123 456. Live chat is available through our website and mobile app. Average response time for emails is under 2 hours.
            </div>
          </div>

          <div class="faq-item">
            <div class="faq-question" onclick="toggleFAQ(this)">
              How do I close my account?
            </div>
            <div class="faq-answer">
              To close your account, ensure your balance is zero and no pending transactions exist. Submit a closure request through the app or visit any branch with your ID. Processing takes 5-7 business days. Any remaining funds will be transferred to your linked account.
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== CONTACT METHODS ===== -->
  <section class="contact-section" id="contact">
    <div class="container">
      <h2 class="section-title">Get In Touch</h2>
      <p class="section-subtitle">Multiple ways to reach our support team</p>

      <div class="row g-4 mb-5">
        <div class="col-md-4">
          <div class="contact-card">
            <div class="contact-icon">📞</div>
            <h4>Phone Support</h4>
            <p>Talk to our experts anytime</p>
            <div class="contact-info">+971 500 123 456</div>
            <small class="text-muted d-block mt-2">Available 24/7</small>
          </div>
        </div>

        <div class="col-md-4">
          <div class="contact-card">
            <div class="contact-icon">💬</div>
            <h4>Live Chat</h4>
            <p>Instant help from our team</p>
            <div class="contact-info">Start Chat</div>
            <small class="text-muted d-block mt-2">Average wait: 2 min</small>
          </div>
        </div>

        <div class="col-md-4">
          <div class="contact-card">
            <div class="contact-icon">📧</div>
            <h4>Email Support</h4>
            <p>Send us your questions</p>
            <div class="contact-info">support@vertexbank.com</div>
            <small class="text-muted d-block mt-2">Response within 2 hours</small>
          </div>
        </div>
      </div>

      <!-- ===== CONTACT FORM ===== -->
      <div class="row">
        <div class="col-lg-8 mx-auto">
          <div class="contact-form">
            <h3 class="text-center mb-4" style="color: #1e3a8a; font-weight: 700;">Submit a Support Ticket</h3>
            
            <form id="supportForm">
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label class="form-label">Full Name</label>
                  <input type="text" class="form-control" placeholder="Enter your name" required>
                </div>
                <div class="col-md-6 mb-3">
                  <label class="form-label">Email Address</label>
                  <input type="email" class="form-control" placeholder="your.email@example.com" required>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6 mb-3">
                  <label class="form-label">Phone Number</label>
                  <input type="tel" class="form-control" placeholder="+971 XX XXX XXXX">
                </div>
                <div class="col-md-6 mb-3">
                  <label class="form-label">Category</label>
                  <select class="form-select" required>
                    <option value="">Select a category</option>
                    <option>Account Issues</option>
                    <option>Transaction Problems</option>
                    <option>Card Services</option>
                    <option>Mobile App</option>
                    <option>Security Concerns</option>
                    <option>Loans & Credit</option>
                    <option>Other</option>
                  </select>
                </div>
              </div>

              <div class="mb-3">
                <label class="form-label">Subject</label>
                <input type="text" class="form-control" placeholder="Brief description of your issue" required>
              </div>

              <div class="mb-3">
                <label class="form-label">Message</label>
                <textarea class="form-control" rows="5" placeholder="Provide detailed information about your inquiry..." required></textarea>
              </div>

              <div class="mb-3">
                <label class="form-label">Priority Level</label>
                <select class="form-select">
                  <option>Low - General inquiry</option>
                  <option>Medium - Need assistance</option>
                  <option>High - Urgent issue</option>
                  <option>Critical - Account compromised</option>
                </select>
              </div>

              <button type="submit" class="btn-submit">Submit Ticket</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== POLICY SECTION ===== -->
  <section class="faq-section" id="policies">
    <div class="container">
      <h2 class="section-title">Policies & Legal</h2>
      <p class="section-subtitle">Understand how we protect you and your data</p>
      <div class="row g-4">
        <div class="col-md-4" id="privacy">
          <div class="faq-item p-4 h-100">
            <h5 class="mb-3"><i class="bi bi-shield-lock text-primary me-2"></i>Privacy Policy</h5>
            <p class="mb-0 text-muted">Your personal information is safeguarded with bank-grade encryption.
              Review the full policy to learn how we collect, store, and process data.</p>
          </div>
        </div>
        <div class="col-md-4" id="terms">
          <div class="faq-item p-4 h-100">
            <h5 class="mb-3"><i class="bi bi-file-text text-primary me-2"></i>Terms of Service</h5>
            <p class="mb-0 text-muted">These terms outline your rights and responsibilities when using Vertex Bank
              digital channels. Staying informed keeps your account secure.</p>
          </div>
        </div>
        <div class="col-md-4" id="cookies">
          <div class="faq-item p-4 h-100">
            <h5 class="mb-3"><i class="bi bi-cookie text-primary me-2"></i>Cookie Policy</h5>
            <p class="mb-0 text-muted">Cookies help us personalize experiences and improve performance. Learn about
              the data we collect and how you can manage preferences.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== FOOTER ===== -->
  <footer>
    <div class="container">
      <div class="row">
        <!-- Brand Section -->
        <div class="col-md-4 mb-4">
          <div class="footer-brand"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></div>
          <p class="mb-3">Smart. Secure. Seamless.<br>Your trusted digital banking partner for a better financial future.</p>
          <div class="social-links">
            <a href="https://facebook.com/vertexbank" target="_blank" rel="noopener" class="social-icon" aria-label="Facebook">f</a>
            <a href="https://twitter.com/vertexbank" target="_blank" rel="noopener" class="social-icon" aria-label="Twitter">𝕏</a>
            <a href="https://www.linkedin.com/company/vertexbank" target="_blank" rel="noopener" class="social-icon" aria-label="LinkedIn">in</a>
            <a href="https://instagram.com/vertexbank" target="_blank" rel="noopener" class="social-icon" aria-label="Instagram">📷</a>
          </div>
        </div>

        <!-- Quick Links -->
        <div class="col-md-2 col-6 mb-4">
          <div class="footer-section">
            <h6>Quick Links</h6>
            <ul class="footer-links">
              <li><a href="index.jsp">Home</a></li>
              <li><a href="index.jsp#services">Services</a></li>
              <li><a href="index.jsp#products">Products</a></li>
              <li><a href="index.jsp#about">About Us</a></li>
              <li><a href="login.jsp">Login</a></li>
            </ul>
          </div>
        </div>

        <!-- Services -->
        <div class="col-md-2 col-6 mb-4">
          <div class="footer-section">
            <h6>Services</h6>
            <ul class="footer-links">
              <li><a href="index.jsp#services">Digital Banking</a></li>
              <li><a href="index.jsp#services">Investments</a></li>
              <li><a href="index.jsp#services">Loans</a></li>
              <li><a href="index.jsp#services">Insurance</a></li>
              <li><a href="index.jsp#services">Cards</a></li>
            </ul>
          </div>
        </div>

        <!-- Support -->
        <div class="col-md-4 mb-4">
          <div class="footer-section">
            <h6>Contact Us</h6>
            <ul class="footer-links" style="list-style: none; padding: 0;">
              <li class="mb-2">📍 123 Finance Street, Dubai, UAE</li>
              <li class="mb-2">📧 support@vertexbank.com</li>
              <li class="mb-2">📞 +971 500 123 456</li>
              <li>🕒 24/7 concierge support</li>
            </ul>
          </div>
        </div>
      </div>

      <div class="footer-divider"></div>

      <div class="footer-bottom">
        <p class="mb-2">&copy; 2025 Vertex Bank. All rights reserved.</p>
        <p class="text-muted mb-0">
          <small>
            <a href="Support.jsp#privacy" class="text-muted me-3" style="text-decoration: none;">Privacy Policy</a>
            <a href="Support.jsp#terms" class="text-muted me-3" style="text-decoration: none;">Terms of Service</a>
            <a href="Support.jsp#cookies" class="text-muted" style="text-decoration: none;">Cookie Policy</a>
          </small>
        </p>
      </div>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function searchHelp() {
      const query = document.getElementById('searchInput').value.trim();
      if (!query) {
        scrollToFAQ();
        return;
      }
      const matches = Array.from(document.querySelectorAll('.faq-question'))
        .filter(q => q.textContent.toLowerCase().includes(query.toLowerCase()));
      if (matches.length > 0) {
        toggleFAQ(matches[0]);
        matches[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
      } else {
        alert('No matching articles found. Please reach out to our team.');
      }
    }

    function scrollToFAQ() {
      const faq = document.getElementById('faq');
      if (faq) {
        faq.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    }

    function toggleFAQ(element) {
      const answer = element.nextElementSibling;
      const isActive = element.classList.contains('active');

      document.querySelectorAll('.faq-question').forEach(q => q.classList.remove('active'));
      document.querySelectorAll('.faq-answer').forEach(a => a.classList.remove('active'));

      if (!isActive) {
        element.classList.add('active');
        if (answer) {
          answer.classList.add('active');
        }
      }
    }

    const supportForm = document.getElementById('supportForm');
    if (supportForm) {
      supportForm.addEventListener('submit', function (e) {
        e.preventDefault();
        alert('Thank you! Your support ticket has been submitted.');
        supportForm.reset();
      });
    }
  </script>
</body>
</html>