<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Account account = (Account) request.getAttribute("account");
    if (account == null) {
        account = com.bank.utils.DatabaseUtil.getAccount(user.getUserId());
    }
    
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Deposit Money | Vertex Bank</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
    }
    .deposit-method-card {
      border: 2px solid #e2e8f0;
      border-radius: 15px;
      padding: 25px;
      cursor: pointer;
      transition: all 0.3s ease;
      height: 100%;
    }
    .deposit-method-card:hover {
      border-color: #2563eb;
      transform: translateY(-5px);
      box-shadow: 0 10px 30px rgba(37, 99, 235, 0.15);
    }
    .deposit-method-card.active {
      border-color: #2563eb;
      background-color: #eff6ff;
    }
    .method-icon {
      font-size: 3rem;
      color: #2563eb;
      margin-bottom: 15px;
    }
    .form-section {
      display: none;
    }
    .form-section.active {
      display: block;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark py-2">
    <div class="container-fluid">
      <a class="navbar-brand" href="Dashboard"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item"><a class="nav-link" href="Dashboard">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link" href="TransferServlet">Transfer</a></li>
          <li class="nav-item"><a class="nav-link active" href="deposit">Deposit</a></li>
          <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <h2 class="mb-4">Deposit Money</h2>
        
        <% if (success != null) { %>
          <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle-fill me-2"></i><%= success %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        <% } %>
        
        <% if (error != null) { %>
          <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        <% } %>

        <div class="card mb-4">
          <div class="card-body">
            <h5>Account Information</h5>
            <p class="mb-1"><strong>Account Number:</strong> <%= account != null ? account.getAccountNumber() : "N/A" %></p>
            <p class="mb-1"><strong>Current Balance:</strong> <%= account != null ? String.format("%.2f", account.getBalance()) : "0.00" %> <%= account != null ? account.getCurrency() : "" %></p>
          </div>
        </div>

        <form action="deposit" method="post" id="depositForm">
          <div class="row g-4 mb-4">
            <div class="col-md-4">
              <div class="deposit-method-card" onclick="selectMethod('card')">
                <div class="method-icon"><i class="bi bi-credit-card"></i></div>
                <h5>Card Payment</h5>
                <p class="text-muted mb-0">Deposit using debit/credit card</p>
                <input type="radio" name="deposit_method" value="card" id="method_card" style="display: none;">
              </div>
            </div>
            <div class="col-md-4">
              <div class="deposit-method-card" onclick="selectMethod('atm')">
                <div class="method-icon"><i class="bi bi-bank"></i></div>
                <h5>ATM Deposit</h5>
                <p class="text-muted mb-0">Find nearby ATM locations</p>
                <input type="radio" name="deposit_method" value="atm" id="method_atm" style="display: none;">
              </div>
            </div>
            <div class="col-md-4">
              <div class="deposit-method-card" onclick="selectMethod('paypal')">
                <div class="method-icon"><i class="bi bi-paypal"></i></div>
                <h5>PayPal</h5>
                <p class="text-muted mb-0">Deposit via PayPal account</p>
                <input type="radio" name="deposit_method" value="paypal" id="method_paypal" style="display: none;">
              </div>
            </div>
          </div>

          <!-- Card Payment Form -->
          <div class="form-section card" id="form_card">
            <div class="card-body">
              <h5 class="mb-3">Card Payment Details</h5>
              <div class="mb-3">
                <label class="form-label">Card Number</label>
                <input type="text" class="form-control" placeholder="1234 5678 9012 3456" maxlength="19">
              </div>
              <div class="row">
                <div class="col-md-6 mb-3">
                  <label class="form-label">Expiry Date</label>
                  <input type="text" class="form-control" placeholder="MM/YY" maxlength="5">
                </div>
                <div class="col-md-6 mb-3">
                  <label class="form-label">CVV</label>
                  <input type="text" class="form-control" placeholder="123" maxlength="3">
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label">Cardholder Name</label>
                <input type="text" class="form-control" placeholder="John Doe">
              </div>
            </div>
          </div>

          <!-- ATM Deposit Form -->
          <div class="form-section card" id="form_atm">
            <div class="card-body">
              <h5 class="mb-3">Select ATM Location</h5>
              <div class="mb-3">
                <label class="form-label">ATM Location</label>
                <select class="form-select" name="atm_location" required>
                  <option value="">Select an ATM location</option>
                  <option value="Dubai Mall - Main Entrance">Dubai Mall - Main Entrance</option>
                  <option value="Burj Khalifa - Ground Floor">Burj Khalifa - Ground Floor</option>
                  <option value="Dubai Marina - Walkway">Dubai Marina - Walkway</option>
                  <option value="JBR - Beach Walk">JBR - Beach Walk</option>
                  <option value="Downtown Dubai - Financial Center">Downtown Dubai - Financial Center</option>
                  <option value="Dubai Airport - Terminal 1">Dubai Airport - Terminal 1</option>
                  <option value="Dubai Airport - Terminal 3">Dubai Airport - Terminal 3</option>
                  <option value="Mall of the Emirates - Food Court">Mall of the Emirates - Food Court</option>
                </select>
              </div>
              <div class="alert alert-info">
                <i class="bi bi-info-circle me-2"></i>
                Visit the selected ATM location and deposit cash. The amount will be credited to your account within 2-4 hours.
              </div>
            </div>
          </div>

          <!-- PayPal Deposit Form -->
          <div class="form-section card" id="form_paypal">
            <div class="card-body">
              <h5 class="mb-3">PayPal Deposit Details</h5>
              <div class="mb-3">
                <label class="form-label">PayPal Email</label>
                <input type="email" class="form-control" name="paypal_email" placeholder="your.email@example.com" required>
              </div>
              <div class="alert alert-info">
                <i class="bi bi-info-circle me-2"></i>
                You will be redirected to PayPal to complete the payment. Ensure your PayPal account has sufficient funds.
              </div>
            </div>
          </div>

          <!-- Amount Input (Common for all methods) -->
          <div class="card mb-4">
            <div class="card-body">
              <h5 class="mb-3">Deposit Amount</h5>
              <div class="mb-3">
                <label class="form-label">Amount</label>
                <input type="number" class="form-control" name="amount" step="0.01" min="0.01" placeholder="0.00" required>
              </div>
              <small class="text-muted">Minimum deposit: 10.00 <%= account != null ? account.getCurrency() : "AED" %></small>
            </div>
          </div>

          <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary px-5">
              <i class="bi bi-check-circle me-2"></i>Complete Deposit
            </button>
            <a href="Dashboard" class="btn btn-secondary px-5">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function selectMethod(method) {
      // Remove active class from all cards
      document.querySelectorAll('.deposit-method-card').forEach(card => {
        card.classList.remove('active');
      });
      
      // Hide all form sections
      document.querySelectorAll('.form-section').forEach(section => {
        section.classList.remove('active');
      });
      
      // Activate selected method
      document.getElementById('method_' + method).checked = true;
      event.currentTarget.classList.add('active');
      document.getElementById('form_' + method).classList.add('active');
    }

    document.getElementById('depositForm').addEventListener('submit', function(e) {
      const method = document.querySelector('input[name="deposit_method"]:checked');
      if (!method) {
        e.preventDefault();
        alert('Please select a deposit method');
        return false;
      }
    });
  </script>
</body>
</html>

