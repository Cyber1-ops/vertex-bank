package com.bank.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class Beneficiary {
    private int beneficiaryId;
    private int userId;
    private String beneficiaryName;
    private String accountNumber;
    private String bankName;
    private Timestamp addedAt;  

    public Beneficiary() {}

    public Beneficiary(ResultSet rs) throws SQLException {
        this.beneficiaryId = rs.getInt("beneficiary_id");
        this.userId = rs.getInt("user_id");
        this.beneficiaryName = rs.getString("beneficiary_name");
        this.accountNumber = rs.getString("account_number");
        this.bankName = rs.getString("bank_name");
        this.addedAt = rs.getTimestamp("added_at");
    }

    public long getBeneficiaryId() { return beneficiaryId; }
    public void setBeneficiaryId(int beneficiaryId) { this.beneficiaryId = beneficiaryId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getBeneficiaryName() { return beneficiaryName; }
    public void setBeneficiaryName(String beneficiaryName) { this.beneficiaryName = beneficiaryName; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public Timestamp getAddedAt() { return addedAt; }
    public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }
}
