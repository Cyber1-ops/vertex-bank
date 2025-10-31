<%@ page language="java" contentType="text/html; charset=UTF-8"
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
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
    }

    .navbar {
      background-color: #0b1220;
    }

    .navbar-brand {
      font-weight: 700;
      color: #60a5fa !important;
      font-size: 1.4rem;
    }

    .nav-link {
      color: #e2e8f0 !important;
      margin: 0 8px;
    }

    .nav-link:hover {
      color: #60a5fa !important;
    }

    .hero {
      background: linear-gradient(to right, #0b1220, #1e3a8a);
      color: white;
      text-align: center;
      padding: 100px 20px;
    }

    .hero h1 {
      font-size: 3rem;
      font-weight: 700;
      margin-bottom: 20px;
    }

    .hero p {
      font-size: 1.2rem;
      opacity: 0.9;
    }

    .btn-primary {
      background-color: #2563eb;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #1d4ed8;
    }

    .features .card {
      border: none;
      transition: transform 0.3s ease;
    }

    .features .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    footer {
      background-color: #0b1220;
      color: #cbd5e1;
      padding: 40px 0;
    }

    footer a {
      color: #60a5fa;
      text-decoration: none;
    }

    footer a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body>
  <!-- 🔹 Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark py-3">
    <div class="container">
      <a class="navbar-brand" href="#">Vertex Bank</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
          <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
          <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
          <li class="nav-item"><a class="btn btn-primary ms-2" href="login.jsp">Login</a></li>
          <li class="nav-item"><a class="btn btn-outline-light ms-2" href="signup.jsp">Sign Up</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- 🔹 Hero Section -->
  <section class="hero">
    <div class="container">
      <h1>Smart. Secure. Seamless.</h1>
      <p>Manage your money anytime, anywhere — with confidence.</p>
      <a href="signup.jsp" class="btn btn-primary btn-lg mt-3">Get Started</a>
    </div>
  </section>

  <!-- 🔹 Services Section -->
  <section id="services" class="py-5 features">
    <div class="container text-center">
      <h2 class="fw-bold mb-4">Our Banking Services</h2>
      <p class="text-muted mb-5">Explore our secure and innovative solutions designed for modern banking.</p>

      <div class="row g-4">
        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <h5 class="card-title fw-bold mb-3">Online Banking</h5>
              <p class="card-text">Access your accounts, transfer funds, and manage finances from anywhere securely.</p>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <h5 class="card-title fw-bold mb-3">Smart Investments</h5>
              <p class="card-text">Grow your wealth with AI-backed insights and personalized investment strategies.</p>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card p-4">
            <div class="card-body">
              <h5 class="card-title fw-bold mb-3">24/7 Support</h5>
              <p class="card-text">Our dedicated support team is here to help you anytime, anywhere.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 🔹 About Section -->
  <section id="about" class="py-5 bg-light">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-6 mb-4 mb-md-0">
          <h2 class="fw-bold">About Vertex Bank</h2>
          <p>Vertex Bank is a next-generation digital bank built on trust, technology, and transparency. We empower customers to manage finances effortlessly through secure, innovative, and user-friendly banking solutions.</p>
          <a href="about.jsp" class="btn btn-primary mt-3">Learn More</a>
        </div>
        <div class="col-md-6 text-center">
          <img src="https://cdn.pixabay.com/photo/2017/06/10/07/18/bank-2388022_960_720.png" 
               class="img-fluid rounded" alt="Bank Image" width="400">
        </div>
      </div>
    </div>
  </section>

  <!-- 🔹 Footer -->
  <footer id="contact">
    <div class="container text-center">
      <h5 class="fw-bold mb-3">Vertex Bank</h5>
      <p>123 Finance Street, Dubai, UAE<br>
        Email: support@vertexbank.com | Phone: +971 500 123 456</p>
      <p class="mt-3 mb-0">&copy; 2025 Vertex Bank. All rights reserved.</p>
      <small>Designed with ❤️ by Vertex Tech Team</small>
    </div>
  </footer>

  <!-- Bootstrap JS -->
  <script 
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
  </script>
</body>
</html>
