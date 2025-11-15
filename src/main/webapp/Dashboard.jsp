<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*"%>
    <%
    // 🔒 Session check
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get user from request attributes (set by Dashboard.java)
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
    
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Dashboard | Vertex Bank</title>

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

    .balance-card {
      background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
      color: white;
      padding: 30px;
    }

    .balance-card h3 {
      font-size: 2.5rem;
      font-weight: 700;
      margin: 10px 0;
    }

    .quick-action-btn {
      background-color: white;
      color: #1e3a8a;
      border: none;
      padding: 12px 24px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .quick-action-btn:hover {
      background-color: #f1f5f9;
      transform: translateY(-2px);
    }

    .stat-card {
      text-align: center;
      padding: 20px;
    }

    .stat-card i {
      font-size: 2.5rem;
      color: #2563eb;
      margin-bottom: 10px;
    }

    .stat-card h4 {
      font-size: 1.8rem;
      font-weight: 700;
      margin: 10px 0 5px 0;
      color: #1e293b;
    }

    .stat-card p {
      color: #64748b;
      font-size: 0.9rem;
      margin: 0;
    }

    .transaction-item {
      display: flex;
      align-items: center;
      padding: 15px;
      border-bottom: 1px solid #f1f5f9;
      transition: background-color 0.2s ease;
    }

    .transaction-item:hover {
      background-color: #f8fafc;
    }

    .transaction-item:last-child {
      border-bottom: none;
    }

    .transaction-icon {
      width: 45px;
      height: 45px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 15px;
      font-size: 1.2rem;
    }

    .transaction-icon.credit {
      background-color: #dcfce7;
      color: #16a34a;
    }

    .transaction-icon.debit {
      background-color: #fee2e2;
      color: #dc2626;
    }

    .transaction-details {
      flex-grow: 1;
    }

    .transaction-details h6 {
      margin: 0 0 4px 0;
      font-weight: 600;
      color: #1e293b;
    }

    .transaction-details small {
      color: #64748b;
    }

    .transaction-amount {
      font-weight: 700;
      font-size: 1.1rem;
    }

    .transaction-amount.credit {
      color: #16a34a;
    }

    .transaction-amount.debit {
      color: #dc2626;
    }

    .btn-primary {
      background-color: #2563eb;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #1d4ed8;
    }

    .page-header {
      padding: 30px 0 20px 0;
    }

    .page-header h2 {
      font-weight: 700;
      color: #0b1220;
    }

    .badge-status {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 600;
    }

    .badge-completed {
      background-color: #dcfce7;
      color: #16a34a;
    }

    .badge-pending {
      background-color: #fef3c7;
      color: #d97706;
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
  <nav class="navbar navbar-expand-lg navbar-dark py-3">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Vertex Bank</a>
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
              <i class="bi bi-person-circle"></i> 
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
          <a class="nav-link active" href="#"><i class="bi bi-speedometer2"></i> Dashboard</a>
          <a class="nav-link" href="#"><i class="bi bi-wallet2"></i> Accounts</a>
          <a class="nav-link" href="#"><i class="bi bi-arrow-left-right"></i> Transactions</a>
          <a class="nav-link" href="#"><i class="bi bi-credit-card"></i> Cards</a>
          <a class="nav-link" href="#"><i class="bi bi-graph-up"></i> Investments</a>
          <a class="nav-link" href="#"><i class="bi bi-file-text"></i> Statements</a>
          <a class="nav-link" href="#"><i class="bi bi-people"></i> Beneficiaries</a>
          <a class="nav-link" href="#"><i class="bi bi-headset"></i> Support</a>
        </nav>
      </div>

      <!-- Main Content -->
      <div class="col-md-9 col-lg-10 p-4">
        <div class="page-header">
          <h2>Welcome back, <%  out.print(user.getFullName()); %>! 👋</h2>
          <p class="text-muted">Here's what's happening with your account today.</p>
        </div>

        <!-- Balance Card -->
        <div class="row mb-4">
          <div class="col-12">
            <div class="card balance-card">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <p class="mb-1 opacity-75">Total Balance</p>
                  <h3><%double balance = (double) request.getAttribute("ACbalance"); out.print(balance);%></h3>
                  <p class="mb-3 opacity-75">Account: <%String ACnumber = (String) request.getAttribute("ACnumber"); out.print(ACnumber);%></p>
                  <div class="d-flex gap-2 flex-wrap">
                    <button class="quick-action-btn"><i class="bi bi-send"></i> Transfer</button>
                    <button class="quick-action-btn"><i class="bi bi-download"></i> Deposit</button>
                    <button class="quick-action-btn"><i class="bi bi-credit-card"></i> Pay Bills</button>
                  </div>
                </div>
                <div class="col-md-4 text-center d-none d-md-block">
                  <i class="bi bi-piggy-bank" style="font-size: 6rem; opacity: 0.2;"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Stats Cards -->
        <div class="row mb-4 g-3">
          <div class="col-md-4">
            <div class="card stat-card">
              <i class="bi bi-arrow-up-circle"></i>
              <h4>$12,450</h4>
              <p>Income This Month</p>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card">
              <i class="bi bi-arrow-down-circle"></i>
              <h4>$8,230</h4>
              <p>Expenses This Month</p>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card">
              <i class="bi bi-graph-up-arrow"></i>
              <h4>$28,560</h4>
              <p>Total Savings</p>
            </div>
          </div>
        </div>

        <div class="row g-4">
          <!-- Recent Transactions -->
          <div class="col-lg-8">
            <div class="card">
              <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Recent Transactions</h5>
                <a href="#" class="text-decoration-none">View All</a>
              </div>
              <div class="card-body p-0">
                <div class="transaction-item">
                  <div class="transaction-icon credit">
                    <i class="bi bi-arrow-down"></i>
                  </div>
                  <div class="transaction-details">
                    <h6>Salary Deposit</h6>
                    <small>Nov 5, 2025 • 09:30 AM</small>
                  </div>
                  <div class="transaction-amount credit">+$5,200.00</div>
                </div>

                <div class="transaction-item">
                  <div class="transaction-icon debit">
                    <i class="bi bi-arrow-up"></i>
                  </div>
                  <div class="transaction-details">
                    <h6>Rent Payment</h6>
                    <small>Nov 3, 2025 • 02:15 PM</small>
                  </div>
                  <div class="transaction-amount debit">-$1,500.00</div>
                </div>

                <div class="transaction-item">
                  <div class="transaction-icon debit">
                    <i class="bi bi-cart"></i>
                  </div>
                  <div class="transaction-details">
                    <h6>Shopping - Amazon</h6>
                    <small>Nov 2, 2025 • 05:45 PM</small>
                  </div>
                  <div class="transaction-amount debit">-$245.50</div>
                </div>

                <div class="transaction-item">
                  <div class="transaction-icon credit">
                    <i class="bi bi-arrow-down"></i>
                  </div>
                  <div class="transaction-details">
                    <h6>Freelance Project</h6>
                    <small>Nov 1, 2025 • 11:20 AM</small>
                  </div>
                  <div class="transaction-amount credit">+$1,800.00</div>
                </div>

                <div class="transaction-item">
                  <div class="transaction-icon debit">
                    <i class="bi bi-lightning"></i>
                  </div>
                  <div class="transaction-details">
                    <h6>Utility Bill</h6>
                    <small>Oct 31, 2025 • 08:00 AM</small>
                  </div>
                  <div class="transaction-amount debit">-$185.30</div>
                </div>
              </div>
            </div>
          </div>

          <!-- Quick Actions & Cards -->
          <div class="col-lg-4">
            <!-- Active Cards -->
            <div class="card mb-4">
              <div class="card-header">
                <h5 class="mb-0">My Cards</h5>
              </div>
              <div class="card-body">
                <div class="mb-3 p-3 rounded" style="background: linear-gradient(135deg, #0b1220 0%, #1e3a8a 100%); color: white;">
                  <div class="d-flex justify-content-between align-items-start mb-3">
                    <span style="font-size: 1.5rem;">💳</span>
                    <span class="badge bg-light text-dark">Active</span>
                  </div>
                  <p class="mb-1" style="font-size: 0.85rem; opacity: 0.8;">Card Number</p>
                  <p class="mb-2" style="font-size: 1.1rem; letter-spacing: 2px;">**** 4589</p>
                  <div class="d-flex justify-content-between">
                    <div>
                      <small style="opacity: 0.7;">Valid Thru</small><br>
                      <small>12/27</small>
                    </div>
                    <div class="text-end">
                      <small style="opacity: 0.7;">CVV</small><br>
                      <small>***</small>
                    </div>
                  </div>
                </div>
                <button class="btn btn-primary w-100">Manage Cards</button>
              </div>
            </div>

            <!-- Upcoming Bills -->
            <div class="card">
              <div class="card-header">
                <h5 class="mb-0">Upcoming Bills</h5>
              </div>
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <div>
                    <h6 class="mb-1">Internet Bill</h6>
                    <small class="text-muted">Due: Nov 10</small>
                  </div>
                  <span class="fw-bold">$89.99</span>
                </div>
                <div class="d-flex justify-content-between align-items-center mb-3">
                  <div>
                    <h6 class="mb-1">Phone Bill</h6>
                    <small class="text-muted">Due: Nov 15</small>
                  </div>
                  <span class="fw-bold">$55.00</span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="mb-1">Insurance</h6>
                    <small class="text-muted">Due: Nov 20</small>
                  </div>
                  <span class="fw-bold">$250.00</span>
                </div>
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