package com.bank.models;
public class TransactionRecord {
    private long transactionId;
    private Long fromAccountId;
    private Long toAccountId;
    private double amount;
    private String transactionType;
    private String status;
    private String description;

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
}


