<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vertex Bank | Sign Up</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="css/style.css">
</head>

<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark py-2">
    <div class="container-fluid">
        <a class="navbar-brand" href="Dashboard"><img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="Support.jsp"><i class="bi bi-headset"></i> Support</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- ================= SIGN UP FORM ================= -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card p-4">
                <!-- Success / Error Messages -->
                <%
                    String msg = (String) request.getAttribute("msg");
                    String err = (String) request.getAttribute("error");
                    if (msg != null) {
                %>
                <div class="alert alert-success text-center">
                    <i class="fas fa-check-circle me-2"></i><%= msg %><br>
                    <a href="login.jsp" class="btn btn-sm btn-light mt-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Login Now
                    </a>
                </div>
                <% } else if (err != null) { %>
                <div class="alert alert-danger text-center">
                    <i class="fas fa-exclamation-circle me-2"></i><%= err %>
                </div>
                <% } %>

                <h2 class="text-center">Create Account</h2>
                <p class="text-center mb-4 text-muted">Join Vertex Bank in just a few steps</p>

                <!-- Progress Bar -->
                <div class="progress-container">
                    <div class="d-flex justify-content-between mb-2">
                        <small>Password Strength</small>
                        <small id="strength-text">Weak</small>
                    </div>
                    <div class="progress" style="height: 8px; background: rgba(0,0,0,0.1);">
                        <div id="password-strength-bar" class="progress-bar" style="width: 0%"></div>
                    </div>
                </div>

                <form action="signup" method="post" onsubmit="return validateForm();">

                    <!-- Full Name -->
                    <div class="floating-label">
                        <label for="fullname">Full Name</label>
                        <div class="input-group">
                            <input type="text" class="form-control" name="name" id="fullname" placeholder="John Doe" required>
                            <span class="validation-icon">
            <i class="fas fa-check valid-icon"></i>
            <i class="fas fa-times invalid-icon"></i>
          </span>
                        </div>
                        <div class="validation-message" id="fullname-message"></div>
                    </div>

                    <!-- Username -->
                    <div class="floating-label">
                        <label for="username">Username</label>
                        <div class="input-group">
                            <input type="text" class="form-control" name="username" id="username" placeholder="johndoe" required>
                            <span class="validation-icon">
            <i class="fas fa-check valid-icon"></i>
            <i class="fas fa-times invalid-icon"></i>
          </span>
                        </div>
                        <div class="validation-message" id="username-message"></div>
                    </div>

                    <!-- Email -->
                    <div class="floating-label">
                        <label for="email">Email Address</label>
                        <div class="input-group">
                            <input type="email" class="form-control" name="email" id="email" placeholder="you@example.com" required>
                            <span class="validation-icon">
            <i class="fas fa-check valid-icon"></i>
            <i class="fas fa-times invalid-icon"></i>
          </span>
                        </div>
                        <div class="validation-message" id="email-message"></div>
                    </div>

                    <!-- Phone -->
                    <div class="floating-label">
                        <label for="phone">Phone Number</label>
                        <div class="input-group">
                            <input type="tel" class="form-control" name="tel" id="phone" placeholder="05XXXXXXXX" required>
                            <span class="validation-icon">
            <i class="fas fa-check valid-icon"></i>
            <i class="fas fa-times invalid-icon"></i>
          </span>
                        </div>
                        <div class="validation-message" id="phone-message"></div>
                    </div>

                    <!-- Password -->
                    <div class="floating-label">
                        <label for="password">Create Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" name="pass" id="password" placeholder="********" required>
                            <span class="validation-icon">
            <i class="fas fa-check valid-icon"></i>
            <i class="fas fa-times invalid-icon"></i>
          </span>
                        </div>
                        <div class="validation-message" id="password-message"></div>
                        <div class="password-strength" id="password-strength-text"></div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="floating-label">
                        <label for="confirm">Confirm Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="confirm" placeholder="********" required>
                            <span class="validation-icon">
            <i class="fas fa-check valid-icon"></i>
            <i class="fas fa-times invalid-icon"></i>
          </span>
                        </div>
                        <div class="validation-message" id="confirm-message"></div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mt-3">
                        <i class="fas fa-user-plus me-2"></i>Create Account
                    </button>
                </form>

                <p class="text-center mt-4 mb-0">Already have an account? <a href="login.jsp">Login Here</a></p>
                <a href="index.jsp" class="d-block mt-3 text-center">← Back to Home</a>
            </div>
        </div>
    </div>
</div>


<!-- ================= ENHANCED JAVASCRIPT VALIDATION ================= -->
<script>
    // Validation patterns
    const patterns = {
        fullName: /^[A-Za-z ]{2,50}$/,
        username: /^[A-Za-z0-9_]{3,20}$/,
        email: /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/,
        phone: /^05[0-9]{8}$/,
        password: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$/
    };

    // Messages
    const messages = {
        fullName: {
            valid: "Full name looks good!",
            invalid: "Full name must be 2-50 letters only."
        },
        username: {
            valid: "Username is available!",
            invalid: "Username must be 3-20 characters, letters/numbers/underscore only."
        },
        email: {
            valid: "Valid email address!",
            invalid: "Please enter a valid email address."
        },
        phone: {
            valid: "Valid phone number!",
            invalid: "Phone number must follow UAE format: 05XXXXXXXX"
        },
        password: {
            valid: "Strong password!",
            invalid: "Password must be at least 8 characters and contain letters and numbers."
        },
        confirm: {
            valid: "Passwords match!",
            invalid: "Passwords do not match!"
        }
    };

    // Live validation function
    function validateField(fieldId, pattern, messageKey) {
        const field = document.getElementById(fieldId);
        const message = document.getElementById(fieldId + '-message');
        const parent = field.parentElement.parentElement;
        const value = field.value.trim();

        if (value === '') {
            parent.classList.remove('valid', 'invalid');
            message.style.display = 'none';
            return false;
        }

        if (pattern.test(value)) {
            parent.classList.add('valid');
            parent.classList.remove('invalid');
            message.textContent = messages[messageKey].valid;
            return true;
        } else {
            parent.classList.add('invalid');
            parent.classList.remove('valid');
            message.textContent = messages[messageKey].invalid;
            return false;
        }
    }

    // Password strength checker
    function checkPasswordStrength(password) {
        const strengthBar = document.getElementById('password-strength-bar');
        const strengthText = document.getElementById('strength-text');
        const strengthDetail = document.getElementById('password-strength-text');

        let strength = 0;
        let feedback = [];

        if (password.length >= 8) strength += 25;
        if (/[A-Z]/.test(password)) strength += 25;
        if (/[0-9]/.test(password)) strength += 25;
        if (/[^A-Za-z0-9]/.test(password)) strength += 25;

        strengthBar.style.width = strength + '%';

        if (strength < 50) {
            strengthBar.style.background = 'linear-gradient(45deg, #ef4444, #f87171)';
            strengthText.textContent = 'Weak';
            strengthText.className = 'strength-weak';
            strengthDetail.textContent = 'Add uppercase letters, numbers, and special characters';
        } else if (strength < 75) {
            strengthBar.style.background = 'linear-gradient(45deg, #f59e0b, #fbbf24)';
            strengthText.textContent = 'Medium';
            strengthText.className = 'strength-medium';
            strengthDetail.textContent = 'Good, but could be stronger with special characters';
        } else {
            strengthBar.style.background = 'linear-gradient(45deg, #10b981, #34d399)';
            strengthText.textContent = 'Strong';
            strengthText.className = 'strength-strong';
            strengthDetail.textContent = 'Excellent! Your password is strong and secure';
        }
    }

    // Confirm password validation
    function validateConfirmPassword() {
        const password = document.getElementById('password').value.trim();
        const confirm = document.getElementById('confirm').value.trim();
        const parent = document.getElementById('confirm').parentElement.parentElement;
        const message = document.getElementById('confirm-message');

        if (confirm === '') {
            parent.classList.remove('valid', 'invalid');
            message.style.display = 'none';
            return false;
        }

        if (password === confirm && password !== '') {
            parent.classList.add('valid');
            parent.classList.remove('invalid');
            message.textContent = messages.confirm.valid;
            return true;
        } else {
            parent.classList.add('invalid');
            parent.classList.remove('valid');
            message.textContent = messages.confirm.invalid;
            return false;
        }
    }

    // Event listeners for live validation
    document.addEventListener('DOMContentLoaded', function() {
        // Full Name
        document.getElementById('fullname').addEventListener('input', function() {
            validateField('fullname', patterns.fullName, 'fullName');
        });

        // Username
        document.getElementById('username').addEventListener('input', function() {
            validateField('username', patterns.username, 'username');
        });

        // Email
        document.getElementById('email').addEventListener('input', function() {
            validateField('email', patterns.email, 'email');
        });

        // Phone
        document.getElementById('phone').addEventListener('input', function() {
            validateField('phone', patterns.phone, 'phone');
        });

        // Password
        document.getElementById('password').addEventListener('input', function() {
            validateField('password', patterns.password, 'password');
            checkPasswordStrength(this.value);
            validateConfirmPassword();
        });

        // Confirm Password
        document.getElementById('confirm').addEventListener('input', function() {
            validateConfirmPassword();
        });
    });

    // Final form validation
    function validateForm() {
        const fields = [
            validateField('fullname', patterns.fullName, 'fullName'),
            validateField('username', patterns.username, 'username'),
            validateField('email', patterns.email, 'email'),
            validateField('phone', patterns.phone, 'phone'),
            validateField('password', patterns.password, 'password'),
            validateConfirmPassword()
        ];

        return fields.every(field => field === true);
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>