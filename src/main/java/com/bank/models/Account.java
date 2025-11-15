package com.bank.models;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
public class Account {
    private long accountId;
    private String accountNumber;
    private int userId;
    private String accountType;
    private double balance;
    private String currency;
    private String status;
    private LocalDate created_at;
    
    
    public Account(){}
    
    public Account(ResultSet rs) throws SQLException {
        this.userId = rs.getInt("user_id");
        this.accountNumber = rs.getString("account_number");
        this.accountType = rs.getString("account_type");
        this.balance = rs.getDouble("balance");
        this.accountId = rs.getLong("account_id");
        this.currency = rs.getString("currency");
        this.status = rs.getString("status");
        java.sql.Date createdSqlDate = rs.getDate("created_at");
        if (createdSqlDate != null) {
            this.setCreated_at(createdSqlDate.toLocalDate());
        } else {
            this.setCreated_at(null); // or some default date
        }

    }

    
    
    

    public long getAccountId() { return accountId; }
    public void setAccountId(long accountId) { this.accountId = accountId; }
    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getAccountType() { return accountType; }
    public void setAccountType(String accountType) { this.accountType = accountType; }
    public double getBalance() { return balance; }
    public void setBalance(double balance) { this.balance = balance; }
    public String getCurrency() { return currency; }
    public void setCurrency(String currency) { this.currency = currency; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }





	public LocalDate getCreated_at() {
		return created_at;
	}





	public void setCreated_at(LocalDate created_at) {
		this.created_at = created_at;
	}
}


