package com.bank.models;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class CardApplication {
    private long applicationId;
    private long userId;
    private long accountId;
    private String cardType;
    private String status;
    private LocalDate appliedAt;
    private LocalDate processedAt;

    public CardApplication() {}

    public CardApplication(ResultSet rs) throws SQLException {
        this.applicationId = rs.getLong("application_id");
        this.userId = rs.getLong("user_id");
        this.accountId = rs.getLong("account_id");
        this.cardType = rs.getString("card_type");
        this.status = rs.getString("status");
        java.sql.Date appliedSqlDate = rs.getDate("applied_at");
        if (appliedSqlDate != null) {
            this.appliedAt = appliedSqlDate.toLocalDate();
        }
        java.sql.Date processedSqlDate = rs.getDate("processed_at");
        if (processedSqlDate != null) {
            this.processedAt = processedSqlDate.toLocalDate();
        }
    }

    public long getApplicationId() { return applicationId; }
    public void setApplicationId(long applicationId) { this.applicationId = applicationId; }
    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }
    public long getAccountId() { return accountId; }
    public void setAccountId(long accountId) { this.accountId = accountId; }
    public String getCardType() { return cardType; }
    public void setCardType(String cardType) { this.cardType = cardType; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDate getAppliedAt() { return appliedAt; }
    public void setAppliedAt(LocalDate appliedAt) { this.appliedAt = appliedAt; }
    public LocalDate getProcessedAt() { return processedAt; }
    public void setProcessedAt(LocalDate processedAt) { this.processedAt = processedAt; }
}


