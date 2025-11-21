<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*, java.util.List, java.util.ArrayList"%>
<%
    // Session check
    User user = (User) session.getAttribute("user");
    
    // Get data from request
    List<Account> accounts = (List<Account>) request.getAttribute("accounts");
    List<Card> cards = (List<Card>) request.getAttribute("cards");
    List<CardApplication> applications = (List<CardApplication>) request.getAttribute("applications");
    
    if (accounts == null) accounts = new ArrayList<>();
    if (cards == null) cards = new ArrayList<>();
    if (applications == null) applications = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cards | Vertex Bank</title>

  <!-- Bootstrap CSS -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
    rel="stylesheet">
  
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/style.css">

  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
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
      padding: 1.25rem 1.5rem;
    }

    .page-header {
      padding: 30px 0 20px 0;
    }

    .page-header h2 {
      font-weight: 700;
      color: #0b1220;
    }

    .card-display {
      background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
      color: white;
      padding: 30px;
      border-radius: 12px;
      margin-bottom: 20px;
      position: relative;
      overflow: hidden;
    }

    .card-display::before {
      content: '';
      position: absolute;
      top: -50%;
      right: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
    }

    .card-display h5 {
      font-size: 0.9rem;
      opacity: 0.9;
      margin-bottom: 10px;
    }

    .card-display .card-number {
      font-size: 1.5rem;
      font-weight: 600;
      letter-spacing: 2px;
      margin: 15px 0;
      font-family: 'Courier New', monospace;
    }

    .card-display .card-info {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
      font-size: 0.9rem;
    }

    .badge-status {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 600;
    }

    .badge-active {
      background-color: #dcfce7;
      color: #16a34a;
    }

    .badge-blocked {
      background-color: #fee2e2;
      color: #dc2626;
    }

    .badge-pending {
      background-color: #fef3c7;
      color: #d97706;
    }

    .badge-approved {
      background-color: #dcfce7;
      color: #16a34a;
    }

    .badge-rejected {
      background-color: #fee2e2;
      color: #dc2626;
    }

    .btn-primary {
      background-color: #2563eb;
      border: none;
      padding: 12px 30px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #1d4ed8;
      transform: translateY(-2px);
    }

    .btn-danger {
      background-color: #dc2626;
      border: none;
      padding: 8px 20px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-danger:hover {
      background-color: #b91c1c;
    }

    .btn-success {
      background-color: #16a34a;
      border: none;
      padding: 8px 20px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-success:hover {
      background-color: #15803d;
    }

    .form-label {
      font-weight: 600;
      color: #334155;
      margin-bottom: 8px;
    }

    .form-control, .form-select {
      border: 2px solid #e2e8f0;
      border-radius: 8px;
      padding: 12px 16px;
      font-size: 1rem;
    }

    .form-control:focus, .form-select:focus {
      border-color: #60a5fa;
      box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.1);
    }

    .card-item {
      padding: 20px;
      border-bottom: 1px solid #f1f5f9;
      transition: background-color 0.2s ease;
    }

    .card-item:hover {
      background-color: #f8fafc;
    }

    .card-item:last-child {
      border-bottom: none;
    }

    @media (max-width: 768px) {
      .sidebar {
        min-height: auto;
      }
    }
  </style>
</head>

<body>
  <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark py-2">
    <div class="container-fluid">
      <a class="navbar-brand" href="Dashboard"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item">
            <a class="nav-link" href="Support.jsp"><i class="bi bi-headset"></i> Support</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
               data-bs-toggle="dropdown" aria-expanded="false">
              <i class="bi bi-person-circle"></i> <%= user.getUsername() %>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
              <li><a class="dropdown-item" href="profile"><i class="bi bi-person"></i> Profile</a></li>
              <li><a class="dropdown-item" href="settings"><i class="bi bi-gear"></i> Settings</a></li>
              <li><a class="dropdown-item" href="accounts"><i class="bi bi-wallet2"></i> Accounts</a></li>
              <li><a class="dropdown-item" href="statement"><i class="bi bi-file-text"></i> Statement</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
            </ul>
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
          <a class="nav-link" href="Dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
          <a class="nav-link" href="accounts"><i class="bi bi-wallet2"></i> Accounts</a>
          <a class="nav-link" href="TransferServlet"><i class="bi bi-arrow-left-right"></i> Transfer</a>
          <a class="nav-link" href="Dashboard#transactions"><i class="bi bi-clock-history"></i> Transactions</a>
          <a class="nav-link active" href="CardServlet"><i class="bi bi-credit-card"></i> Cards</a>
          <a class="nav-link" href="Dashboard#investments"><i class="bi bi-graph-up"></i> Investments</a>
          <a class="nav-link" href="statement"><i class="bi bi-file-text"></i> Statements</a>
          <a class="nav-link" href="beneficiaryServlet"><i class="bi bi-people"></i> Beneficiaries</a>
          <a class="nav-link" href="profile"><i class="bi bi-person"></i> Profile</a>
          <a class="nav-link" href="settings"><i class="bi bi-gear"></i> Settings</a>
          <a class="nav-link" href="Support.jsp"><i class="bi bi-headset"></i> Support</a>
        </nav>
      </div>

      <!-- Main Content -->
      <div class="col-md-9 col-lg-10 p-4">
        <div class="page-header">
          <h2><i class="bi bi-credit-card"></i> My Cards</h2>
          <p class="text-muted">Manage your debit and credit cards</p>
        </div>

        <!-- Alert Messages -->
        <% String error = (String) request.getAttribute("error");
           String success = (String) request.getAttribute("success");
        %>

        <% if (error != null) { %>
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        <% } %>

        <% if (success != null) { %>
          <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> <%= success %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        <% } %>

        <div class="row">
          <!-- My Cards -->
          <div class="col-lg-8">
            <div class="card mb-4">
              <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-credit-card-2-front"></i> My Cards</h5>
              </div>
              <div class="card-body p-0">
                <% if (cards != null && !cards.isEmpty()) { %>
                  <% for (Card card : cards) { %>
                    <div class="card-item">
                      <div class="d-flex justify-content-between align-items-center">
                        <div class="flex-grow-1">
                          <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-credit-card-2-front me-2" style="font-size: 1.5rem; color: #2563eb;"></i>
                            <div>
                              <h6 class="mb-0"><%= card.getCardType() %> Card</h6>
                              <small class="text-muted"><%= card.getMaskedCardNumber() %></small>
                            </div>
                          </div>
                          <div class="mt-2">
                            <small class="text-muted">Expires: <%= card.getExpiryDate() != null ? card.getExpiryDate().toString() : "N/A" %></small>
                            <span class="badge badge-status <%= card.getStatus().equals("ACTIVE") ? "badge-active" : "badge-blocked" %> ms-2">
                              <%= card.getStatus() %>
                            </span>
                          </div>
                        </div>
                        <div>
                          <% if (card.getStatus().equals("ACTIVE")) { %>
                            <form action="CardServlet" method="post" style="display: inline;">
                              <input type="hidden" name="action" value="block">
                              <input type="hidden" name="card_id" value="<%= card.getCardId() %>">
                              <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to block this card?')">
                                <i class="bi bi-lock"></i> Block
                              </button>
                            </form>
                          <% } else if (card.getStatus().equals("BLOCKED")) { %>
                            <form action="CardServlet" method="post" style="display: inline;">
                              <input type="hidden" name="action" value="activate">
                              <input type="hidden" name="card_id" value="<%= card.getCardId() %>">
                              <button type="submit" class="btn btn-success btn-sm">
                                <i class="bi bi-unlock"></i> Activate
                              </button>
                            </form>
                          <% } %>
                        </div>
                      </div>
                    </div>
                  <% } %>
                <% } else { %>
                  <div class="text-center py-5">
                    <i class="bi bi-credit-card-2-front" style="font-size: 3rem; color: #cbd5e1;"></i>
                    <p class="text-muted mt-3">No cards found. Apply for a new card below.</p>
                  </div>
                <% } %>
              </div>
            </div>

            <!-- Card Applications -->
            <div class="card">
              <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-file-earmark-text"></i> Card Applications</h5>
              </div>
              <div class="card-body p-0">
                <% if (applications != null && !applications.isEmpty()) { %>
                  <% for (CardApplication app : applications) { %>
                    <div class="card-item">
                      <div class="d-flex justify-content-between align-items-center">
                        <div>
                          <h6 class="mb-1"><%= app.getCardType() %> Card Application</h6>
                          <small class="text-muted">
                            Applied: <%= app.getAppliedAt() != null ? app.getAppliedAt().toString() : "N/A" %>
                            <% if (app.getProcessedAt() != null) { %>
                              | Processed: <%= app.getProcessedAt().toString() %>
                            <% } %>
                          </small>
                        </div>
                        <span class="badge badge-status 
                          <%= app.getStatus().equals("APPROVED") ? "badge-approved" : 
                              app.getStatus().equals("REJECTED") ? "badge-rejected" : "badge-pending" %>">
                          <%= app.getStatus() %>
                        </span>
                      </div>
                    </div>
                  <% } %>
                <% } else { %>
                  <div class="text-center py-4">
                    <p class="text-muted mb-0">No card applications found.</p>
                  </div>
                <% } %>
              </div>
            </div>
          </div>

          <!-- Apply for New Card -->
          <div class="col-lg-4">
            <div class="card">
              <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-plus-circle"></i> Apply for New Card</h5>
              </div>
              <div class="card-body">
                <form action="CardServlet" method="post">
                  <input type="hidden" name="action" value="apply">
                  
                  <div class="mb-3">
                    <label for="account_id" class="form-label">Select Account *</label>
                    <select class="form-select" id="account_id" name="account_id" required>
                      <option value="">Choose an account</option>
                      <% if (accounts != null) {
                          for (Account acc : accounts) { %>
                            <option value="<%= acc.getAccountId() %>">
                              <%= acc.getAccountNumber() %> - <%= acc.getAccountType() %> 
                              (<%= acc.getCurrency() %> <%= String.format("%.2f", acc.getBalance()) %>)
                            </option>
                      <% } } %>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label for="card_type" class="form-label">Card Type *</label>
                    <select class="form-select" id="card_type" name="card_type" required>
                      <option value="">Choose card type</option>
                      <option value="DEBIT">Debit Card</option>
                      <option value="CREDIT">Credit Card</option>
                    </select>
                  </div>

                  <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i>
                    <small>Your application will be reviewed and processed within 2-3 business days.</small>
                  </div>

                  <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-send"></i> Submit Application
                  </button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

