<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open Account - Vertex Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        .sidebar {
            background-color: #0b1220;
            min-height: calc(100vh - 76px);
            padding: 20px 0;
        }

        .sidebar .nav-link {
            color: #cbd5e1;
            padding: 12px 20px;
            margin: 4px 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: #1e3a8a;
            color: #60a5fa;
        }

        .sidebar .nav-link i {
            margin-right: 10px;
            width: 20px;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .card-header {
            background-color: transparent;
            border-bottom: 1px solid #e2e8f0;
            font-weight: 600;
            padding: 1rem 1.5rem;
        }

        .page-header {
            padding: 30px 0 20px 0;
        }

        .page-header h2 {
            font-weight: 700;
            color: #0b1220;
        }

        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 40px;
            margin-bottom: 40px;
        }

        .form-section {
            margin-bottom: 30px;
            padding: 25px;
            background: #f8fafc;
            border-radius: 10px;
            border-left: 4px solid #2563eb;
        }

        .section-title {
            color: #1e3a8a;
            font-weight: 700;
            font-size: 1.3rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: #2563eb;
        }

        .form-label {
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 12px 16px;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: #60a5fa;
            box-shadow: 0 0 0 4px rgba(96, 165, 250, 0.1);
        }

        .input-group-text {
            background: #f1f5f9;
            border: 2px solid #e2e8f0;
            color: #475569;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #2563eb;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
        }

        .btn-success {
            background-color: #16a34a;
            border: none;
        }

        .btn-outline-secondary {
            border: 2px solid #e2e8f0;
            color: #64748b;
        }

        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 40px;
            position: relative;
        }

        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            color: #64748b;
            position: relative;
            margin: 0 20px;
        }

        .step.active {
            background: #2563eb;
            color: white;
        }

        .step-line {
            position: absolute;
            top: 50%;
            left: 50px;
            right: 50px;
            height: 2px;
            background: #e2e8f0;
            transform: translateY(-50%);
        }

        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .alert-success {
            background: #dcfce7;
            border: 1px solid #16a34a;
            color: #166534;
            border-radius: 8px;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }
            .sidebar {
                min-height: auto;
            }
        }
    </style>
</head>
<body>
  <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark py-3">
    <div class="container-fluid">
      <a class="navbar-brand" href="Dashboard"><i class="fas fa-university me-2"></i>Vertex Bank</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item">
            <a class="nav-link" href="Dashboard"><i class="fas fa-home"></i> Dashboard</a>
          </li>
          <li class="nav-item">
            <form action="logout" method="post" class="d-inline">
              <button type="submit" class="btn btn-link nav-link p-0 border-0">
                <i class="fas fa-sign-out-alt"></i> Logout
              </button>
            </form>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <div class="col-md-3 col-lg-2 p-0 sidebar d-none d-md-block">
        <nav class="nav flex-column">
          <a class="nav-link" href="Dashboard"><i class="fas fa-speedometer2"></i> Dashboard</a>
          <a class="nav-link active" href="#"><i class="fas fa-plus-circle"></i> Open Account</a>
          <a class="nav-link" href="#"><i class="fas fa-wallet2"></i> Accounts</a>
          <a class="nav-link" href="#"><i class="fas fa-arrow-left-right"></i> Transactions</a>
          <a class="nav-link" href="#"><i class="fas fa-credit-card"></i> Cards</a>
          <a class="nav-link" href="#"><i class="fas fa-people"></i> Beneficiaries</a>
          <a class="nav-link" href="#"><i class="fas fa-headset"></i> Support</a>
        </nav>
      </div>

      <!-- Main Content -->
      <div class="col-md-9 col-lg-10 p-4">
        <div class="page-header">
          <h2><i class="fas fa-plus-circle me-2"></i>Open New Account</h2>
          <p class="text-muted">Complete your application to open a new bank account</p>
        </div>

        <div class="form-container">
          <!-- Error Display - ADDED AT THE TOP -->
          <% String error = (String) request.getAttribute("error"); %>
          <% if(error != null && !error.isEmpty()) { %>
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                  <i class="fas fa-exclamation-triangle me-2"></i><%= error %>
                  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
          <% } %>

          <!-- Step Indicator -->
          <div class="step-indicator">
            <div class="step active">1</div>
            <div class="step-line"></div>
            <div class="step">2</div>
            <div class="step-line"></div>
            <div class="step">3</div>
          </div>

          <form id="accountForm" action="<%= request.getContextPath() %>/open-account" method="post">
            <!-- Step 1: Personal Information -->
            <div class="form-section">
              <div class="section-title">
                <i class="fas fa-user"></i>Personal Information
              </div>
              
              <div class="row g-3">
                <div class="col-md-6">
                  <label class="form-label">Full Name *</label>
                  <input type="text" class="form-control" name="full_name" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Phone Number *</label>
                  <input type="tel" class="form-control" name="phone" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Date of Birth *</label>
                  <input type="date" class="form-control" name="dob" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Age *</label>
                  <input type="number" class="form-control" name="age" min="18" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Nationality *</label>
                  <input type="text" class="form-control" name="nationality" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Passport Number *</label>
                  <input type="text" class="form-control" name="passport_number" required>
                </div>
              </div>
            </div>

            <!-- Step 2: Identification & Address -->
            <div class="form-section">
              <div class="section-title">
                <i class="fas fa-id-card"></i>Identification & Address
              </div>
              
              <div class="row g-3">
                <div class="col-12">
                  <label class="form-label">Emirates ID / National ID *</label>
                  <input type="text" class="form-control" name="id_number" required>
                </div>
                <div class="col-12">
                  <label class="form-label">Residential Address *</label>
                  <textarea class="form-control" name="address" rows="3" required></textarea>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Monthly Income (AED) *</label>
                  <div class="input-group">
                    <span class="input-group-text">AED</span>
                    <input type="number" class="form-control" name="monthly_income" min="0" required>
                  </div>
                </div>
              </div>
            </div>

            <!-- Step 3: Account Details -->
            <div class="form-section">
              <div class="section-title">
                <i class="fas fa-wallet"></i>Account Details
              </div>
              
              <div class="row g-3">
                <div class="col-md-6">
                  <label class="form-label">Account Type *</label>
                  <select class="form-select" name="account_type" required>
                    <option value="">Choose account type...</option>
                    <option value="SAVINGS">Savings Account</option>
                    <option value="CURRENT">Current Account</option>
                    <option value="FIXED_DEPOSIT">Fixed Deposit</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Currency *</label>
                  <select class="form-select" name="currency" required>
                    <option value="">Select currency...</option>
                    <option value="AED">AED - UAE Dirham</option>
                    <option value="USD">USD - US Dollar</option>
                    <option value="EUR">EUR - Euro</option>
                  </select>
                </div>
                <div class="col-12">
                  <label class="form-label">Initial Deposit (AED) *</label>
                  <div class="input-group">
                    <span class="input-group-text">AED</span>
                    <input type="number" class="form-control" name="initial_deposit" min="0" required>
                  </div>
                </div>
              </div>
            </div>

            <!-- Submit Button -->
            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
              <a href="Dashboard" class="btn btn-outline-secondary me-md-2">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
              </a>
              <button type="submit" class="btn btn-success">
                <i class="fas fa-check-circle me-2"></i>Submit Application
              </button>
            </div>
          </form>
        </div>
        <!-- REMOVED THE EXTRA EMPTY FORM CONTAINER -->
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>