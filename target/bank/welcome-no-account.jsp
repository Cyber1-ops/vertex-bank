<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open Account - Vertex Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-gradient: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
        }
        
        /* Navigation Bar */
        .top-nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 15px 0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            animation: slideDown 0.5s ease-out;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .top-nav .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e293b;
            text-decoration: none;
            transition: transform 0.3s;
        }
        
        .nav-brand:hover {
            transform: scale(1.05);
        }
        
        .nav-brand i {
            color: #667eea;
            font-size: 1.8rem;
        }
        
        .nav-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .nav-btn {
            padding: 10px 25px;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
            cursor: pointer;
        }
        
        .nav-btn-outline {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }
        
        .nav-btn-outline:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        .nav-btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .nav-btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            overflow-x: hidden;
        }
        
        /* Animated background particles */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: pulse 8s ease-in-out infinite;
            pointer-events: none;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }
        
        .container { position: relative; z-index: 1; }
        
        .form-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            box-shadow: 0 30px 90px rgba(0, 0, 0, 0.3),
                        0 0 0 1px rgba(255, 255, 255, 0.2);
            margin: 40px auto;
            padding: 50px;
            max-width: 900px;
            position: relative;
            overflow: hidden;
            animation: slideIn 0.6s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .form-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg at 50% 50%, transparent, rgba(102, 126, 234, 0.1), transparent 90deg);
            animation: rotate 20s linear infinite;
            pointer-events: none;
        }
        
        @keyframes rotate {
            100% { transform: rotate(360deg); }
        }
        
        .form-header {
            background: var(--dark-gradient);
            color: white;
            padding: 40px;
            border-radius: 25px;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }
        
        .form-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transform: rotate(45deg);
            animation: shimmer 3s infinite;
        }
        
        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }
        
        .form-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .form-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }
        
        .step-indicator {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
            position: relative;
            padding: 0 20px;
        }
        
        .step-indicator::before {
            content: '';
            position: absolute;
            top: 25px;
            left: 60px;
            right: 60px;
            height: 4px;
            background: linear-gradient(90deg, #e2e8f0, #cbd5e1);
            z-index: 1;
            border-radius: 2px;
        }
        
        .step-progress {
            position: absolute;
            top: 25px;
            left: 60px;
            height: 4px;
            background: var(--primary-gradient);
            z-index: 2;
            border-radius: 2px;
            transition: width 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.5);
        }
        
        .step {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: #64748b;
            position: relative;
            z-index: 3;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }
        
        .step.active {
            background: var(--primary-gradient);
            color: white;
            transform: scale(1.2);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        
        .step.completed {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }
        
        .step-label {
            position: absolute;
            top: 60px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.85rem;
            color: #64748b;
            font-weight: 600;
            white-space: nowrap;
            transition: all 0.3s;
        }
        
        .step.active .step-label {
            color: #667eea;
            font-weight: 700;
            transform: translateX(-50%) scale(1.05);
        }
        
        .form-section {
            margin-bottom: 30px;
            padding: 35px;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-radius: 20px;
            border-left: 5px solid transparent;
            border-image: var(--primary-gradient) 1;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .form-section:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
        }
        
        .form-section h4 {
            color: #1e293b;
            font-weight: 700;
            margin-bottom: 25px;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-section h4::before {
            content: '';
            width: 5px;
            height: 25px;
            background: var(--primary-gradient);
            border-radius: 3px;
        }
        
        .form-label {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 8px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .form-label i {
            color: #667eea;
            font-size: 0.9rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 14px 18px;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: white;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1), 0 5px 15px rgba(102, 126, 234, 0.2);
            outline: none;
            transform: translateY(-1px);
        }
        
        .form-control:hover, .form-select:hover {
            border-color: #cbd5e1;
        }
        
        .form-step {
            display: none;
            animation: fadeIn 0.4s ease-out;
        }
        
        .form-step.active {
            display: block;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 35px;
            gap: 15px;
        }
        
        .btn {
            padding: 14px 35px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            position: relative;
            overflow: hidden;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .btn:hover::before {
            width: 300px;
            height: 300px;
        }
        
        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.4);
        }
        
        .btn-success {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.3);
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(79, 172, 254, 0.4);
        }
        
        .btn-outline-secondary {
            background: white;
            color: #64748b;
            border: 2px solid #e2e8f0;
        }
        
        .btn-outline-secondary:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
            color: #475569;
            transform: translateY(-2px);
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            z-index: 1;
        }
        
        .input-icon .form-control {
            padding-left: 45px;
        }
        
        /* Error state */
        .form-control.error {
            border-color: #ef4444;
            animation: shake 0.4s;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        /* Success message */
        .success-message {
            background: var(--success-gradient);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            margin-top: 20px;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.3);
            animation: slideIn 0.5s ease-out;
        }
        
        @media (max-width: 768px) {
            .form-container { padding: 30px 20px; }
            .form-header h1 { font-size: 2rem; }
            .step-indicator { padding: 0 10px; }
            .step { width: 45px; height: 45px; }
            .navigation-buttons { flex-direction: column; }
            .btn { width: 100%; }
            .nav-actions { gap: 8px; }
            .nav-btn { padding: 8px 15px; font-size: 0.9rem; }
            .nav-brand { font-size: 1.2rem; }
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="top-nav">
    <div class="container">
        <a href="Dashboard" class="nav-brand">
                <img src="logo/logo_vertex.png" alt="Vertex Bank Logo" class="logo-img">        </a>
        <div class="nav-actions">
            <a href="Dashboard" class="nav-btn nav-btn-outline">
                <i class="fas fa-home"></i> Dashboard
            </a>
        <a href="profile" class="nav-btn nav-btn-outline">
            <i class="fas fa-user"></i> Profile
        </a>
        <a href="settings" class="nav-btn nav-btn-outline">
            <i class="fas fa-gear"></i> Settings
        </a>
            <form action="logout" method="post" style="margin: 0;">
                <button type="submit" class="nav-btn nav-btn-primary">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="form-container">
        <div class="form-header">
            <h1><i class="fas fa-university"></i> Open New Account</h1>
            <p class="mb-0">Complete your application in just a few simple steps</p>
        </div>

        <div class="step-indicator">
            <div class="step-progress" id="stepProgress"></div>
            <div class="step active" data-step="1">
                <div>1</div>
                <span class="step-label">Personal Info</span>
            </div>
            <div class="step" data-step="2">
                <div>2</div>
                <span class="step-label">ID & Address</span>
            </div>
            <div class="step" data-step="3">
                <div>3</div>
                <span class="step-label">Account Details</span>
            </div>
        </div>

        <form id="accountForm" action="open-account" method="post" novalidate>

            <!-- STEP 1 -->
            <div class="form-step active" id="step1">
                <div class="form-section">
                    <h4>Personal Information</h4>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-user"></i> Full Name *</label>
                        <div class="input-icon">
                            <i class="fas fa-id-card"></i>
                            <input type="text" class="form-control" name="full_name" id="fullName" placeholder="Enter your full name" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-phone"></i> Phone Number *</label>
                        <div class="input-icon">
                            <i class="fas fa-mobile-alt"></i>
                            <input type="tel" class="form-control" name="phone" id="phone" placeholder="+971 XX XXX XXXX" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-birthday-cake"></i> Age *</label>
                        <div class="input-icon">
                            <i class="fas fa-calendar"></i>
                            <input type="number" class="form-control" name="age" id="age" min="18" placeholder="Must be 18 or older" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-flag"></i> Nationality *</label>
                        <div class="input-icon">
                            <i class="fas fa-globe"></i>
                            <input type="text" class="form-control" name="nationality" id="nationality" placeholder="Your nationality" required>
                        </div>
                    </div>
                </div>
                <div class="navigation-buttons">
                    <div></div>
                    <button type="button" class="btn btn-primary" onclick="nextStep(2)">
                        Next <i class="fas fa-arrow-right ms-2"></i>
                    </button>
                </div>
            </div>

            <!-- STEP 2 -->
            <div class="form-step" id="step2">
                <div class="form-section">
                    <h4>Identification & Address</h4>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-id-badge"></i> Emirates ID *</label>
                        <div class="input-icon">
                            <i class="fas fa-fingerprint"></i>
                            <input type="text" class="form-control" name="id_number" id="emiratesId" placeholder="XXX-XXXX-XXXXXXX-X" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-map-marker-alt"></i> Address *</label>
                        <textarea class="form-control" name="address" id="address" rows="3" placeholder="Enter your full address" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-money-bill-wave"></i> Monthly Income (AED) *</label>
                        <div class="input-icon">
                            <i class="fas fa-dollar-sign"></i>
                            <input type="number" class="form-control" name="monthly_income" id="monthlyIncome" min="0" placeholder="Enter amount in AED" required>
                        </div>
                    </div>
                </div>
                <div class="navigation-buttons">
                    <button type="button" class="btn btn-outline-secondary" onclick="prevStep(1)">
                        <i class="fas fa-arrow-left me-2"></i> Back
                    </button>
                    <button type="button" class="btn btn-primary" onclick="nextStep(3)">
                        Next <i class="fas fa-arrow-right ms-2"></i>
                    </button>
                </div>
            </div>

            <!-- STEP 3 -->
            <div class="form-step" id="step3">
                <div class="form-section">
                    <h4>Account Details</h4>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-wallet"></i> Account Type *</label>
                        <select class="form-control form-select" name="account_type" id="accountType" required>
                            <option value="">Select account type...</option>
                            <option value="Current">Current Account</option>
                            <option value="Savings">Savings Account</option>
                            <option value="Fixed Deposit">Fixed Deposit Account</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-coins"></i> Currency *</label>
                        <select class="form-control form-select" name="currency" id="currency" required>
                            <option value="">Select currency...</option>
                            <option value="AED">AED - UAE Dirham</option>
                            <option value="USD">USD - US Dollar</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-piggy-bank"></i> Initial Deposit *</label>
                        <div class="input-icon">
                            <i class="fas fa-hand-holding-usd"></i>
                            <input type="number" class="form-control" name="initial_deposit" id="initialDeposit" min="0" placeholder="Minimum deposit amount" required>
                        </div>
                    </div>
                </div>
                <div class="navigation-buttons">
                    <button type="button" class="btn btn-outline-secondary" onclick="prevStep(2)">
                        <i class="fas fa-arrow-left me-2"></i> Back
                    </button>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-check-circle me-2"></i> Submit Application
                    </button>
                </div>
            </div>

        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
let currentStep = 1;

// Update progress bar
function updateProgress() {
    const progress = document.getElementById('stepProgress');
    const width = ((currentStep - 1) / 2) * (100 - 10); // Calculate percentage
    progress.style.width = width + '%';
}

// Initialize progress
updateProgress();

// Field name formatter
function formatFieldName(id) {
    const names = {
        fullName: 'Full Name',
        phone: 'Phone Number',
        age: 'Age',
        nationality: 'Nationality',
        emiratesId: 'Emirates ID',
        address: 'Address',
        monthlyIncome: 'Monthly Income',
        accountType: 'Account Type',
        currency: 'Currency',
        initialDeposit: 'Initial Deposit'
    };
    return names[id] || id.replace(/([A-Z])/g, ' $1').trim();
}

// Validate field
function validateField(el) {
    if (!el.value.trim()) {
        el.classList.add('error');
        setTimeout(() => el.classList.remove('error'), 400);
        return false;
    }
    
    // Additional validation
    if (el.id === 'age' && parseInt(el.value) < 18) {
        el.classList.add('error');
        setTimeout(() => el.classList.remove('error'), 400);
        alert('You must be at least 18 years old to open an account');
        return false;
    }
    
    if ((el.id === 'monthlyIncome' || el.id === 'initialDeposit') && parseFloat(el.value) < 0) {
        el.classList.add('error');
        setTimeout(() => el.classList.remove('error'), 400);
        alert('Amount cannot be negative');
        return false;
    }
    
    return true;
}

// Validate current step
function validateStep(step) {
    const fields = {
        1: ['fullName', 'phone', 'age', 'nationality'],
        2: ['emiratesId', 'address', 'monthlyIncome'],
        3: ['accountType', 'currency', 'initialDeposit']
    };
    
    const required = fields[step] || [];
    for (let id of required) {
        const el = document.getElementById(id);
        if (el && !validateField(el)) {
            alert('Please fill in "' + formatFieldName(id) + '" correctly');
            el.focus();
            return false;
        }
    }
    return true;
}

// Mark step as completed
function markStepCompleted(step) {
    const stepEl = document.querySelector(`.step[data-step="${step}"]`);
    if (stepEl && step < currentStep) {
        stepEl.classList.add('completed');
    }
}

// Next step
function nextStep(to) {
    if (!validateStep(currentStep)) return;
    
    // Hide current step
    const currentStepEl = document.getElementById('step' + currentStep);
    currentStepEl.classList.remove('active');
    
    // Mark current as completed
    markStepCompleted(currentStep);
    
    // Show next step
    const nextStepEl = document.getElementById('step' + to);
    nextStepEl.classList.add('active');
    
    // Update step indicators
    document.querySelector(`.step[data-step="${currentStep}"]`).classList.remove('active');
    document.querySelector(`.step[data-step="${to}"]`).classList.add('active');
    
    currentStep = to;
    updateProgress();
    
    // Smooth scroll
    document.querySelector('.form-container').scrollIntoView({ behavior: 'smooth', block: 'start' });
}

// Previous step
function prevStep(to) {
    // Hide current step
    const currentStepEl = document.getElementById('step' + currentStep);
    currentStepEl.classList.remove('active');
    
    // Show previous step
    const prevStepEl = document.getElementById('step' + to);
    prevStepEl.classList.add('active');
    
    // Update step indicators
    document.querySelector(`.step[data-step="${currentStep}"]`).classList.remove('active');
    document.querySelector(`.step[data-step="${to}"]`).classList.add('active');
    
    currentStep = to;
    updateProgress();
}

// Form submission
document.getElementById('accountForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // Validate all steps
    if (validateStep(1) && validateStep(2) && validateStep(3)) {
        // Show success message
        const formContainer = document.querySelector('.form-container');
        formContainer.innerHTML += `
            <div class="success-message">
                <i class="fas fa-check-circle fa-3x mb-3"></i>
                <h3>Application Submitted Successfully!</h3>
                <p>Your account opening request has been received. We'll contact you shortly.</p>
                <div class="mt-4" style="display: flex; gap: 15px; justify-content: center;">
                    <a href="Dashboard" class="btn btn-primary">
                        <i class="fas fa-home me-2"></i> Go to Dashboard
                    </a>
                    <button onclick="window.location.reload()" class="btn btn-outline-secondary">
                        <i class="fas fa-plus me-2"></i> Open Another Account
                    </button>
                </div>
            </div>
        `;
        
        // Uncomment to actually submit
        // this.submit();
    }
});

// Add real-time validation
document.querySelectorAll('.form-control, .form-select').forEach(input => {
    input.addEventListener('blur', function() {
        if (this.value.trim()) {
            this.style.borderColor = '#10b981';
        }
    });
    
    input.addEventListener('input', function() {
        if (this.classList.contains('error')) {
            this.classList.remove('error');
        }
    });
});
</script>
</body>
</html>