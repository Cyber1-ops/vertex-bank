<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*, java.util.List, com.bank.models.Beneficiary"%>
<%
    User user = (User) session.getAttribute("user");
    List<Beneficiary> beneficiaries = (List<Beneficiary>) request.getAttribute("beneficiaries");
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Beneficiaries | Vertex Bank</title>

  <!-- Bootstrap CSS -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
    rel="stylesheet">
  
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

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

    .btn-danger {
      background-color: #dc2626;
      border: none;
    }

    .page-header {
      padding: 30px 0 20px 0;
    }

    .page-header h2 {
      font-weight: 700;
      color: #0b1220;
    }

    .beneficiary-card {
      border-left: 4px solid #2563eb;
      transition: all 0.3s ease;
    }

    .beneficiary-card:hover {
      border-left-color: #1d4ed8;
    }

    .beneficiary-icon {
      width: 50px;
      height: 50px;
      background: linear-gradient(135deg, #2563eb, #1d4ed8);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 1.2rem;
    }

    .empty-state {
      text-align: center;
      padding: 60px 20px;
      color: #64748b;
    }

    .empty-state i {
      font-size: 4rem;
      color: #cbd5e1;
      margin-bottom: 20px;
    }

    .modal-header {
      background-color: #0b1220;
      color: white;
    }

    .form-control:focus {
      border-color: #2563eb;
      box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25);
    }
  </style>
</head>

<body>
  <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark py-3">
    <div class="container-fluid">
      <a class="navbar-brand" href="Dashboard">Vertex Bank</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item">
            <a class="nav-link" href="#"><i class="bi bi-bell"></i> Notifications</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
               data-bs-toggle="dropdown" aria-expanded="false">
              <i class="bi bi-person-circle"></i> <%= user.getFullName() %>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
              <li><a class="dropdown-item" href="#"><i class="bi bi-person"></i> Profile</a></li>
              <li><a class="dropdown-item" href="#"><i class="bi bi-gear"></i> Settings</a></li>
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
          <a class="nav-link" href="#"><i class="bi bi-wallet2"></i> Accounts</a>
          <a class="nav-link" href="#"><i class="bi bi-arrow-left-right"></i> Transactions</a>
          <a class="nav-link" href="#"><i class="bi bi-credit-card"></i> Cards</a>
          <a class="nav-link" href="#"><i class="bi bi-graph-up"></i> Investments</a>
          <a class="nav-link" href="#"><i class="bi bi-file-text"></i> Statements</a>
          <a class="nav-link active" href="beneficiaries"><i class="bi bi-people"></i> Beneficiaries</a>
          <a class="nav-link" href="Support.jsp"><i class="bi bi-headset"></i> Support</a>
        </nav>
      </div>

      <!-- Main Content -->
      <div class="col-md-9 col-lg-10 p-4">
        <div class="page-header">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <h2>Beneficiaries Management</h2>
              <p class="text-muted">Manage your saved beneficiaries for quick transfers</p>
            </div>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBeneficiaryModal">
              <i class="bi bi-plus-circle"></i> Add Beneficiary
            </button>
          </div>
        </div>

        <% if (message != null) { %>
          <div class="alert alert-info alert-dismissible fade show" role="alert">
            <i class="bi bi-info-circle"></i> <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        <% } %>

        <div class="row">
          <% if (beneficiaries != null && !beneficiaries.isEmpty()) { %>
            <% for (Beneficiary beneficiary : beneficiaries) { %>
              <div class="col-md-6 col-lg-4 mb-4">
                <div class="card beneficiary-card h-100">
                  <div class="card-body">
                    <div class="d-flex align-items-start mb-3">
                      <div class="beneficiary-icon me-3">
                        <i class="bi bi-person"></i>
                      </div>
                      <div class="flex-grow-1">
                        <h5 class="card-title mb-1"><%= beneficiary.getBeneficiaryName() %></h5>
                        <p class="text-muted mb-2"><%= beneficiary.getBankName() %></p>
                        <p class="card-text">
                          <small class="text-muted">Account Number:</small><br>
                          <strong><%= beneficiary.getAccountNumber() %></strong>
                        </p>
                      </div>
                    </div>
                    <div class="d-flex justify-content-between">
                      <small class="text-muted">
                        Added: <%= beneficiary.getAddedAt() %>
                      </small>
                      <div>
                        <a href="TransferServlet" 
                           class="btn btn-success btn-sm">
                          <i class="bi bi-send"></i> Transfer
                        </a>
                        <form action="Deletebeneficiary" method="post" class="d-inline">
                          <input type="hidden" name="beneficiary_id" value="<%= beneficiary.getBeneficiaryId() %>">
                          <button type="submit" class="btn btn-danger btn-sm" 
                                  onclick="return confirm('Are you sure you want to delete this beneficiary?')">
                            <i class="bi bi-trash"></i>
                          </button>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            <% } %>
          <% } else { %>
            <div class="col-12">
              <div class="card">
                <div class="empty-state">
                  <i class="bi bi-people"></i>
                  <h4>No Beneficiaries Added</h4>
                  <p class="mb-4">You haven't added any beneficiaries yet. Add your first beneficiary to start making quick transfers.</p>
                  <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBeneficiaryModal">
                    <i class="bi bi-plus-circle"></i> Add Your First Beneficiary
                  </button>
                </div>
              </div>
            </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>

  <!-- Add Beneficiary Modal -->
  <div class="modal fade" id="addBeneficiaryModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add New Beneficiary</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <form action="beneficiaryServlet" method="post">
          <div class="modal-body">
            <div class="mb-3">
              <label for="beneficiaryName" class="form-label">Beneficiary Name *</label>
              <input type="text" class="form-control" id="beneficiaryName" name="beneficiary_name" required>
            </div>
            <div class="mb-3">
              <label for="accountNumber" class="form-label">Account Number *</label>
              <input type="text" class="form-control" id="accountNumber" name="account_number" required>
            </div>
            <div class="mb-3">
              <label for="bankName" class="form-label">Bank Name *</label>
              <input type="text" class="form-control" id="bankName" name="bank_name" required>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-primary">Add Beneficiary</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>