<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*, java.util.List, java.util.ArrayList"%>
<%
    // Session check
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Get data from request
    List<CardApplication> applications = (List<CardApplication>) request.getAttribute("applications");
    Integer pendingCount = (Integer) request.getAttribute("pendingCount");
    Integer totalCards = (Integer) request.getAttribute("totalCards");
    
    if (applications == null) applications = new ArrayList<>();
    if (pendingCount == null) pendingCount = 0;
    if (totalCards == null) totalCards = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Card Management | Admin Panel | Vertex Bank</title>

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

    .badge-pending {
      background-color: #fef3c7;
      color: #d97706;
    }

    .badge-approved {
      background-color: #d1fae5;
      color: #047857;
    }

    .badge-rejected {
      background-color: #fee2e2;
      color: #dc2626;
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

    .btn-success {
      background-color: #10b981;
      border: none;
      transition: all 0.3s ease;
      padding: 8px 16px;
    }

    .btn-success:hover {
      background-color: #059669;
    }

    .btn-danger {
      background-color: #ef4444;
      border: none;
      transition: all 0.3s ease;
      padding: 8px 16px;
    }

    .btn-danger:hover {
      background-color: #dc2626;
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
      <a class="navbar-brand" href="Admin">
        <img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"> <span class="badge">Admin</span>
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
                <%= pendingCount %>
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
          <a class="nav-link" href="Admin"><i class="bi bi-speedometer2"></i> Dashboard</a>
          <a class="nav-link" href="AdminUsers"><i class="bi bi-people"></i> Users</a>
          <a class="nav-link" href="AdminAccounts"><i class="bi bi-wallet2"></i> Accounts</a>
          <a class="nav-link" href="AdminTransactions"><i class="bi bi-arrow-left-right"></i> Transactions</a>
          
          <div class="section-title">Management</div>
          <a class="nav-link active" href="AdminCardServlet"><i class="bi bi-credit-card"></i> Cards</a>
          <a class="nav-link" href="AdminReports"><i class="bi bi-exclamation-triangle"></i> Reports</a>
          
          <div class="section-title">System</div>
          <a class="nav-link" href="AdminSecurity"><i class="bi bi-shield-check"></i> Security</a>
          <a class="nav-link" href="AuditLogServlet"><i class="bi bi-file-earmark-text"></i> Logs</a>
        </nav>
      </div>

      <!-- Main Content -->
      <div class="col-md-9 col-lg-10 p-4">
        <div class="page-header d-flex justify-content-between align-items-center">
          <div>
            <h2><i class="bi bi-credit-card"></i> Card Management</h2>
            <p class="text-muted mb-0">Review and manage card applications</p>
          </div>
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

        <!-- Statistics Cards -->
        <div class="row g-3 mb-4">
          <div class="col-lg-4 col-md-6">
            <div class="card stat-card warning">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <p>Pending Applications</p>
                  <h3><%= pendingCount %></h3>
                  <small class="text-warning"><i class="bi bi-clock"></i> Needs Review</small>
                </div>
                <div class="icon-wrapper">
                  <i class="bi bi-hourglass-split"></i>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6">
            <div class="card stat-card success">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <p>Total Cards</p>
                  <h3><%= totalCards %></h3>
                  <small class="text-success"><i class="bi bi-check-circle"></i> Active</small>
                </div>
                <div class="icon-wrapper">
                  <i class="bi bi-credit-card-2-front"></i>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6">
            <div class="card stat-card primary">
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <p>Total Applications</p>
                  <h3><%= applications.size() %></h3>
                  <small class="text-muted"><i class="bi bi-list-ul"></i> All Time</small>
                </div>
                <div class="icon-wrapper">
                  <i class="bi bi-file-earmark-text"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Card Applications Table -->
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="bi bi-file-earmark-text"></i> Card Applications</h5>
            <div class="search-box" style="width: 250px;">
              <i class="bi bi-search"></i>
              <input type="text" class="form-control form-control-sm" id="searchInput" placeholder="Search applications...">
            </div>
          </div>
          <div class="table-responsive">
            <table class="table" id="applicationsTable">
              <thead>
                <tr>
                  <th>Application ID</th>
                  <th>User ID</th>
                  <th>Account ID</th>
                  <th>Card Type</th>
                  <th>Status</th>
                  <th>Applied Date</th>
                  <th>Processed Date</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <% if (applications != null && !applications.isEmpty()) { %>
                  <% for (CardApplication app : applications) { %>
                    <tr>
                      <td><span class="text-muted">#APP-<%= app.getApplicationId() %></span></td>
                      <td><%= app.getUserId() %></td>
                      <td><%= app.getAccountId() %></td>
                      <td><span class="badge bg-light text-dark"><%= app.getCardType() %></span></td>
                      <td>
                        <span class="badge <%= app.getStatus().equals("PENDING") ? "badge-pending" : 
                                              app.getStatus().equals("APPROVED") ? "badge-approved" : "badge-rejected" %>">
                          <%= app.getStatus() %>
                        </span>
                      </td>
                      <td><%= app.getAppliedAt() != null ? app.getAppliedAt().toString() : "N/A" %></td>
                      <td><%= app.getProcessedAt() != null ? app.getProcessedAt().toString() : "N/A" %></td>
                      <td>
                        <% if (app.getStatus().equals("PENDING")) { %>
                          <form action="AdminCardServlet" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="approve">
                            <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                            <button type="submit" class="btn btn-success btn-sm" onclick="return confirm('Are you sure you want to approve this card application?')">
                              <i class="bi bi-check-circle"></i> Approve
                            </button>
                          </form>
                          <form action="AdminCardServlet" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="reject">
                            <input type="hidden" name="application_id" value="<%= app.getApplicationId() %>">
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to reject this card application?')">
                              <i class="bi bi-x-circle"></i> Reject
                            </button>
                          </form>
                        <% } else { %>
                          <span class="text-muted">Processed</span>
                        <% } %>
                      </td>
                    </tr>
                  <% } %>
                <% } else { %>
                  <tr>
                    <td colspan="8" class="text-center py-5">
                      <i class="bi bi-inbox" style="font-size: 3rem; color: #cbd5e1;"></i>
                      <p class="text-muted mt-3">No card applications found</p>
                    </td>
                  </tr>
                <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <script>
    // Simple search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
      const searchTerm = this.value.toLowerCase();
      const table = document.getElementById('applicationsTable');
      const rows = table.getElementsByTagName('tr');
      
      for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(searchTerm) ? '' : 'none';
      }
    });
  </script>
</body>
</html>

