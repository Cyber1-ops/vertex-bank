<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bank.models.*, java.util.List"%>
<%
    // Session check
    User user = (User) session.getAttribute("user");
   
    // Get user's accounts from request
    List<Account> accounts = (List<Account>) request.getAttribute("accounts");
    
    // Get beneficiaries from request
    List<Beneficiary> beneficiaries = (List<Beneficiary>) request.getAttribute("beneficiaries");
    
 
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Transfer Money | Vertex Bank</title>

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

    .navbar-brand .logo-img {
      height: 40px;
      width: auto;
      max-width: 150px;
      object-fit: contain;
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
      padding: 1.25rem 1.5rem;
    }

    .page-header {
      padding: 30px 0 20px 0;
    }

    .page-header h2 {
      font-weight: 700;
      color: #0b1220;
    }

    .transfer-type-card {
      padding: 25px;
      cursor: pointer;
      transition: all 0.3s ease;
      border: 2px solid transparent;
      text-align: center;
    }

    .transfer-type-card:hover {
      border-color: #2563eb;
      background-color: #f0f9ff;
    }

    .transfer-type-card.active {
      border-color: #2563eb;
      background-color: #eff6ff;
    }

    .transfer-type-card i {
      font-size: 3rem;
      color: #2563eb;
      margin-bottom: 15px;
    }

    .transfer-type-card h5 {
      font-weight: 600;
      margin-bottom: 8px;
    }

    .transfer-type-card p {
      color: #64748b;
      font-size: 0.9rem;
      margin: 0;
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

    .btn-secondary {
      background-color: #64748b;
      border: none;
      padding: 12px 30px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-secondary:hover {
      background-color: #475569;
    }

    .account-badge {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 0.85rem;
      font-weight: 600;
      background-color: #dbeafe;
      color: #1e40af;
      margin-left: 8px;
    }

    .beneficiary-item {
      padding: 15px;
      border: 2px solid #e2e8f0;
      border-radius: 8px;
      margin-bottom: 10px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .beneficiary-item:hover {
      border-color: #2563eb;
      background-color: #f8fafc;
    }

    .beneficiary-item.selected {
      border-color: #2563eb;
      background-color: #eff6ff;
    }

    .info-box {
      background-color: #eff6ff;
      border-left: 4px solid #2563eb;
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
    }

    .info-box i {
      color: #2563eb;
      font-size: 1.2rem;
      margin-right: 10px;
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
          <a class="nav-link active" href="TransferServlet"><i class="bi bi-arrow-left-right"></i> Transfer</a>
          <a class="nav-link" href="Dashboard#transactions"><i class="bi bi-clock-history"></i> Transactions</a>
          <a class="nav-link" href="CardServlet"><i class="bi bi-credit-card"></i> Cards</a>
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
          <h2><i class="bi bi-arrow-left-right"></i> Transfer Money</h2>
          <p class="text-muted">Send money to your accounts or to others</p>
        </div>

        <!-- Alert Messages -->      
        <%  String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");
        %>

        <% if (error != null) { %>
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        <%} %>

        <% 
          // Get transfer details from request (passed from servlet)
          String transferAmount = (String) request.getAttribute("transferAmount");
          String transferFrom = (String) request.getAttribute("transferFrom");
          String transferTo = (String) request.getAttribute("transferTo");
        %>
        
        <% if (success != null){ %>
          <script>
            // Show success modal on page load if success message exists
            window.addEventListener('load', function() {
              <% if (transferAmount != null) { %>
                document.getElementById('successAmount').textContent = '<%= transferAmount.replace("'", "\\'") %>';
              <% } %>
              <% if (transferFrom != null) { %>
                document.getElementById('successFrom').textContent = '<%= transferFrom.replace("'", "\\'") %>';
              <% } %>
              <% if (transferTo != null) { %>
                document.getElementById('successTo').textContent = '<%= transferTo.replace("'", "\\'") %>';
              <% } %>
              
              // Small delay to ensure DOM is ready
              setTimeout(function() {
                var successModalElement = document.getElementById('successModal');
                if (successModalElement) {
                  var successModal = new bootstrap.Modal(successModalElement);
                  successModal.show();
                }
              }, 100);
            });
          </script>
        <%} %>
        <!-- Transfer Type Selection -->
        <div class="row mb-4 g-3">
          <div class="col-md-4">
            <div class="card transfer-type-card active" id="ownAccountCard" onclick="selectTransferType('own')">
              <i class="bi bi-arrow-repeat"></i>
              <h5>Own Account</h5>
              <p>Transfer between your accounts</p>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card transfer-type-card" id="beneficiaryCard" onclick="selectTransferType('beneficiary')">
              <i class="bi bi-people"></i>
              <h5>To Beneficiary</h5>
              <p>Send to saved beneficiaries</p>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card transfer-type-card" id="newCard" onclick="selectTransferType('new')">
              <i class="bi bi-person-plus"></i>
              <h5>New Recipient</h5>
              <p>Transfer to any account</p>
            </div>
          </div>
        </div>

        <!-- Transfer Form -->
        <div class="row">
          <div class="col-lg-8">
            <div class="card">
              <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-send"></i> Transfer Details</h5>
              </div>
              <div class="card-body p-4">
                <form action="TransferServlet" method="post" id="transferForm">
                  <input type="hidden" name="transfer_type" id="transferType" value="OWN_ACCOUNT">

                  <!-- From Account -->
                  <div class="mb-4">
                    <label for="fromAccount" class="form-label">From Account *</label>
                    <select class="form-select" id="fromAccount" name="from_account_id" required onchange="updateAvailableBalance()">
                      <option value="">Select Source Account</option>
                      <% if (accounts != null) {
                          for (Account acc : accounts) { %>
                            <option value="<%= acc.getAccountId() %>" 
                                    data-balance="<%= acc.getBalance() %>"
                                    data-currency="<%= acc.getCurrency() %>">
                              <%= acc.getAccountNumber() %> - <%= acc.getAccountType() %> 
                              (<%= acc.getCurrency() %> <%= String.format("%.2f", acc.getBalance()) %>)
                            </option>
                      <% } } %>
                    </select>
                    <small class="text-muted" id="availableBalance"></small>
                  </div>

                  <!-- To Account (Own Account Transfer) -->
                  <div class="mb-4" id="toOwnAccountDiv">
                    <label for="toOwnAccount" class="form-label">To Account *</label>
                    <select class="form-select" id="toOwnAccount" name="to_own_account_id">
                      <option value="">Select Destination Account</option>
                      <% if (accounts != null) {
                          for (Account acc : accounts) { %>
                            <option value="<%= acc.getAccountId() %>">
                              <%= acc.getAccountNumber() %> - <%= acc.getAccountType() %> 
                              (<%= acc.getCurrency() %>)
                            </option>
                      <% } } %>
                    </select>
                  </div>

                  <!-- Beneficiary Selection (Beneficiary Transfer) -->
                  <div class="mb-4 d-none" id="toBeneficiaryDiv">
                    <label for="toBeneficiary" class="form-label">Select Beneficiary *</label>
                    <select class="form-select" id="toBeneficiary" name="beneficiary_id" required onchange="updateSummary()">
                      <option value="">Select Beneficiary</option>
                      <% if (beneficiaries != null && !beneficiaries.isEmpty()) {
                          for (Beneficiary ben : beneficiaries) { %>
                            <option value="<%= ben.getBeneficiaryId() %>">
                              <%= ben.getBeneficiaryName() %> - <%= ben.getAccountNumber() %> (<%= ben.getBankName() %>)
                            </option>
                      <% } } %>
                    </select>
                    <% if (beneficiaries == null || beneficiaries.isEmpty()) { %>
                      <div class="alert alert-info mt-2">
                        <i class="bi bi-info-circle"></i> No beneficiaries found. <a href="beneficiaryServlet">Add a beneficiary</a>
                      </div>
                    <% } %>
                  </div>

                  <!-- New Recipient (New Transfer) -->
                  <div class="d-none" id="toNewAccountDiv">
                    <div class="mb-3">
                      <label for="recipientAccount" class="form-label">Recipient Account Number *</label>
                      <input type="text" class="form-control" id="recipientAccount" 
                             name="recipient_account_number" placeholder="Enter account number">
                    </div>
                    <div class="mb-3">
                      <label for="recipientName" class="form-label">Recipient Name *</label>
                      <input type="text" class="form-control" id="recipientName" 
                             name="recipient_name" placeholder="Enter recipient name">
                    </div>
                    <div class="mb-4">
                      <label for="bankName" class="form-label">Bank Name *</label>
                      <input type="text" class="form-control" id="bankName" 
                             name="bank_name" placeholder="Enter bank name">
                    </div>
                  </div>

                  <!-- Amount -->
                  <div class="mb-4">
                    <label for="amount" class="form-label">Amount *</label>
                    <div class="input-group">
                      <span class="input-group-text" id="currencySymbol">AED</span>
                      <input type="number" class="form-control" id="amount" name="amount" 
                             placeholder="0.00" step="0.01" min="1" required>
                    </div>
                  </div>

                  <!-- Description -->
                  <div class="mb-4">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" 
                              rows="3" placeholder="Enter transfer description" required></textarea>
                  </div>

                  <!-- Info Box -->
                  <div class="info-box">
                    <i class="bi bi-info-circle"></i>
                    <span>Transfers are processed instantly. Please verify all details before confirming.</span>
                  </div>

                  <!-- Buttons -->
                  <div class="d-flex gap-3 justify-content-end">
                    <a href="Dashboard" class="btn btn-secondary">
                      <i class="bi bi-x-circle"></i> Cancel
                    </a>
                    <button type="button" class="btn btn-primary" onclick="showConfirmationModal()">
                      <i class="bi bi-send"></i> Transfer Money
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <!-- Transfer Summary -->
          <div class="col-lg-4">
            <div class="card">
              <div class="card-header">
                <h5 class="mb-0"><i class="bi bi-receipt"></i> Transfer Summary</h5>
              </div>
              <div class="card-body">
                <div class="mb-3">
                  <small class="text-muted">Transfer Type</small>
                  <p class="mb-0 fw-bold" id="summaryType">Own Account Transfer</p>
                </div>
                <div class="mb-3">
                  <small class="text-muted">From Account</small>
                  <p class="mb-0" id="summaryFrom">Not selected</p>
                </div>
                <div class="mb-3">
                  <small class="text-muted">To Account</small>
                  <p class="mb-0" id="summaryTo">Not selected</p>
                </div>
                <div class="mb-3">
                  <small class="text-muted">Amount</small>
                  <p class="mb-0 fw-bold fs-4 text-primary" id="summaryAmount">AED 0.00</p>
                </div>
                <hr>
                <div class="d-flex justify-content-between">
                  <small class="text-muted">Transfer Fee</small>
                  <small class="fw-bold">AED 0.00</small>
                </div>
                <div class="d-flex justify-content-between mt-2">
                  <small class="text-muted">Total</small>
                  <small class="fw-bold" id="summaryTotal">AED 0.00</small>
                </div>
              </div>
            </div>

            <!-- Recent Transfers -->
            <div class="card mt-3">
              <div class="card-header">
                <h6 class="mb-0"><i class="bi bi-clock-history"></i> Recent Transfers</h6>
              </div>
              <div class="card-body p-2">
                <small class="text-muted d-block text-center py-3">
                  No recent transfers
                </small>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Confirmation Modal -->
  <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header" style="background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%); color: white;">
          <h5 class="modal-title" id="confirmationModalLabel">
            <i class="bi bi-shield-check"></i> Confirm Transfer
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="text-center mb-4">
            <i class="bi bi-arrow-left-right" style="font-size: 3rem; color: #2563eb;"></i>
            <h5 class="mt-3">Please review your transfer details</h5>
            <p class="text-muted">Make sure all information is correct before confirming</p>
          </div>
          
          <div class="card" style="background-color: #f8fafc; border: 2px solid #e2e8f0;">
            <div class="card-body">
              <div class="row mb-3">
                <div class="col-5"><strong>Transfer Type:</strong></div>
                <div class="col-7" id="modalTransferType"></div>
              </div>
              <hr>
              <div class="row mb-3">
                <div class="col-5"><strong>From Account:</strong></div>
                <div class="col-7" id="modalFromAccount"></div>
              </div>
              <div class="row mb-3">
                <div class="col-5"><strong>To Account:</strong></div>
                <div class="col-7" id="modalToAccount"></div>
              </div>
              <hr>
              <div class="row mb-3">
                <div class="col-5"><strong>Amount:</strong></div>
                <div class="col-7">
                  <span class="fw-bold fs-5 text-primary" id="modalAmount"></span>
                </div>
              </div>
              <div class="row mb-3">
                <div class="col-5"><strong>Description:</strong></div>
                <div class="col-7" id="modalDescription"></div>
              </div>
              <hr>
              <div class="row">
                <div class="col-5"><strong>Transfer Fee:</strong></div>
                <div class="col-7">AED 0.00</div>
              </div>
              <div class="row mt-2">
                <div class="col-5"><strong>Total Amount:</strong></div>
                <div class="col-7">
                  <span class="fw-bold fs-5 text-primary" id="modalTotal"></span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            <i class="bi bi-x-circle"></i> Cancel
          </button>
          <button type="button" class="btn btn-primary" onclick="confirmTransfer()">
            <i class="bi bi-check-circle"></i> Confirm & Transfer
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- Success Modal -->
  <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header border-0" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white;">
          <h5 class="modal-title" id="successModalLabel">
            <i class="bi bi-check-circle-fill"></i> Transfer Successful!
          </h5>
        </div>
        <div class="modal-body text-center py-4">
          <div class="mb-4">
            <i class="bi bi-check-circle-fill" style="font-size: 4rem; color: #10b981;"></i>
          </div>
          <h4 class="mb-3">Transfer Completed Successfully!</h4>
          <p class="text-muted mb-4">
            <% if (success != null) { %>
              <%= success %>
            <% } else { %>
              Your transfer has been processed successfully.
            <% } %>
          </p>
          
          <div class="card mt-4" style="background-color: #f0fdf4; border: 2px solid #86efac;">
            <div class="card-body text-start">
              <h6 class="mb-3"><i class="bi bi-info-circle"></i> Transfer Details:</h6>
              <div class="row mb-2">
                <div class="col-5"><strong>Amount:</strong></div>
                <div class="col-7" id="successAmount">-</div>
              </div>
              <div class="row mb-2">
                <div class="col-5"><strong>From:</strong></div>
                <div class="col-7" id="successFrom">-</div>
              </div>
              <div class="row">
                <div class="col-5"><strong>To:</strong></div>
                <div class="col-7" id="successTo">-</div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer border-0">
          <button type="button" class="btn btn-primary w-100" onclick="window.location.href='Dashboard'">
            <i class="bi bi-house-door"></i> Go to Dashboard
          </button>
        </div>
      </div>
    </div>
  </div>

 <script>
    // Transfer type selection
 function selectTransferType(type) {
    let transferValue;

    if (type === 'own') transferValue = "OWN_ACCOUNT";
    else if (type === 'beneficiary') transferValue = "BENEFICIARY";
    else if (type === 'new') transferValue = "OTHER_BANK";

    document.getElementById('transferType').value = transferValue;

    document.querySelectorAll('.transfer-type-card').forEach(card => card.classList.remove('active'));

    if (type === 'own') {
        document.getElementById('ownAccountCard').classList.add('active');
        document.getElementById('toOwnAccountDiv').classList.remove('d-none');
        document.getElementById('toBeneficiaryDiv').classList.add('d-none');
        document.getElementById('toNewAccountDiv').classList.add('d-none');
        document.getElementById('toOwnAccount').required = true;
        document.getElementById('toBeneficiary').required = false;
        document.getElementById('recipientAccount').required = false;
        document.getElementById('recipientName').required = false;
        document.getElementById('bankName').required = false;
        document.getElementById('summaryType').textContent = "Own Account Transfer";
    } else if (type === 'beneficiary') {
        document.getElementById('beneficiaryCard').classList.add('active');
        document.getElementById('toOwnAccountDiv').classList.add('d-none');
        document.getElementById('toBeneficiaryDiv').classList.remove('d-none');
        document.getElementById('toNewAccountDiv').classList.add('d-none');
        document.getElementById('toOwnAccount').required = false;
        document.getElementById('toBeneficiary').required = true;
        document.getElementById('recipientAccount').required = false;
        document.getElementById('recipientName').required = false;
        document.getElementById('bankName').required = false;
        document.getElementById('summaryType').textContent = "Beneficiary Transfer";
    } else if (type === 'new') {
        document.getElementById('newCard').classList.add('active');
        document.getElementById('toOwnAccountDiv').classList.add('d-none');
        document.getElementById('toBeneficiaryDiv').classList.add('d-none');
        document.getElementById('toNewAccountDiv').classList.remove('d-none');
        document.getElementById('toOwnAccount').required = false;
        document.getElementById('toBeneficiary').required = false;
        document.getElementById('recipientAccount').required = true;
        document.getElementById('recipientName').required = true;
        document.getElementById('bankName').required = true;
        document.getElementById('summaryType').textContent = "New Recipient Transfer";
    }
}




    // Update available balance
    function updateAvailableBalance() {
        var select = document.getElementById('fromAccount');
        var option = select.options[select.selectedIndex];
        var balance = option.getAttribute('data-balance');
        var currency = option.getAttribute('data-currency');

        if (balance && currency) {
            document.getElementById('availableBalance').textContent =
                "Available Balance: " + currency + " " + parseFloat(balance).toFixed(2);

            updateSummary();
        }
    }


    // Update transfer summary
    function updateSummary() {
        var fromSelect = document.getElementById('fromAccount');
        var type = document.getElementById('transferType').value;
        var amount = document.getElementById('amount').value;

        if (fromSelect.selectedIndex > 0) {
            document.getElementById('summaryFrom').textContent =
                fromSelect.options[fromSelect.selectedIndex].text;
        }

        if (type === 'OWN_ACCOUNT') {
            var toSelect = document.getElementById('toOwnAccount');
            if (toSelect && toSelect.selectedIndex > 0) {
                document.getElementById('summaryTo').textContent =
                    toSelect.options[toSelect.selectedIndex].text;
            }
        } else if (type === 'BENEFICIARY') {
            var benSelect = document.getElementById('toBeneficiary');
            if (benSelect && benSelect.selectedIndex > 0) {
                document.getElementById('summaryTo').textContent =
                    benSelect.options[benSelect.selectedIndex].text;
            }
        } else if (type === 'OTHER_BANK') {
            var recipientName = document.getElementById('recipientName').value;
            var recipientAccount = document.getElementById('recipientAccount').value;
            if (recipientName && recipientAccount) {
                document.getElementById('summaryTo').textContent =
                    recipientName + " - " + recipientAccount;
            }
        }

        if (amount && amount > 0) {
            var currency = document.getElementById('currencySymbol').textContent;

            document.getElementById('summaryAmount').textContent =
                currency + " " + parseFloat(amount).toFixed(2);

            document.getElementById('summaryTotal').textContent =
                currency + " " + parseFloat(amount).toFixed(2);
        }
    }

    // Add event listeners
    document.getElementById('fromAccount').addEventListener('change', updateSummary);
    document.getElementById('toOwnAccount').addEventListener('change', updateSummary);
    document.getElementById('toBeneficiary').addEventListener('change', updateSummary);
    document.getElementById('recipientAccount').addEventListener('input', updateSummary);
    document.getElementById('recipientName').addEventListener('input', updateSummary);
    document.getElementById('amount').addEventListener('input', updateSummary);

    // Show confirmation modal
    function showConfirmationModal() {
        var transferType = document.getElementById('transferType').value;
        var fromAccountSelect = document.getElementById('fromAccount');
        var amount = document.getElementById('amount').value;
        var description = document.getElementById('description').value;
        
        // Validate required fields first
        if (!fromAccountSelect.value) {
            alert("Please select a source account!");
            return;
        }
        
        if (!amount || parseFloat(amount) <= 0) {
            alert("Please enter a valid amount!");
            return;
        }
        
        // Validate OWN_ACCOUNT transfer
        if (transferType === 'OWN_ACCOUNT') {
            var toAccount = document.getElementById('toOwnAccount').value;
            if (fromAccountSelect.value === toAccount) {
                alert("Source and destination accounts cannot be the same!");
                return;
            }
            if (!toAccount) {
                alert("Please select a destination account!");
                return;
            }
        }

        // Validate BENEFICIARY transfer
        if (transferType === 'BENEFICIARY') {
            var selectedBeneficiary = document.getElementById('toBeneficiary').value;
            if (!selectedBeneficiary) {
                alert("Please select a beneficiary!");
                return;
            }
        }

        // Validate OTHER_BANK transfer
        if (transferType === 'OTHER_BANK') {
            var recipientAccount = document.getElementById('recipientAccount').value;
            var recipientName = document.getElementById('recipientName').value;
            if (!recipientAccount || !recipientName) {
                alert("Please fill in all recipient details!");
                return;
            }
        }

        // Validate balance
        var balance = parseFloat(
            fromAccountSelect.options[fromAccountSelect.selectedIndex].getAttribute('data-balance')
        );

        if (parseFloat(amount) > balance) {
            alert("Insufficient balance!");
            return;
        }
        
        // Populate modal with transfer details
        var fromAccountText = fromAccountSelect.options[fromAccountSelect.selectedIndex].text;
        var currency = fromAccountSelect.options[fromAccountSelect.selectedIndex].getAttribute('data-currency') || 'AED';
        
        // Set transfer type
        var typeText = '';
        if (transferType === 'OWN_ACCOUNT') {
            typeText = 'Own Account Transfer';
        } else if (transferType === 'BENEFICIARY') {
            typeText = 'Beneficiary Transfer';
        } else if (transferType === 'OTHER_BANK') {
            typeText = 'New Recipient Transfer';
        }
        document.getElementById('modalTransferType').textContent = typeText;
        
        // Set from account
        document.getElementById('modalFromAccount').textContent = fromAccountText;
        
        // Set to account
        var toAccountText = '';
        if (transferType === 'OWN_ACCOUNT') {
            var toSelect = document.getElementById('toOwnAccount');
            toAccountText = toSelect.options[toSelect.selectedIndex].text;
        } else if (transferType === 'BENEFICIARY') {
            var benSelect = document.getElementById('toBeneficiary');
            toAccountText = benSelect.options[benSelect.selectedIndex].text;
        } else if (transferType === 'OTHER_BANK') {
            var recipientAcc = document.getElementById('recipientAccount').value;
            var recipientName = document.getElementById('recipientName').value;
            toAccountText = recipientName + ' - ' + recipientAcc;
        }
        document.getElementById('modalToAccount').textContent = toAccountText;
        
        // Set amount
        document.getElementById('modalAmount').textContent = currency + ' ' + parseFloat(amount).toFixed(2);
        document.getElementById('modalTotal').textContent = currency + ' ' + parseFloat(amount).toFixed(2);
        
        // Set description
        document.getElementById('modalDescription').textContent = description || 'No description';
        
        // Store values for success modal
        window.transferDetails = {
            amount: currency + ' ' + parseFloat(amount).toFixed(2),
            from: fromAccountText,
            to: toAccountText
        };
        
        // Show modal
        var modal = new bootstrap.Modal(document.getElementById('confirmationModal'));
        modal.show();
    }
    
    // Confirm and submit transfer
    function confirmTransfer() {
        // Hide confirmation modal
        var confirmationModal = bootstrap.Modal.getInstance(document.getElementById('confirmationModal'));
        confirmationModal.hide();
        
        // Submit the form
        document.getElementById('transferForm').submit();
    }
    
    // Populate success modal if transfer was successful
    <% if (success != null) { %>
    document.addEventListener('DOMContentLoaded', function() {
        // Try to get transfer details from session/localStorage or use defaults
        if (window.transferDetails) {
            document.getElementById('successAmount').textContent = window.transferDetails.amount;
            document.getElementById('successFrom').textContent = window.transferDetails.from;
            document.getElementById('successTo').textContent = window.transferDetails.to;
        }
    });
    <% } %>
</script>
</body>
</html>