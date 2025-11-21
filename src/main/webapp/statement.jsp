<%@ page import="java.util.List" %>
<%@ page import="com.bank.models.TransactionRecord" %>
<%@ page import="com.bank.models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<TransactionRecord> txns = (List<TransactionRecord>) request.getAttribute("transactions");
    if (txns == null) txns = new java.util.ArrayList<>();
    Double totalIn = (Double) request.getAttribute("totalIn");
    Double totalOut = (Double) request.getAttribute("totalOut");
    String period = (String) request.getAttribute("period");
    Integer selectedMonth = (Integer) request.getAttribute("selectedMonth");
    Integer selectedYear = (Integer) request.getAttribute("selectedYear");
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Statement</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container mt-4">
    <h3>Account Statement</h3>
    <form method="post" action="statement">
        <div class="row g-2">
            <div class="col-md-3">
                <select name="period" class="form-select">
                    <option value="monthly" <%= "monthly".equals(period) ? "selected" : "" %>>Monthly</option>
                    <option value="yearly" <%= "yearly".equals(period) ? "selected" : "" %>>Yearly</option>
                </select>
            </div>
            <div class="col-md-2">
                <input type="number" name="month" min="1" max="12" class="form-control" placeholder="Month" value="<%= selectedMonth != null && selectedMonth > 0 ? selectedMonth : "" %>">
            </div>
            <div class="col-md-2">
                <input type="number" name="year" min="2000" class="form-control" placeholder="Year" value="<%= selectedYear != null && selectedYear > 0 ? selectedYear : "" %>">
            </div>
            <div class="col-md-3">
                <button type="submit" class="btn btn-primary">Show</button>
                <button type="submit" name="download" value="csv" class="btn btn-outline-secondary">Download CSV</button>
            </div>
        </div>
    </form>

    <hr />

    <h5>Totals</h5>
    <p>In: <strong><%= totalIn != null ? String.format("%.2f", totalIn) : "0.00" %></strong> | Out: <strong><%= totalOut != null ? String.format("%.2f", totalOut) : "0.00" %></strong></p>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>Id</th>
                <th>Timestamp</th>
                <th>From</th>
                <th>To</th>
                <th>Amount</th>
                <th>Type</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
        <% for (TransactionRecord t : txns) { %>
            <tr>
                <td><%= t.getTransactionId() %></td>
                <td><%= t.getTimestamp() %></td>
                <td><%= t.getFromAccountId() %></td>
                <td><%= t.getToAccountId() %></td>
                <td><%= String.format("%.2f", t.getAmount()) %></td>
                <td><%= t.getTransactionType() %></td>
                <td><%= t.getDescription() %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
