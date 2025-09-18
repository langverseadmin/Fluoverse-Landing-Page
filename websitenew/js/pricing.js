// Pricing Page Specific JavaScript

document.addEventListener('DOMContentLoaded', function() {
    
    // Promotional Banner Functionality
    initializePromoBanner();
    
    // Billing Toggle Functionality
    const billingToggle = document.getElementById('billing-toggle');
    const monthlyPrices = document.querySelectorAll('.monthly-price');
    const yearlyPrices = document.querySelectorAll('.yearly-price');
    const yearlyNotes = document.querySelectorAll('.yearly-note');
    const yearlyFeatures = document.querySelectorAll('.yearly-feature');
    const billingLabels = document.querySelectorAll('.billing-label');
    
    if (billingToggle) {
        billingToggle.addEventListener('change', function() {
            const isYearly = this.checked;
            
            // Toggle prices
            monthlyPrices.forEach(price => {
                price.style.display = isYearly ? 'none' : 'inline';
            });
            
            yearlyPrices.forEach(price => {
                price.style.display = isYearly ? 'inline' : 'none';
            });
            
            yearlyNotes.forEach(note => {
                note.style.display = isYearly ? 'block' : 'none';
            });
            
            yearlyFeatures.forEach(feature => {
                feature.style.display = isYearly ? 'flex' : 'none';
            });
            
            // Update billing labels
            billingLabels.forEach((label, index) => {
                if (index === 0) { // Monthly
                    label.classList.toggle('active', !isYearly);
                } else { // Yearly
                    label.classList.toggle('active', isYearly);
                }
            });
            
            // Add animation to price changes
            const priceAmounts = document.querySelectorAll('.price-amount');
            priceAmounts.forEach(price => {
                price.style.transform = 'scale(0.9)';
                setTimeout(() => {
                    price.style.transform = 'scale(1)';
                }, 150);
            });
        });
    }
    
    // FAQ Accordion Functionality
    const faqItems = document.querySelectorAll('.faq-item');
    
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');
        
        question.addEventListener('click', function() {
            const isActive = item.classList.contains('active');
            
            // Close all other FAQ items
            faqItems.forEach(otherItem => {
                if (otherItem !== item) {
                    otherItem.classList.remove('active');
                }
            });
            
            // Toggle current item
            item.classList.toggle('active', !isActive);
        });
    });
    
    // Plan Button Interactions - Now handled by payment.js
    // The payment.js file handles all payment button interactions
    
    // Plan Card Hover Effects
    const planCards = document.querySelectorAll('.plan-card');
    
    planCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            // Add subtle glow effect
            this.style.boxShadow = '0 25px 50px rgba(102, 126, 234, 0.2)';
        });
        
        card.addEventListener('mouseleave', function() {
            // Remove glow effect (unless it's the popular plan)
            if (!this.classList.contains('popular')) {
                this.style.boxShadow = '';
            }
        });
    });
    
    // Animate plan cards on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const planObserver = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animationPlayState = 'running';
            }
        });
    }, observerOptions);
    
    planCards.forEach(card => {
        card.style.animationPlayState = 'paused';
        planObserver.observe(card);
    });
    
    // Comparison table interactivity
    const featureRows = document.querySelectorAll('.feature-row');
    
    featureRows.forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.background = 'rgba(102, 126, 234, 0.1)';
        });
        
        row.addEventListener('mouseleave', function() {
            this.style.background = '';
        });
    });
    
    // Add scroll indicator for comparison table on mobile
    const comparisonTable = document.querySelector('.comparison-table');
    if (comparisonTable && window.innerWidth <= 768) {
        const scrollIndicator = document.createElement('div');
        scrollIndicator.textContent = '← Scroll to see all features →';
        scrollIndicator.style.textAlign = 'center';
        scrollIndicator.style.color = '#a0a0a0';
        scrollIndicator.style.fontSize = '0.9rem';
        scrollIndicator.style.margin = '1rem 0';
        comparisonTable.parentNode.insertBefore(scrollIndicator, comparisonTable);
    }
    
    // Track pricing page analytics (placeholder)
    function trackPricingEvent(eventName, planName = null) {
        console.log(`Pricing Event: ${eventName}`, planName ? `Plan: ${planName}` : '');
        // Here you would typically send data to your analytics service
    }
    
    // Track plan selections - Now handled by payment.js
    // Payment events are tracked in the PaymentManager class
    
    // Track billing toggle
    if (billingToggle) {
        billingToggle.addEventListener('change', function() {
            trackPricingEvent('billing_toggle', this.checked ? 'yearly' : 'monthly');
        });
    }
    
    // Track FAQ interactions
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        question.addEventListener('click', function() {
            const questionText = this.querySelector('h3').textContent;
            trackPricingEvent('faq_opened', questionText);
        });
    });
    
    // Add entrance animations
    function addEntranceAnimations() {
        const animateElements = document.querySelectorAll('.plan-card, .faq-item');
        
        animateElements.forEach((element, index) => {
            element.style.opacity = '0';
            element.style.transform = 'translateY(30px)';
            
            setTimeout(() => {
                element.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                element.style.opacity = '1';
                element.style.transform = 'translateY(0)';
            }, index * 100);
        });
    }
    
    // Initialize animations when page is loaded
    setTimeout(addEntranceAnimations, 300);
    
    // Add keyboard navigation for accessibility
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            // Close all FAQ items
            faqItems.forEach(item => {
                item.classList.remove('active');
            });
        }
    });
    
    // Auto-highlight popular plan
    const popularPlan = document.querySelector('.plan-card.popular');
    if (popularPlan) {
        // Add subtle pulsing effect
        setInterval(() => {
            popularPlan.style.boxShadow = '0 20px 40px rgba(102, 126, 234, 0.3)';
            setTimeout(() => {
                popularPlan.style.boxShadow = '0 20px 40px rgba(102, 126, 234, 0.2)';
            }, 1000);
        }, 3000);
    }
});

// Promotional Banner Functions
function initializePromoBanner() {
    // Set countdown timer (7 days from now)
    const endTime = new Date().getTime() + (7 * 24 * 60 * 60 * 1000);
    
    function updateCountdown() {
        const now = new Date().getTime();
        const timeLeft = endTime - now;
        
        if (timeLeft > 0) {
            const days = Math.floor(timeLeft / (1000 * 60 * 60 * 24));
            const hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
            
            // Update timer display
            const daysEl = document.getElementById('days');
            const hoursEl = document.getElementById('hours');
            const minutesEl = document.getElementById('minutes');
            const secondsEl = document.getElementById('seconds');
            
            if (daysEl) daysEl.textContent = days.toString().padStart(2, '0');
            if (hoursEl) hoursEl.textContent = hours.toString().padStart(2, '0');
            if (minutesEl) minutesEl.textContent = minutes.toString().padStart(2, '0');
            if (secondsEl) secondsEl.textContent = seconds.toString().padStart(2, '0');
            
            // Add urgency effects when time is running low
            if (days === 0 && hours < 24) {
                const timerItems = document.querySelectorAll('.timer-item');
                timerItems.forEach(item => {
                    item.style.animation = 'timerPulse 0.5s ease-in-out infinite';
                    item.style.background = 'rgba(255, 107, 107, 0.3)';
                });
            }
        } else {
            // Timer expired
            const timerEl = document.querySelector('.promo-timer');
            if (timerEl) {
                timerEl.innerHTML = '<div class="timer-expired">Offer Expired!</div>';
            }
        }
    }
    
    // Update countdown every second
    updateCountdown();
    setInterval(updateCountdown, 1000);
    
    // Add entrance animation to promo banner
    const promoBanner = document.querySelector('.promo-banner');
    if (promoBanner) {
        promoBanner.style.opacity = '0';
        promoBanner.style.transform = 'translateY(-50px)';
        
        setTimeout(() => {
            promoBanner.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
            promoBanner.style.opacity = '1';
            promoBanner.style.transform = 'translateY(0)';
        }, 500);
    }
}

// Copy promo code function
function copyPromoCode() {
    const promoCode = 'COMPLETE20';
    
    // Create temporary textarea element
    const textarea = document.createElement('textarea');
    textarea.value = promoCode;
    document.body.appendChild(textarea);
    textarea.select();
    
    try {
        // Copy to clipboard
        document.execCommand('copy');
        
        // Show success feedback
        const button = document.querySelector('.promo-button');
        const originalText = button.innerHTML;
        
        button.innerHTML = '<span class="button-text">Copied!</span><span class="button-icon">✓</span>';
        button.style.background = 'linear-gradient(45deg, #22c55e, #16a34a)';
        
        setTimeout(() => {
            button.innerHTML = originalText;
            button.style.background = 'linear-gradient(45deg, #ffd700, #ffed4e)';
        }, 2000);
        
        // Track promo code copy event
        console.log('Promo code copied:', promoCode);
        
    } catch (err) {
        console.error('Failed to copy promo code:', err);
        
        // Fallback: show code in alert
        alert(`Promo code: ${promoCode}`);
    } finally {
        // Clean up
        document.body.removeChild(textarea);
    }
}

// Add CSS for timer expired state
const style = document.createElement('style');
style.textContent = `
    .timer-expired {
        font-size: 1.5rem;
        font-weight: 700;
        color: #ff6b6b;
        text-align: center;
        padding: 1rem;
        background: rgba(255, 107, 107, 0.1);
        border: 2px solid #ff6b6b;
        border-radius: 12px;
        animation: pulse 1s ease-in-out infinite;
    }
`;
document.head.appendChild(style);


