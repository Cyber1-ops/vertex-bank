<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*, java.util.List, java.util.ArrayList, java.time.format.DateTimeFormatter"%>
    <%
  
    
    User user = (User) request.getAttribute("user");
    if (user == null) {
        user = (User) session.getAttribute("user");
    }
    
    String message = request.getParameter("message");
    
    // Get cards from request
    List<Card> cards = (List<Card>) request.getAttribute("cards");
    if (cards == null) cards = new ArrayList<>();
    
    // Get transactions from request
    List<TransactionRecord> transactions = (List<TransactionRecord>) request.getAttribute("transactions");
    if (transactions == null) transactions = new ArrayList<>();
    
    // Get stats
    Double monthlyIncome = (Double) request.getAttribute("monthlyIncome");
    if (monthlyIncome == null) monthlyIncome = 0.0;
    
    Double monthlyExpenses = (Double) request.getAttribute("monthlyExpenses");
    if (monthlyExpenses == null) monthlyExpenses = 0.0;
    
    Double totalSavings = (Double) request.getAttribute("totalSavings");
    if (totalSavings == null) totalSavings = 0.0;
    
    // Get account ID for transaction context
    Long userAccountId = (Long) request.getAttribute("userAccountId");
    
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM d, yyyy");
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");
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

  <link rel="stylesheet" href="css/style.css">
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
              <i class="bi bi-person-circle"></i> <%= user.getFullName() %>
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
          <a class="nav-link active" href="Dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>
          <a class="nav-link" href="accounts"><i class="bi bi-wallet2"></i> Accounts</a>
          <a class="nav-link" href="TransferServlet"><i class="bi bi-arrow-left-right"></i> Transfers</a>
          <a class="nav-link" href="CardServlet"><i class="bi bi-credit-card"></i> Cards</a>
          <a class="nav-link" href="#investments"><i class="bi bi-graph-up"></i> Investments</a>
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
          <h2>Welcome back, <%  out.print(user.getFullName()); %>! 👋</h2>
          <p class="text-muted">Here's what's happening with your account today.</p>
        </div>

        <!-- Balance Card -->
        <div class="row mb-4">
          <div class="col-12">
            <div class="card balance-card" id="accounts">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <p class="mb-1 opacity-75">Total Balance</p>
                  <h3><%double balance = (double) request.getAttribute("ACbalance"); out.print(balance);%></h3>
                  <p class="mb-3 opacity-75">Account: <%String ACnumber = (String) request.getAttribute("ACnumber"); out.print(ACnumber);%></p>
                  <div class="d-flex gap-2 flex-wrap">
                   <a href="TransferServlet" class="btn btn-primary quick-action-btn">
    <i class="bi bi-send"></i> Transfer
</a>

<a href="deposit" class="btn btn-primary quick-action-btn">
    <i class="bi bi-download"></i> Deposit
</a>

<button class="btn btn-primary quick-action-btn">
    <i class="bi bi-credit-card"></i> Pay Bills
</button>

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
        <div class="row mb-4 g-3" id="investments">
          <div class="col-md-4">
            <div class="card stat-card">
              <i class="bi bi-arrow-up-circle"></i>
              <h4><%= String.format("%.2f", monthlyIncome) %></h4>
              <p>Income This Month</p>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card">
              <i class="bi bi-arrow-down-circle"></i>
              <h4><%= String.format("%.2f", monthlyExpenses) %></h4>
              <p>Expenses This Month</p>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card stat-card">
              <i class="bi bi-graph-up-arrow"></i>
              <h4><%= String.format("%.2f", totalSavings) %></h4>
              <p>Total Savings</p>
            </div>
          </div>
        </div>

        <div class="row g-4">
          <!-- Recent Transactions -->
          <div class="col-lg-8">
            <div class="card" id="transactions">
              <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Recent Transactions</h5>
                <a href="TransferServlet" class="text-decoration-none">View All</a>
              </div>
              <div class="card-body p-0">
                <% if (transactions != null && !transactions.isEmpty()) { %>
                  <% for (TransactionRecord txn : transactions) { 
                      boolean isCredit = (userAccountId != null && txn.getToAccountId() != null && txn.getToAccountId().equals(userAccountId));
                      String iconClass = isCredit ? "credit" : "debit";
                      String amountClass = isCredit ? "credit" : "debit";
                      String amountPrefix = isCredit ? "+" : "-";
                      String description = txn.getDescription() != null ? txn.getDescription() : txn.getTransactionType();
                      String dateStr = "";
                      String timeStr = "";
                      if (txn.getTimestamp() != null) {
                          dateStr = txn.getTimestamp().format(dateFormatter);
                          timeStr = txn.getTimestamp().format(timeFormatter);
                      }
                  %>
                    <div class="transaction-item">
                      <div class="transaction-icon <%= iconClass %>">
                        <i class="bi bi-<%= isCredit ? "arrow-down" : "arrow-up" %>"></i>
                      </div>
                      <div class="transaction-details">
                        <h6><%= description %></h6>
                        <small><%= dateStr %> • <%= timeStr %></small>
                      </div>
                      <div class="transaction-amount <%= amountClass %>"><%= amountPrefix %><%= String.format("%.2f", txn.getAmount()) %></div>
                    </div>
                  <% } %>
                <% } else { %>
                  <div class="text-center py-5">
                    <i class="bi bi-inbox" style="font-size: 3rem; color: #cbd5e1; margin-bottom: 15px;"></i>
                    <p class="text-muted">No transactions found.</p>
                  </div>
                <% } %>
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
                <% if (cards != null && !cards.isEmpty()) { %>
                  <% for (Card card : cards) { %>
                    <div class="mb-3 p-3 rounded" style="background: linear-gradient(135deg, #0b1220 0%, #1e3a8a 100%); color: white;">
                      <div class="d-flex justify-content-between align-items-start mb-3">
                        <span style="font-size: 1.5rem;">💳</span>
                        <span class="badge <%= card.getStatus().equals("ACTIVE") ? "bg-success" : "bg-warning" %>">
                          <%= card.getStatus() %>
                        </span>
                      </div>
                      <p class="mb-1" style="font-size: 0.85rem; opacity: 0.8;">Card Number</p>
                      <p class="mb-2" style="font-size: 1.1rem; letter-spacing: 2px; font-family: 'Courier New', monospace;">
                        <%= card.getMaskedCardNumber() %>
                      </p>
                      <div class="d-flex justify-content-between">
                        <div>
                          <small style="opacity: 0.7;">Valid Thru</small><br>
                          <small>
                            <% if (card.getExpiryDate() != null) {
                                String expiryStr = card.getExpiryDate().toString();
                                // Format: YYYY-MM-DD -> MM/YY
                                String[] parts = expiryStr.split("-");
                                if (parts.length >= 2) {
                                  out.print(parts[1] + "/" + parts[0].substring(2));
                                } else {
                                  out.print("N/A");
                                }
                              } else {
                                out.print("N/A");
                              } %>
                          </small>
                        </div>
                        <div class="text-end">
                          <small style="opacity: 0.7;">Type</small><br>
                          <small><%= card.getCardType() %></small>
                        </div>
                      </div>
                    </div>
                  <% } %>
                  <a href="CardServlet" class="btn btn-primary w-100">Manage Cards</a>
                <% } else { %>
                  <div class="text-center py-4">
                    <i class="bi bi-credit-card-2-front" style="font-size: 3rem; color: #cbd5e1; margin-bottom: 15px;"></i>
                    <p class="text-muted mb-3">You don't have any cards yet.</p>
                    <a href="CardServlet" class="btn btn-primary w-100">
                      <i class="bi bi-plus-circle"></i> Apply for Card
                    </a>
                  </div>
                <% } %>
              </div>
            </div>

            <!-- Upcoming Bills -->
            <div class="card" id="statements">
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