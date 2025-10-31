public class Loan {
    private long loanId;
    private long userId;
    private long accountId;
    private String loanType;
    private double principalAmount;
    private double interestRate;
    private String status;
    private String startDate;
    private String endDate;
    private double remainingBalance;

    public long getLoanId() { return loanId; }
    public void setLoanId(long loanId) { this.loanId = loanId; }
    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }
    public long getAccountId() { return accountId; }
    public void setAccountId(long accountId) { this.accountId = accountId; }
    public String getLoanType() { return loanType; }
    public void setLoanType(String loanType) { this.loanType = loanType; }
    public double getPrincipalAmount() { return principalAmount; }
    public void setPrincipalAmount(double principalAmount) { this.principalAmount = principalAmount; }
    public double getInterestRate() { return interestRate; }
    public void setInterestRate(double interestRate) { this.interestRate = interestRate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }
    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }
    public double getRemainingBalance() { return remainingBalance; }
    public void setRemainingBalance(double remainingBalance) { this.remainingBalance = remainingBalance; }
}


