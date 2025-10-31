public class Beneficiary {
    private long beneficiaryId;
    private long userId;
    private String beneficiaryName;
    private String accountNumber;
    private String bankName;

    public long getBeneficiaryId() { return beneficiaryId; }
    public void setBeneficiaryId(long beneficiaryId) { this.beneficiaryId = beneficiaryId; }
    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }
    public String getBeneficiaryName() { return beneficiaryName; }
    public void setBeneficiaryName(String beneficiaryName) { this.beneficiaryName = beneficiaryName; }
    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }
}


