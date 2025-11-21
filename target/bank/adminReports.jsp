<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*, java.util.List"%>
<%
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"ADMIN".equals(adminUser.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Double totalBalance = (Double) request.getAttribute("totalBalance");
    List<TransactionRecord> recentTransactions = (List<TransactionRecord>) request.getAttribute("recentTransactions");
    
    if (totalUsers == null) totalUsers = 0;
    if (totalBalance == null) totalBalance = 0.0;
    if (recentTransactions == null) recentTransactions = new java.util.ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reports | Vertex Bank Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8fafc; }
    .sidebar { background-color: #0b1220; min-height: calc(100vh - 76px); padding: 20px 0; }
    .sidebar .nav-link { color: #cbd5e1; padding: 12px 20px; margin: 4px 10px; border-radius: 8px; }
    .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #1e3a8a; color: #60a5fa; }
    .card { border: none; border-radius: 12px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08); }
    .stat-card { padding: 25px; border-left: 4px solid #2563eb; }
    .stat-card h3 { font-size: 2rem; font-weight: 700; margin: 10px 0 5px 0; }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark py-2">
    <div class="container-fluid">
      <a class="navbar-brand" href="Admin"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"> <span class="badge">Admin</span></a>
      <div class="collapse navbar-collapse justify-content-end">
        <ul class="navbar-nav">
          <li class="nav-item"><a class="nav-link" href="Admin">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container-fluid">
    <div class="row">
      <div class="col-md-3 col-lg-2 p-0 sidebar d-none d-md-block">
        <nav class="nav flex-column">
          <a class="nav-link" href="Admin"><i class="bi bi-speedometer2"></i> Dashboard</a>
          <a class="nav-link" href="AdminUsers"><i class="bi bi-people"></i> Users</a>
          <a class="nav-link" href="AdminAccounts"><i class="bi bi-wallet2"></i> Accounts</a>
          <a class="nav-link" href="AdminTransactions"><i class="bi bi-arrow-left-right"></i> Transactions</a>
          <a class="nav-link" href="AdminCardServlet"><i class="bi bi-credit-card"></i> Cards</a>
          <a class="nav-link active" href="AdminReports"><i class="bi bi-exclamation-triangle"></i> Reports</a>
          <a class="nav-link" href="AdminSecurity"><i class="bi bi-shield-check"></i> Security</a>
          <a class="nav-link" href="AuditLogServlet"><i class="bi bi-file-earmark-text"></i> Logs</a>
        </nav>
      </div>
      <div class="col-md-9 col-lg-10 p-4">
        <h2 class="mb-4">System Reports</h2>
        
        <div class="row g-3 mb-4">
          <div class="col-md-4">
            <div class="card stat-card">
              <p class="text-muted mb-0">Total Users</p>
              <h3><%= totalUsers %></h3>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card">
              <p class="text-muted mb-0">Total Balance</p>
              <h3><%= String.format("%.2f", totalBalance) %></h3>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card">
              <p class="text-muted mb-0">Recent Transactions</p>
              <h3><%= recentTransactions.size() %></h3>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">Recent Transaction Activity</h5>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>Transaction ID</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Timestamp</th>
                  </tr>
                </thead>
                <tbody>
                  <% if (recentTransactions != null && !recentTransactions.isEmpty()) { %>
                    <% for (TransactionRecord txn : recentTransactions) { %>
                      <tr>
                        <td><%= txn.getTransactionId() %></td>
                        <td><span class="badge bg-primary"><%= txn.getTransactionType() %></span></td>
                        <td><strong><%= String.format("%.2f", txn.getAmount()) %></strong></td>
                        <td><%= txn.getTimestamp() != null ? txn.getTimestamp().toString() : "N/A" %></td>
                      </tr>
                    <% } %>
                  <% } else { %>
                    <tr><td colspan="4" class="text-center">No transactions found</td></tr>
                  <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

