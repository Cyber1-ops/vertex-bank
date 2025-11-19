package com.bank.models;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class Card {
    private long cardId;
    private long accountId;
    private String cardNumber;
    private String cardType;
    private LocalDate expiryDate;
    private String cvv;
    private String status;
    private LocalDate issuedAt;

    public Card() {}

    public Card(ResultSet rs) throws SQLException {
        this.cardId = rs.getLong("card_id");
        this.accountId = rs.getLong("account_id");
        this.cardNumber = rs.getString("card_number");
        this.cardType = rs.getString("card_type");
        java.sql.Date expirySqlDate = rs.getDate("expiry_date");
        if (expirySqlDate != null) {
            this.expiryDate = expirySqlDate.toLocalDate();
        }
        this.cvv = rs.getString("cvv");
        this.status = rs.getString("status");
        java.sql.Date issuedSqlDate = rs.getDate("issued_at");
        if (issuedSqlDate != null) {
            this.issuedAt = issuedSqlDate.toLocalDate();
        }
    }

    public long getCardId() { return cardId; }
    public void setCardId(long cardId) { this.cardId = cardId; }
    public long getAccountId() { return accountId; }
    public void setAccountId(long accountId) { this.accountId = accountId; }
    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }
    public String getCardType() { return cardType; }
    public void setCardType(String cardType) { this.cardType = cardType; }
    public LocalDate getExpiryDate() { return expiryDate; }
    public void setExpiryDate(LocalDate expiryDate) { this.expiryDate = expiryDate; }
    public String getCvv() { return cvv; }
    public void setCvv(String cvv) { this.cvv = cvv; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDate getIssuedAt() { return issuedAt; }
    public void setIssuedAt(LocalDate issuedAt) { this.issuedAt = issuedAt; }
    
    // Helper method to format card number for display (masked)
    public String getMaskedCardNumber() {
        if (cardNumber == null || cardNumber.length() < 4) {
            return "****";
        }
        return "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
    }
}


