<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    com.bank.models.User user = (com.bank.models.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Test Open Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Test Open Account Form</h1>
    <p>User: <%= user.getUsername() %> (ID: <%= user.getUserId() %>)</p>
    
    <form action="open-account" method="post" class="form">
        <div class="mb-3">
            <label>Full Name:</label>
            <input type="text" name="full_name" value="John Doe" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>Phone:</label>
            <input type="text" name="phone" value="+971501234567" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>Date of Birth:</label>
            <input type="date" name="dob" value="1990-01-15" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>Age:</label>
            <input type="number" name="age" value="34" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>Nationality:</label>
            <input type="text" name="nationality" value="UAE" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>Passport Number:</label>
            <input type="text" name="passport_number" value="A12345678" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>ID Number:</label>
            <input type="text" name="id_number" value="784-1234-1234567-8" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>Address:</label>
            <textarea name="address" class="form-control">123 Main St, Dubai, UAE</textarea>
        </div>
        
        <div class="mb-3">
            <label>Monthly Income:</label>
            <input type="number" name="monthly_income" value="10000" step="0.01" class="form-control">
        </div>
        
        <div class="mb-3">
            <label>Account Type:</label>
            <select name="account_type" class="form-control">
                <option value="Savings">Savings</option>
                <option value="Current">Current</option>
                <option value="Fixed Deposit">Fixed Deposit</option>
            </select>
        </div>
        
        <div class="mb-3">
            <label>Currency:</label>
            <select name="currency" class="form-control">
                <option value="AED">AED</option>
                <option value="USD">USD</option>
                <option value="EUR">EUR</option>
            </select>
        </div>
        
        <div class="mb-3">
            <label>Initial Deposit:</label>
            <input type="number" name="initial_deposit" value="5000" step="0.01" class="form-control">
        </div>
        
        <button type="submit" class="btn btn-primary">Open Account</button>
    </form>
</div>
</body>
</html>
