<%@ page language="java" import="com.bank.models.*,com.bank.utils.*, java.util.List, java.time.format.DateTimeFormatter" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    List<TransactionRecord> transactions = (List<TransactionRecord>) request.getAttribute("transactions");
    if (transactions == null) transactions = new java.util.ArrayList<>();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Panel | Vertex Bank</title>

  <!-- Bootstrap CSS -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
    rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
  <%  User user =(User)request.getSession().getAttribute("user");
  
  if(user == null || user.getEmail() == null ){
	  response.sendRedirect("index.jsp");
	  return;
  } %>
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8fafc;
      color: #1e293b;
    }

    .navbar-brand .badge {
      background-color: #2563eb;
      font-size: 0.65rem;
      padding: 4px 8px;
      margin-left: 8px;
    }

    .sidebar {
      background-color: #0b1220;
      min-height: calc(100vh - 76px);
      padding: 20px 0;
      position: sticky;
      top: 0;
    }

    .sidebar .nav-link {
      color: #cbd5e1;
      padding: 12px 20px;
      margin: 4px 10px;
      border-radius: 8px;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
    }

    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
      background-color: #1e3a8a;
      color: #60a5fa;
    }

    .sidebar .nav-link i {
      margin-right: 10px;
      width: 20px;
      font-size: 1.1rem;
    }

    .sidebar .section-title {
      color: #64748b;
      font-size: 0.75rem;
      text-transform: uppercase;
      letter-spacing: 1px;
      padding: 20px 20px 10px 20px;
      font-weight: 600;
    }

    .card {
      border: none;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      margin-bottom: 20px;
    }

    .card-header {
      background-color: transparent;
      border-bottom: 1px solid #e2e8f0;
      font-weight: 600;
      padding: 1rem 1.5rem;
    }

    .stat-card {
      padding: 25px;
      border-left: 4px solid #2563eb;
    }

    .stat-card.warning {
      border-left-color: #f59e0b;
    }

    .stat-card.success {
      border-left-color: #10b981;
    }

    .stat-card.danger {
      border-left-color: #ef4444;
    }

    .stat-card h3 {
      font-size: 2rem;
      font-weight: 700;
      margin: 10px 0 5px 0;
      color: #1e293b;
    }

    .stat-card p {
      color: #64748b;
      margin: 0;
      font-size: 0.9rem;
    }

    .stat-card .icon-wrapper {
      width: 50px;
      height: 50px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
    }

    .stat-card.primary .icon-wrapper {
      background-color: #dbeafe;
      color: #2563eb;
    }

    .stat-card.warning .icon-wrapper {
      background-color: #fef3c7;
      color: #f59e0b;
    }

    .stat-card.success .icon-wrapper {
      background-color: #d1fae5;
      color: #10b981;
    }

    .stat-card.danger .icon-wrapper {
      background-color: #fee2e2;
      color: #ef4444;
    }

    .table-responsive {
      border-radius: 8px;
    }

    .table {
      margin-bottom: 0;
    }

    .table thead {
      background-color: #f8fafc;
    }

    .table th {
      border-bottom: 2px solid #e2e8f0;
      color: #475569;
      font-weight: 600;
      font-size: 0.85rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      padding: 15px;
    }

    .table td {
      padding: 15px;
      vertical-align: middle;
      color: #1e293b;
    }

    .table tbody tr {
      border-bottom: 1px solid #f1f5f9;
      transition: background-color 0.2s ease;
    }

    .table tbody tr:hover {
      background-color: #f8fafc;
    }

    .badge {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 600;
    }

    .badge-active {
      background-color: #d1fae5;
      color: #047857;
    }

    .badge-inactive {
      background-color: #fee2e2;
      color: #dc2626;
    }

    .badge-pending {
      background-color: #fef3c7;
      color: #d97706;
    }

    .badge-verified {
      background-color: #dbeafe;
      color: #1d4ed8;
    }

    .btn-primary {
      background-color: #2563eb;
      border: none;
      transition: all 0.3s ease;
      padding: 8px 16px;
    }

    .btn-primary:hover {
      background-color: #1d4ed8;
    }

    .btn-sm {
      padding: 6px 12px;
      font-size: 0.85rem;
    }

    .page-header {
      padding: 30px 0 20px 0;
    }

    .page-header h2 {
      font-weight: 700;
      color: #0b1220;
    }

    .search-box {
      position: relative;
    }

    .search-box input {
      padding-left: 40px;
      border-radius: 8px;
      border: 1px solid #e2e8f0;
    }

    .search-box i {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #64748b;
    }

    .action-btn {
      padding: 6px 10px;
      border-radius: 6px;
      border: none;
      background-color: transparent;
      color: #64748b;
      transition: all 0.2s ease;
      margin: 0 2px;
    }

    .action-btn:hover {
      background-color: #f1f5f9;
      color: #1e293b;
    }

    .action-btn.edit:hover {
      background-color: #dbeafe;
      color: #2563eb;
    }

    .action-btn.delete:hover {
      background-color: #fee2e2;
      color: #dc2626;
    }

    .chart-container {
      padding: 20px;
      height: 300px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
      border-radius: 8px;
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
      <a class="navbar-brand" href="Admin.jsp">
        <img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img">
        <span class="badge">Admin</span>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item">
            <a class="nav-link position-relative" href="#">
              <i class="bi bi-bell"></i>
              <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">
                5
              </span>
            </a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
               data-bs-toggle="dropdown" aria-expanded="false">
              <i class="bi bi-person-circle"></i> Admin User
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
              <li><a class="dropdown-item" href="#"><i class="bi bi-person"></i> Profile</a></li>
              <li><a class="dropdown-item" href="#"><i class="bi bi-gear"></i> Settings</a></li>
              <li><a class="dropdown-item" href="#"><i class="bi bi-shield-check"></i> Security</a></li>
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
          <div class="section-title">Main</div>
          <a class="nav-link active" href="Admin"><i class="bi bi-speedometer2"></i> Dashboard</a>
          <a class="nav-link" href="AdminUsers"><i class="bi bi-people"></i> Users</a>
          <a class="nav-link" href="AdminAccounts"><i class="bi bi-wallet2"></i> Accounts</a>
          <a class="nav-link" href="AdminTransactions"><i class="bi bi-arrow-left-right"></i> Transactions</a>
          
          <div class="section-title">Management</div>
          <a class="nav-link" href="AdminCardServlet"><i class="bi bi-credit-card"></i> Cards</a>
          <a class="nav-link" href="#"><i class="bi bi-cash-stack"></i> Loans</a>
          <a class="nav-link" href="#"><i class="bi bi-graph-up"></i> Investments</a>
          <a class="nav-link" href="AdminReports"><i class="bi bi-exclamation-triangle"></i> Reports</a>
          
          <div class="section-title">System</div>
          <a class="nav-link" href="#"><i class="bi bi-gear"></i> Settings</a>
          <a class="nav-link" href="AdminSecurity"><i class="bi bi-shield-check"></i> Security</a>
          <a class="nav-link" href="AuditLogServlet"><i class="bi bi-file-earmark-text"></i> Logs</a>
          <a class="nav-link" href="Support.jsp"><i class="bi bi-headset"></i> Support</a>
        </nav>
      </div>

      <!-- Main Content -->
      <div class="col-md-9 col-lg-10 p-4">
        <div class="page-header d-flex justify-content-between align-items-center">
          <div>
            <h2>Admin Dashboard</h2>
            <p class="text-muted mb-0">Monitor and manage your banking system</p>
          </div>
          <button class="btn btn-primary">
            <i class="bi bi-download"></i> Generate Report
          </button>
        </div>

        <!-- Statistics Cards -->
        <div class="row g-3 mb-4">
          <div class="col-lg-3 col-md-6">
            <div class="card stat-card primary">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <p>Total Users</p>
                  <h3><% int USER =(int) request.getAttribute("Ucount");
                  out.print(USER); %></h3>
                  <small class="text-success"><i class="bi bi-arrow-up"></i> +12.5%</small>
                </div>
                <div class="icon-wrapper">
                  <i class="bi bi-people"></i>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-3 col-md-6">
            <div class="card stat-card success">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <p>Total Balance</p>
                  <h3><% double balance = (Double) request.getAttribute("allbalance");
                  out.print(balance);%></h3>
                  <small class="text-success"><i class="bi bi-arrow-up"></i> +8.2%</small>
                </div>
                <div class="icon-wrapper">
                  <i class="bi bi-cash-stack"></i>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-3 col-md-6">
            <div class="card stat-card warning">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <p>Pending Card Applications</p>
                  <h3><% 
                    Integer pendingCards = (Integer) request.getAttribute("pendingCardApps");
                    if (pendingCards == null) pendingCards = 0;
                    out.print(pendingCards); 
                  %></h3>
                  <small class="text-warning"><i class="bi bi-clock"></i> Needs Review</small>
                </div>
                <div class="icon-wrapper">
                  <i class="bi bi-hourglass-split"></i>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-3 col-md-6">
            <div class="card stat-card danger">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <p>Active Loans</p>
                  <h3>1,247</h3>
                  <small class="text-muted"><i class="bi bi-dash"></i> No change</small>
                </div>
                <div class="icon-wrapper">
                  <i class="bi bi-bank"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Transactions & Quick Stats -->
        <div class="row mb-4">
          <div class="col-lg-8">
            <div class="card">
              <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Recent Transactions</h5>
                <div class="search-box" style="width: 250px;">
                  <i class="bi bi-search"></i>
                  <input type="text" class="form-control form-control-sm" placeholder="Search transactions...">
                </div>
              </div>
              <div class="table-responsive">
                <table class="table">
                  <thead>
                    <tr>
                      <th>Transaction ID</th>
                      <th>User</th>
                      <th>Type</th>
                      <th>Amount</th>
                      <th>Date</th>
                      <th>Status</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% if (transactions != null && !transactions.isEmpty()) { %>
                      <% for (TransactionRecord txn : transactions) { 
                          String timestampStr = txn.getTimestamp() != null ? txn.getTimestamp().format(formatter) : "N/A";
                      %>
                        <tr>
                          <td><span class="text-muted">#TXN-<%= txn.getTransactionId() %></span></td>
                          <td>
                            <div class="d-flex align-items-center">
                              <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-2" style="width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;">
                                <i class="bi bi-person text-primary"></i>
                              </div>
                              <span>Account <%= txn.getFromAccountId() != null ? txn.getFromAccountId() : "N/A" %></span>
                            </div>
                          </td>
                          <td><%= txn.getTransactionType() != null ? txn.getTransactionType() : "TRANSFER" %></td>
                          <td class="fw-bold text-success">+<%= String.format("%.2f", txn.getAmount()) %></td>
                          <td><%= timestampStr %></td>
                          <td><span class="badge badge-active">Completed</span></td>
                          <td>
                            <button class="action-btn" title="View"><i class="bi bi-eye"></i></button>
                          </td>
                        </tr>
                      <% } %>
                    <% } else { %>
                      <tr>
                        <td colspan="7" class="text-center text-muted py-4">No transactions found</td>
                      </tr>
                    <% } %>
                  </tbody>
                </table>
              </div>
              <div class="card-body border-top">
                <div class="d-flex justify-content-between align-items-center">
                  <span class="text-muted">Showing <%= transactions != null ? transactions.size() : 0 %> recent transactions</span>
                  <a href="AdminTransactions" class="btn btn-sm btn-primary">View All Transactions</a>
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
