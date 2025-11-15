<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bank.models.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Open Account - Debug Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .card { border-left: 4px solid #007bff; }
        .success { color: #28a745; font-weight: bold; }
        .error { color: #dc3545; font-weight: bold; }
        pre { background: #f5f5f5; padding: 10px; border-radius: 5px; max-height: 300px; overflow-y: auto; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8">
                <h1>🧪 Open Account - Debug Test</h1>
                
                <%
                    User user = (User) session.getAttribute("user");
                    if (user == null) {
                %>
                    <div class="alert alert-danger">❌ Not logged in! <a href="login.jsp">Login here</a></div>
                <%
                    } else {
                %>
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Current User</h5>
                            <p><strong>Username:</strong> <%= user.getUsername() %></p>
                            <p><strong>User ID:</strong> <%= user.getUserId() %></p>
                            <p><strong>Email:</strong> <%= user.getEmail() %></p>
                            <p><strong>Full Name:</strong> <%= user.getFullName() %></p>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header bg-info text-white">
                            <h5>📝 Open New Account Form</h5>
                        </div>
                        <div class="card-body">
                            <form action="open-account" method="post" class="needs-validation">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Full Name *</label>
                                        <input type="text" class="form-control" name="full_name" value="Test User" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Phone *</label>
                                        <input type="tel" class="form-control" name="phone" value="+971501234567" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Date of Birth *</label>
                                        <input type="date" class="form-control" name="dob" value="1990-01-15" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Age *</label>
                                        <input type="number" class="form-control" name="age" value="34" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Nationality *</label>
                                        <input type="text" class="form-control" name="nationality" value="UAE" required>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Passport Number *</label>
                                        <input type="text" class="form-control" name="passport_number" value="A12345678" required>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">ID Number *</label>
                                        <input type="text" class="form-control" name="id_number" value="784-1234-1234567-8" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Address *</label>
                                    <textarea class="form-control" name="address" rows="2" required>123 Main Street, Dubai, UAE</textarea>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Monthly Income *</label>
                                        <input type="number" class="form-control" name="monthly_income" value="10000" step="0.01" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Account Type *</label>
                                        <select class="form-control" name="account_type" required>
                                            <option value="SAVINGS">Savings</option>
                                            <option value="CURRENT">Current</option>
                                            <option value="FIXED_DEPOSIT">Fixed Deposit</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Currency *</label>
                                        <select class="form-control" name="currency" required>
                                            <option value="AED">AED</option>
                                            <option value="USD">USD</option>
                                            <option value="EUR">EUR</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Initial Deposit *</label>
                                        <input type="number" class="form-control" name="initial_deposit" value="5000" step="0.01" required>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary btn-lg w-100">✅ Open Account</button>
                            </form>
                        </div>
                    </div>

                    <div class="alert alert-info">
                        <strong>💡 Instructions:</strong>
                        <ol>
                            <li>Fill in the form above with test data (pre-filled with defaults)</li>
                            <li>Click "Open Account" button</li>
                            <li>Check the browser console (F12 → Console tab) for debug messages</li>
                            <li>You should see "✅ Account opened successfully!" message</li>
                            <li>Check your database: <code>SELECT * FROM account WHERE user_id = <%= user.getUserId() %>;</code></li>
                        </ol>
                    </div>

                <%
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>
