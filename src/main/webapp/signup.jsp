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

  <style>
    :root {
      --primary-blue: #2563eb;
      --dark-blue: #1e3a8a;
      --darker-blue: #0b1220;
      --success-green: #10b981;
      --error-red: #ef4444;
      --warning-orange: #f59e0b;
    }

    body {
      background: linear-gradient(135deg, var(--darker-blue), var(--dark-blue));
      min-height: 100vh;
      padding-top: 90px;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .signup-container {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(20px);
      padding: 40px;
      border-radius: 24px;
      width: 100%;
      max-width: 500px;
      color: #fff;
      box-shadow: 0 20px 40px rgba(0,0,0,0.3);
      margin: auto;
      border: 1px solid rgba(255,255,255,0.2);
      position: relative;
      overflow: hidden;
    }

    .signup-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
      transition: 0.5s;
    }

    .signup-container:hover::before {
      left: 100%;
    }

    h2 {
      font-weight: 700;
      text-align: center;
      margin-bottom: 10px;
      color: #ffffff;
      font-size: 2.2rem;
      background: linear-gradient(45deg, #fff, #60a5fa);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .form-control {
      background: rgba(255,255,255,0.15);
      color: #fff;
      border: 2px solid rgba(255,255,255,0.2);
      border-radius: 12px;
      padding: 12px 16px;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      background: rgba(255,255,255,0.2);
      color: #fff;
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 0.25rem rgba(37, 99, 235, 0.25);
    }

    .form-control::placeholder {
      color: rgba(255,255,255,0.6);
    }

    .input-group {
      position: relative;
    }

    .validation-icon {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 1.1rem;
      opacity: 0;
      transition: all 0.3s ease;
    }

    .valid .validation-icon {
      opacity: 1;
      color: var(--success-green);
    }

    .invalid .validation-icon {
      opacity: 1;
      color: var(--error-red);
    }

    .valid .form-control {
      border-color: var(--success-green);
    }

    .invalid .form-control {
      border-color: var(--error-red);
    }

    .validation-message {
      font-size: 0.85rem;
      margin-top: 5px;
      padding: 5px 10px;
      border-radius: 8px;
      display: none;
    }

    .valid .validation-message {
      display: block;
      background: rgba(16, 185, 129, 0.2);
      color: var(--success-green);
    }

    .invalid .validation-message {
      display: block;
      background: rgba(239, 68, 68, 0.2);
      color: var(--error-red);
    }

    .btn-primary {
      background: linear-gradient(45deg, var(--primary-blue), #3b82f6);
      border: none;
      border-radius: 12px;
      padding: 14px;
      font-weight: 600;
      font-size: 1.1rem;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(37, 99, 235, 0.6);
    }

    .btn-primary:active {
      transform: translateY(0);
    }

    .alert {
      border-radius: 12px;
      border: none;
      backdrop-filter: blur(10px);
    }

    .alert-success {
      background: rgba(16, 185, 129, 0.2);
      color: var(--success-green);
    }

    .alert-danger {
      background: rgba(239, 68, 68, 0.2);
      color: var(--error-red);
    }

    .navbar {
      background: rgba(255,255,255,0.1);
      backdrop-filter: blur(15px);
      border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    .navbar a {
      color: white !important;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .navbar a:hover {
      color: #60a5fa !important;
    }

    .progress-container {
      margin-bottom: 30px;
    }

    .progress-bar {
      background: linear-gradient(45deg, var(--primary-blue), #3b82f6);
      border-radius: 10px;
      transition: width 0.5s ease;
    }

    .password-strength {
      margin-top: 5px;
      font-size: 0.85rem;
    }

    .strength-weak { color: var(--error-red); }
    .strength-medium { color: var(--warning-orange); }
    .strength-strong { color: var(--success-green); }

    .floating-label {
      position: relative;
      margin-bottom: 1.5rem;
    }

    .floating-label label {
      position: absolute;
      top: -10px;
      left: 12px;
      font-size: 0.8rem;
      background: var(--darker-blue);
      padding: 0 8px;
      color: rgba(255,255,255,0.8);
    }
  </style>
</head>

<body>

<!-- ================= NAVBAR ================= -->
<nav class="navbar navbar-expand-lg fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand text-white fw-bold" href="index.jsp">
      <i class="fas fa-university me-2"></i>Vertex Bank
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
        <li class="nav-item"><a class="nav-link" href="about.jsp"><i class="fas fa-info-circle me-1"></i>About</a></li>
        <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i>Login</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- ================= SIGN UP FORM ================= -->
<div class="signup-container">

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

    <h2>Create Account</h2>
    <p class="text-center mb-4 text-light">Join Vertex Bank in just a few steps</p>

    <!-- Progress Bar -->
    <div class="progress-container">
      <div class="d-flex justify-content-between mb-2">
        <small>Password Strength</small>
        <small id="strength-text">Weak</small>
      </div>
      <div class="progress" style="height: 8px; background: rgba(255,255,255,0.1);">
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

    <p class="text-center mt-4 mb-0 text-light">
      Already have an account? <a href="login.jsp" class="text-warning">Login Here</a>
    </p>
    <p class="text-center mt-2">
      <a href="index.jsp" class="text-light"><i class="fas fa-arrow-left me-1"></i>Back to Home</a>
    </p>
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