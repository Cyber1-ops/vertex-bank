<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bank.models.AuditLog" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Audit Logs</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
	<link rel="stylesheet" href="css/style.css">

    <style>
        body {
            background: #f4f6f9;
            font-family: "Segoe UI", sans-serif;
        }
        .navbar-brand .badge {
            background-color: #2563eb;
            font-size: 0.65rem;
            padding: 4px 8px;
            margin-left: 8px;
        }
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        .page-title {
            font-size: 26px;
            font-weight: 600;
        }
        .search-box input {
            border-radius: 8px;
        }
        .badge-action {
            background: #0d6efd;
        }
        .badge-ip {
            background: #6c757d;
        }
        .badge-time {
            background: #198754;
        }
        .table-hover tbody tr:hover {
            background-color: #e9f3ff;
        }
        .content {
            padding: 20px;
        }
    </style>
</head>
<body>
  <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark py-2">
    <div class="container-fluid">
      <a class="navbar-brand" href="Admin">
        <i class="bi bi-arrow-left"></i> <img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img">
        <span class="badge">Admin</span>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-center">
          <li class="nav-item">
            <a class="nav-link" href="Admin">
              <i class="bi bi-speedometer2"></i> Back to Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="AuditLogServlet">
              <i class="bi bi-file-earmark-text"></i> Audit Logs
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

<div class="content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">Audit Logs</h2>

        <!-- Search Bar -->
        <form class="search-box d-flex gap-2" method="get" action="AuditLogServlet">
            <input type="text" class="form-control" name="search" placeholder="Search logs..." 
                   value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i></button>
            <% if (request.getAttribute("searchQuery") != null) { %>
                <a href="AuditLogServlet" class="btn btn-secondary"><i class="bi bi-x"></i> Clear</a>
            <% } %>
        </form>
    </div>

    <div class="table-container">
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-dark">
            <tr>
                <th>Log ID</th>
                <th>User ID</th>
                <th>Action</th>
                <th>IP Address</th>
                <th>Details</th>
                <th>Timestamp</th>
            </tr>
            </thead>
            <tbody>

            <%
                List<AuditLog> logs = (List<AuditLog>) request.getAttribute("logs");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                
                if (logs != null && !logs.isEmpty()) {
                    for (AuditLog log : logs) {
                        String timestampStr = "";
                        if (log.getTimestamp() != null) {
                            timestampStr = log.getTimestamp().format(formatter);
                        } else {
                            timestampStr = "N/A";
                        }
            %>
                <tr>
                    <td><%= log.getLogId() %></td>
                    <td>
                        <span class="badge bg-primary"><%= log.getUserId() %></span>
                    </td>
                    <td>
                        <span class="badge badge-action text-light"><%= log.getAction() != null ? log.getAction() : "N/A" %></span>
                    </td>
                    <td>
                        <span class="badge badge-ip text-light"><%= log.getIpAddress() != null ? log.getIpAddress() : "N/A" %></span>
                    </td>
                    <td><%= log.getDetails() != null ? log.getDetails() : "N/A" %></td>
                    <td>
                        <span class="badge badge-time text-light"><%= timestampStr %></span>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="6" class="text-center text-muted py-4">
                        No audit logs found.
                    </td>
                </tr>
            <%
                }
            %>

            </tbody>
        </table>

        <!-- Pagination -->
        <%
            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");
            Integer totalItems = (Integer) request.getAttribute("totalItems");
            if (currentPage == null) currentPage = 1;
            if (totalPages == null) totalPages = 1;
            if (totalItems == null) totalItems = 0;
            
            String searchParam = request.getAttribute("searchQuery") != null ? 
                "&search=" + java.net.URLEncoder.encode((String)request.getAttribute("searchQuery"), "UTF-8") : "";
        %>
        <nav class="mt-3">
            <div class="d-flex justify-content-between align-items-center">
                <span class="text-muted">Showing <%= (currentPage - 1) * 20 + 1 %> to <%= Math.min(currentPage * 20, totalItems) %> of <%= totalItems %> logs</span>
                <ul class="pagination justify-content-end mb-0">
                    <li class="page-item <%= currentPage <= 1 ? "disabled" : "" %>">
                        <a class="page-link" href="?page=<%= currentPage - 1 %><%= searchParam %>">Previous</a>
                    </li>
                    <% for (int i = Math.max(1, currentPage - 2); i <= Math.min(totalPages, currentPage + 2); i++) { %>
                        <li class="page-item <%= i == currentPage ? "active" : "" %>">
                            <a class="page-link" href="?page=<%= i %><%= searchParam %>"><%= i %></a>
                        </li>
                    <% } %>
                    <li class="page-item <%= currentPage >= totalPages ? "disabled" : "" %>">
                        <a class="page-link" href="?page=<%= currentPage + 1 %><%= searchParam %>">Next</a>
                    </li>
                </ul>
            </div>
        </nav>

    </div>
</div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
