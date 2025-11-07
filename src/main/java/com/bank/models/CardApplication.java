package com.bank.models;
public class CardApplication {
    private long applicationId;
    private long userId;
    private long accountId;
    private String cardType;
    private String status;

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
}


