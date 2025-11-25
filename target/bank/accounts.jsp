<%@ page import="com.bank.models.Account" %>
<%@ page import="com.bank.models.User" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Account> accounts = (List<Account>) request.getAttribute("accounts");
    if (accounts == null) accounts = new java.util.ArrayList<>();
    String message = (String) session.getAttribute("accountsMessage");
    if (message != null) {
        session.removeAttribute("accountsMessage");
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>My Accounts</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container mt-4">
    <h3>My Accounts</h3>
    <% if (message != null) { %>
        <div class="alert alert-info"><%= message %></div>
    <% } %>

    <table class="table">
        <thead>
            <tr>
                <th>Account #</th>
                <th>Type</th>
                <th>Currency</th>
                <th>Balance</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% for (Account a : accounts) { %>
            <tr>
                <td><%= a.getAccountNumber() %></td>
                <td>
                    <form method="post" action="accounts" class="d-inline">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="accountId" value="<%= a.getAccountId() %>" />
                        <select name="accountType" class="form-select form-select-sm d-inline" style="width:150px;display:inline-block">
                            <option value="Current" <%= "Current".equalsIgnoreCase(a.getAccountType())?"selected":"" %>>Current</option>
                            <option value="savings" <%= "savings".equalsIgnoreCase(a.getAccountType())?"selected":"" %>>Savings</option>
                        </select>
                </td>
                <td>
                        <select name="currency" class="form-select form-select-sm d-inline" style="width:120px;display:inline-block">
                            <option value="USD" <%= "USD".equalsIgnoreCase(a.getCurrency())?"selected":"" %>>USD</option>
                            <option value="EUR" <%= "EUR".equalsIgnoreCase(a.getCurrency())?"selected":"" %>>EUR</option>
                            <option value="GBP" <%= "GBP".equalsIgnoreCase(a.getCurrency())?"selected":"" %>>GBP</option>
                        </select>
                </td>
                <td><%= String.format("%.2f", a.getBalance()) %> <%= a.getCurrency() %></td>
                <td>
                        <button type="submit" class="btn btn-sm btn-primary">Save</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
