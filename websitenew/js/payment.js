// Payment Integration for Fluoverse
// Replicates the exact Flutter payment flow from pricing_v2.dart
// Handles authentication, payment processing, and user feedback

class PaymentManager {
    constructor() {
        this.isProcessing = false;
        this.apiEndpoint = 'https://fluoverse.onrender.com/create-checkout-session';
        this.appUrl = 'https://fluoverseapp.netlify.app/'; // Your local Flutter app
        this.currentUrl = window.location.href;
        
        // Stripe price IDs from your Flutter app
        this.priceIds = {
            monthly: 'price_1SBXuFJlDbRIIvhYUFjjZ1FA',
            yearly: 'price_1SBZWYJlDbRIIvhYR3A19Lpf'
        };
        
        this.init();
    }
    
    init() {
        console.log('PaymentManager initialized');
        
        // Check for authentication token on page load
        this.checkAuthStatus();
        
        // Add loading states and error handling
        this.setupEventListeners();
    }
    
    setupEventListeners() {
        // Handle billing toggle changes
        const billingToggle = document.getElementById('billing-toggle');
        if (billingToggle) {
            billingToggle.addEventListener('change', () => {
                this.updatePricingDisplay();
            });
        }
        
        // Handle window focus (for when user returns from login)
        window.addEventListener('focus', () => {
            this.checkAuthStatus();
        });
    }
    
    checkAuthStatus() {
        const token = this.extractTokenFromUrl();
        const paymentButton = document.getElementById('paymentButton');
        
        if (token) {
            // User is authenticated
            this.updateButtonState('authenticated');
            this.storeToken(token);
        } else {
            // User needs to login
            this.updateButtonState('needs_auth');
        }
    }
    
    getPromoCode() {
        // No promotional codes currently active
        console.log('❌ No promo code applied');
        return null;
    }
    
    extractTokenFromUrl() {
        console.log('🔍 Extracting token from URL...');
        console.log('📍 Current URL:', window.location.href);
        console.log('📍 Search params:', window.location.search);
        console.log('📍 Hash:', window.location.hash);
        
        // Try normal query parameters first
        const urlParams = new URLSearchParams(window.location.search);
        let token = urlParams.get('token');
        console.log('🔍 Token from search params:', token);
        
        if (token && token.length > 0) {
            console.log('✅ Found token in search params');
            return token;
        }
        
        // Try parsing from fragment (for hash routing)
        const fragment = window.location.hash;
        if (fragment && fragment.includes('token=')) {
            const fragmentParams = new URLSearchParams(fragment.substring(1));
            token = fragmentParams.get('token');
            console.log('🔍 Token from fragment:', token);
            if (token && token.length > 0) {
                console.log('✅ Found token in fragment');
                return token;
            }
        }
        
        // Check localStorage for stored token
        const storedToken = localStorage.getItem('fluoverse_token');
        console.log('🔍 Token from localStorage:', storedToken ? `${storedToken.substring(0, 20)}...` : 'No stored token');
        
        if (storedToken && storedToken.length > 0) {
            console.log('✅ Found token in localStorage');
            return storedToken;
        }
        
        console.log('❌ No token found anywhere');
        return null;
    }
    
    storeToken(token) {
        localStorage.setItem('fluoverse_token', token);
        // Clean URL to remove token
        this.cleanUrl();
    }
    
    clearStoredToken() {
        localStorage.removeItem('fluoverse_token');
        console.log('🗑️ Cleared stored token');
    }
    
    cleanUrl() {
        const url = new URL(window.location);
        url.searchParams.delete('token');
        url.hash = '';
        window.history.replaceState({}, document.title, url.toString());
    }
    
    updateButtonState(state) {
        const button = document.getElementById('paymentButton');
        const ctaButton = document.querySelector('.cta-buttons .btn-primary');
        
        if (!button) return;
        
        // Allow per-page label overrides via data-attributes
        const labels = {
            authenticated: button.getAttribute('data-auth-label') || 'Start Learning Free',
            needs_auth: button.getAttribute('data-needs-auth-label') || 'Login to Start',
            processing: button.getAttribute('data-processing-label') || 'Processing...',
            error: button.getAttribute('data-error-label') || 'Try Again'
        };
        
        switch (state) {
            case 'authenticated':
                button.textContent = labels.authenticated;
                button.disabled = false;
                button.classList.remove('btn-disabled');
                if (ctaButton) {
                    ctaButton.textContent = 'Start Free Trial';
                    ctaButton.classList.remove('btn-disabled');
                }
                break;
                
            case 'needs_auth':
                button.textContent = labels.needs_auth;
                button.disabled = false;
                button.classList.remove('btn-disabled');
                if (ctaButton) {
                    ctaButton.textContent = 'Login to Start';
                    ctaButton.classList.remove('btn-disabled');
                }
                break;
                
            case 'processing':
                button.textContent = labels.processing;
                button.disabled = true;
                button.classList.add('btn-loading');
                if (ctaButton) {
                    ctaButton.textContent = 'Processing...';
                    ctaButton.disabled = true;
                    ctaButton.classList.add('btn-loading');
                }
                break;
                
            case 'error':
                button.textContent = labels.error;
                button.disabled = false;
                button.classList.remove('btn-loading');
                if (ctaButton) {
                    ctaButton.textContent = 'Try Again';
                    ctaButton.disabled = false;
                    ctaButton.classList.remove('btn-loading');
                }
                break;
        }
    }
    
    updatePricingDisplay() {
        const billingToggle = document.getElementById('billing-toggle');
        if (!billingToggle) return; // Exit if toggle doesn't exist
        
        const isYearly = billingToggle.checked;
        const monthlyPrice = document.querySelector('.monthly-price');
        const yearlyPrice = document.querySelector('.yearly-price');
        const yearlyNote = document.querySelector('.yearly-note');
        const yearlyFeatures = document.querySelectorAll('.yearly-feature');
        
        if (monthlyPrice && yearlyPrice) {
            monthlyPrice.style.display = isYearly ? 'none' : 'inline';
            yearlyPrice.style.display = isYearly ? 'inline' : 'none';
        }
        
        if (yearlyNote) {
            yearlyNote.style.display = isYearly ? 'block' : 'none';
        }
        
        yearlyFeatures.forEach(feature => {
            feature.style.display = isYearly ? 'flex' : 'none';
        });
    }
    
    async startPayment() {
        if (this.isProcessing) return;
        
        const token = this.extractTokenFromUrl();
        console.log('🔍 Extracted token:', token ? `${token.substring(0, 20)}...` : 'No token found');
        
        if (!token) {
            console.log('❌ No token found - showing login prompt');
            this.showLoginPrompt();
            return;
        }
        
        // Double-check: if we still don't have a token, don't proceed
        if (!token || token.length === 0) {
            console.log('❌ Still no token after extraction - aborting payment');
            this.showLoginPrompt();
            return;
        }
        
        this.isProcessing = true;
        this.updateButtonState('processing');
        this.showLoadingOverlay();
        
        try {
            const billingToggle = document.getElementById('billing-toggle');
            const isYearly = billingToggle ? billingToggle.checked : false;
            const priceId = isYearly ? this.priceIds.yearly : this.priceIds.monthly;
            const period = isYearly ? 'yearly' : 'monthly';
            
            // Check if promo code should be applied
            const promoCode = this.getPromoCode();
            
            const requestBody = {
                price_id: priceId,
                period: period,
                plan_name: 'Fluoverse Premium',
                coupon_code: promoCode
            };
            
            console.log('🚀 Making payment request to:', this.apiEndpoint);
            console.log('📦 Request body:', requestBody);
            console.log('🔑 Using token:', `${token.substring(0, 20)}...`);
            
            const response = await fetch(this.apiEndpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify(requestBody)
            });
            
            console.log('📡 Response status:', response.status);
            console.log('📡 Response ok:', response.ok);
            
            if (response.ok) {
                const data = await response.json();
                const checkoutUrl = data.checkout_url;
                
                if (checkoutUrl && this.isValidStripeUrl(checkoutUrl)) {
                    console.log('✅ Stripe checkout URL received:', checkoutUrl);
                    
                    // Open Stripe checkout in external application (like Flutter does)
                    window.open(checkoutUrl, '_blank');
                    
                    // Wait a moment for Stripe to open, then close the website tab
                    setTimeout(() => {
                        console.log('🚀 Closing website tab - Stripe will handle the rest');
                        window.close();
                    }, 500);
                } else {
                    console.log('❌ Invalid Stripe URL received:', checkoutUrl);
                    throw new Error('Invalid payment URL received from server');
                }
            } else {
                const errorData = await response.json().catch(() => ({}));
                console.log('❌ Error response data:', errorData);
                console.log('❌ Error status:', response.status);
                
                // If we get a 401, clear any stored token as it's invalid
                if (response.status === 401) {
                    console.log('🔐 401 Unauthorized - clearing stored token');
                    this.clearStoredToken();
                }
                
                throw new Error(this.getErrorMessage(response.status, errorData));
            }
        } catch (error) {
            console.error('❌ Exception in startPayment:', error);
            this.hideLoadingOverlay();
            this.updateButtonState('error');
            
            // Use the same error handling as Flutter
            let errorMessage = 'Error launching checkout';
            if (error.message.includes('No checkout URL')) {
                errorMessage = 'Server did not provide a valid payment URL. Please try again.';
            } else if (error.message.includes('Invalid payment URL')) {
                errorMessage = 'Invalid payment URL received. Please try again.';
            } else if (error.message.includes('Failed to create checkout session')) {
                errorMessage = 'Unable to create payment session. Please check your login status and try again.';
            } else {
                errorMessage = `Error launching checkout: ${error.message}`;
            }
            
            this.showMessage(errorMessage, 'error');
        } finally {
            this.isProcessing = false;
        }
    }
    
    getFeaturesList(isYearly) {
        const baseFeatures = [
            'Unlimited daily usage',
            'Daily Fluency Rooms with real people',
            'Monthly 7-day Fluency Sprints',
            'Priority support'
        ];
        
        if (isYearly) {
            baseFeatures.push('One-on-one feedback calls');
        }
        
        return baseFeatures;
    }
    
    isValidStripeUrl(url) {
        return url.includes('stripe.com') || url.includes('checkout.stripe.com');
    }
    
    getErrorMessage(status, errorData) {
        switch (status) {
            case 400:
                return 'Invalid request. Please check your login status and try again.';
            case 401:
                return 'Authentication failed. Please log in again.';
            case 500:
                return 'Server error. Please try again later.';
            default:
                return errorData.message || 'Failed to create checkout session. Please try again.';
        }
    }
    
    getUserFriendlyError(error) {
        if (error.includes('No checkout URL')) {
            return 'Server did not provide a valid payment URL. Please try again.';
        } else if (error.includes('Invalid payment URL')) {
            return 'Invalid payment URL received. Please try again.';
        } else if (error.includes('Failed to create checkout session')) {
            return 'Unable to create payment session. Please check your login status and try again.';
        } else {
            return `Payment error: ${error}`;
        }
    }
    
    showLoginPrompt() {
        console.log('🚀 Showing login prompt modal...');
        console.log('🔍 Creating modal element...');
        const modal = document.createElement('div');
        modal.className = 'login-modal-overlay';
        modal.innerHTML = `
            <div class="login-modal">
                <div class="login-modal-content">
                    <div class="login-icon">🔐</div>
                    <h3>Login Required</h3>
                    <p>You need to log in or sign up to join Fluoverse Premium.</p>
                    <div class="login-modal-buttons">
                        <button class="btn btn-primary" onclick="paymentManager.redirectToLogin()">
                            Login / Sign Up
                        </button>
                        <button class="btn btn-secondary" onclick="paymentManager.closeLoginModal()">
                            Cancel
                        </button>
                    </div>
                </div>
            </div>
        `;
        
        console.log('🔍 Adding modal to DOM...');
        document.body.appendChild(modal);
        console.log('✅ Modal added to DOM');
        
        // Add styles
        const style = document.createElement('style');
        style.textContent = `
            .login-modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.8);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 10000;
                backdrop-filter: blur(10px);
            }
            
            .login-modal {
                background: rgba(26, 26, 46, 0.95);
                border-radius: 20px;
                padding: 2rem;
                max-width: 400px;
                width: 90%;
                border: 1px solid rgba(102, 126, 234, 0.3);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            }
            
            .login-modal-content {
                text-align: center;
                color: white;
            }
            
            .login-icon {
                font-size: 3rem;
                margin-bottom: 1rem;
            }
            
            .login-modal h3 {
                margin: 0 0 1rem 0;
                font-size: 1.5rem;
                font-weight: 600;
            }
            
            .login-modal p {
                margin: 0 0 2rem 0;
                color: rgba(255, 255, 255, 0.8);
                line-height: 1.5;
            }
            
            .login-modal-buttons {
                display: flex;
                gap: 1rem;
                justify-content: center;
            }
            
            .login-modal-buttons .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                border: none;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            
            .login-modal-buttons .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
            
            .login-modal-buttons .btn-secondary {
                background: transparent;
                color: rgba(255, 255, 255, 0.7);
                border: 1px solid rgba(255, 255, 255, 0.3);
            }
            
            .login-modal-buttons .btn:hover {
                transform: translateY(-2px);
            }
        `;
        document.head.appendChild(style);
    }
    
    redirectToLogin() {
        // Simple redirect to Flutter app - no return_url needed
        console.log('Redirecting to Flutter app for login');
        window.location.href = this.appUrl;
    }
    
    closeLoginModal() {
        const modal = document.querySelector('.login-modal-overlay');
        if (modal) {
            modal.remove();
        }
    }
    
    showLoadingOverlay() {
        const overlay = document.createElement('div');
        overlay.className = 'payment-loading-overlay';
        overlay.innerHTML = `
            <div class="payment-loading">
                <div class="loading-spinner"></div>
                <h3>Redirecting to secure payment...</h3>
                <p>Please wait, do not close this window.</p>
            </div>
        `;
        
        document.body.appendChild(overlay);
        
        // Add styles
        const style = document.createElement('style');
        style.textContent = `
            .payment-loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.9);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 10000;
                backdrop-filter: blur(10px);
            }
            
            .payment-loading {
                text-align: center;
                color: white;
            }
            
            .loading-spinner {
                width: 60px;
                height: 60px;
                border: 4px solid rgba(102, 126, 234, 0.3);
                border-top: 4px solid #667eea;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin: 0 auto 1.5rem;
            }
            
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
            
            .payment-loading h3 {
                margin: 0 0 0.5rem 0;
                font-size: 1.5rem;
                font-weight: 600;
            }
            
            .payment-loading p {
                margin: 0;
                color: rgba(255, 255, 255, 0.8);
            }
        `;
        document.head.appendChild(style);
    }
    
    hideLoadingOverlay() {
        const overlay = document.querySelector('.payment-loading-overlay');
        if (overlay) {
            overlay.remove();
        }
    }
    
    showMessage(message, type = 'info') {
        const messageEl = document.createElement('div');
        messageEl.className = `payment-message payment-message-${type}`;
        messageEl.textContent = message;
        
        document.body.appendChild(messageEl);
        
        // Add styles
        const style = document.createElement('style');
        style.textContent = `
            .payment-message {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 1rem 1.5rem;
                border-radius: 8px;
                color: white;
                font-weight: 600;
                z-index: 10001;
                animation: slideIn 0.3s ease;
            }
            
            .payment-message-success {
                background: linear-gradient(135deg, #4ade80 0%, #22c55e 100%);
            }
            
            .payment-message-error {
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            }
            
            .payment-message-info {
                background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            }
            
            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
        `;
        document.head.appendChild(style);
        
        // Auto remove after 5 seconds
        setTimeout(() => {
            messageEl.remove();
        }, 5000);
    }
}

// Initialize payment manager
const paymentManager = new PaymentManager();

// Global function for onclick handlers
function startPayment() {
    console.log('🎯 startPayment() function called from button click');
    if (typeof paymentManager === 'undefined') {
        console.error('❌ paymentManager is not defined!');
        return;
    }
    console.log('✅ paymentManager found, calling startPayment()');
    paymentManager.startPayment();
}

// Add button state styles
const buttonStyles = document.createElement('style');
buttonStyles.textContent = `
    .btn-disabled {
        opacity: 0.6;
        cursor: not-allowed;
    }
    
    .btn-loading {
        position: relative;
        color: transparent;
    }
    
    .btn-loading::after {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 20px;
        height: 20px;
        margin: -10px 0 0 -10px;
        border: 2px solid transparent;
        border-top: 2px solid currentColor;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
`;
document.head.appendChild(buttonStyles);
