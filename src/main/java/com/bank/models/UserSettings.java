package com.bank.models;

import java.io.Serializable;

public class UserSettings implements Serializable {

    private static final long serialVersionUID = 1L;

    private boolean emailAlerts = true;
    private boolean smsAlerts = false;
    private boolean pushNotifications = true;
    private boolean marketingEmails = false;
    private boolean loginAlerts = true;
    private boolean autoLogout = true;
    private boolean biometricLogin = false;
    private String theme = "light";

    public boolean isEmailAlerts() {
        return emailAlerts;
    }

    public void setEmailAlerts(boolean emailAlerts) {
        this.emailAlerts = emailAlerts;
    }

    public boolean isSmsAlerts() {
        return smsAlerts;
    }

    public void setSmsAlerts(boolean smsAlerts) {
        this.smsAlerts = smsAlerts;
    }

    public boolean isPushNotifications() {
        return pushNotifications;
    }

    public void setPushNotifications(boolean pushNotifications) {
        this.pushNotifications = pushNotifications;
    }

    public boolean isMarketingEmails() {
        return marketingEmails;
    }

    public void setMarketingEmails(boolean marketingEmails) {
        this.marketingEmails = marketingEmails;
    }

    public boolean isLoginAlerts() {
        return loginAlerts;
    }

    public void setLoginAlerts(boolean loginAlerts) {
        this.loginAlerts = loginAlerts;
    }

    public boolean isAutoLogout() {
        return autoLogout;
    }

    public void setAutoLogout(boolean autoLogout) {
        this.autoLogout = autoLogout;
    }

    public boolean isBiometricLogin() {
        return biometricLogin;
    }

    public void setBiometricLogin(boolean biometricLogin) {
        this.biometricLogin = biometricLogin;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = (theme == null || theme.isBlank()) ? "light" : theme;
    }
}

