package com.bank.models;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

public class TransactionRecord {
    private long transactionId;
    private Long fromAccountId;
    private Long toAccountId;
    private double amount;
    private String transactionType;
    private String status;
    private String description;
    private LocalDateTime timestamp;

    public TransactionRecord() {}

    public TransactionRecord(ResultSet rs) throws SQLException {
        this.transactionId = rs.getLong("transaction_id");
        this.fromAccountId = rs.getLong("from_account_id");
        this.toAccountId = rs.getLong("to_account_id");
        this.amount = rs.getDouble("amount");
        this.transactionType = rs.getString("transaction_type");
        this.description = rs.getString("description");
        java.sql.Timestamp timestampSql = rs.getTimestamp("timestamp");
        if (timestampSql != null) {
            this.timestamp = timestampSql.toLocalDateTime();
        }
        this.status = "COMPLETED";
    }

    public long getTransactionId() { return transactionId; }
    public void setTransactionId(long transactionId) { this.transactionId = transactionId; }
    public Long getFromAccountId() { return fromAccountId; }
    public void setFromAccountId(Long fromAccountId) { this.fromAccountId = fromAccountId; }
    public Long getToAccountId() { return toAccountId; }
    public void setToAccountId(Long toAccountId) { this.toAccountId = toAccountId; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getTransactionType() { return transactionType; }
    public void setTransactionType(String transactionType) { this.transactionType = transactionType; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
}


