public class Card {
    private long cardId;
    private long accountId;
    private String cardNumber;
    private String cardType;
    private String expiryDate;
    private String cvv;
    private String status;

    public long getCardId() { return cardId; }
    public void setCardId(long cardId) { this.cardId = cardId; }
    public long getAccountId() { return accountId; }
    public void setAccountId(long accountId) { this.accountId = accountId; }
    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }
    public String getCardType() { return cardType; }
    public void setCardType(String cardType) { this.cardType = cardType; }
    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }
    public String getCvv() { return cvv; }
    public void setCvv(String cvv) { this.cvv = cvv; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}


