// Mobile Navigation Toggle
document.addEventListener('DOMContentLoaded', function() {
    const navToggle = document.getElementById('nav-toggle');
    const navMenu = document.getElementById('nav-menu');
    
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('show');
            navToggle.classList.toggle('active');
        });
        
        // Close menu when clicking on a link
        const navLinks = navMenu.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('show');
                navToggle.classList.remove('active');
            });
        });
    }
    
    // Smooth scrolling for anchor links
    const links = document.querySelectorAll('a[href^="#"]');
    links.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                const offsetTop = targetElement.offsetTop - 80; // Account for fixed navbar
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Demo button interaction - now handled by payment.js
    // Removed demo button functionality as it now uses startPayment()
    
    // Initialize countdown badge
    initializeCountdownBadge();
    
    // Intersection Observer for animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);
    
    // Observe elements for animation
    const animateElements = document.querySelectorAll('.feature-card, .testimonial-card, .floating-card');
    animateElements.forEach(el => {
        observer.observe(el);
    });
    
    // Add scroll effect to navbar
    let lastScrollTop = 0;
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', function() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (scrollTop > lastScrollTop && scrollTop > 100) {
            // Scrolling down
            navbar.style.transform = 'translateY(-100%)';
        } else {
            // Scrolling up
            navbar.style.transform = 'translateY(0)';
        }
        
        lastScrollTop = scrollTop;
    });
    
    // Animated counter for metrics
    function animateCounters() {
        const counters = document.querySelectorAll('.metric-value');
        
        counters.forEach(counter => {
            const target = counter.textContent;
            const numTarget = parseFloat(target.replace(/[^\d.-]/g, ''));
            
            if (!isNaN(numTarget)) {
                let current = 0;
                const increment = numTarget / 50;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= numTarget) {
                        counter.textContent = target;
                        clearInterval(timer);
                    } else {
                        const suffix = target.replace(/[\d.-]/g, '');
                        counter.textContent = Math.floor(current) + suffix;
                    }
                }, 40);
            }
        });
    }
    
    // Start counter animation when hero section is visible
    const heroSection = document.querySelector('.hero');
    if (heroSection) {
        const heroObserver = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    setTimeout(animateCounters, 1000);
                    heroObserver.unobserve(entry.target);
                }
            });
        });
        
        heroObserver.observe(heroSection);
    }
    
    // Chart bar animation
    function animateChartBars() {
        const chartBars = document.querySelectorAll('.chart-bar');
        chartBars.forEach((bar, index) => {
            setTimeout(() => {
                bar.style.animation = 'chartGrow 1s ease-out forwards';
            }, index * 100);
        });
    }
    
    // Animate chart when demo section is visible
    const demoSection = document.querySelector('.demo');
    if (demoSection) {
        const chartObserver = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    setTimeout(animateChartBars, 500);
                    chartObserver.unobserve(entry.target);
                }
            });
        });
        
        chartObserver.observe(demoSection);
    }
    
    // Add smooth reveal animation to hero title
    setTimeout(() => {
        const heroTitle = document.querySelector('.hero-title');
        if (heroTitle) {
            heroTitle.style.opacity = '0';
            heroTitle.style.transform = 'translateY(30px)';
            heroTitle.style.transition = 'all 1s ease';
            
            setTimeout(() => {
                heroTitle.style.opacity = '1';
                heroTitle.style.transform = 'translateY(0)';
            }, 300);
        }
        
        const heroSubtitle = document.querySelector('.hero-subtitle');
        if (heroSubtitle) {
            heroSubtitle.style.opacity = '0';
            heroSubtitle.style.transform = 'translateY(20px)';
            heroSubtitle.style.transition = 'all 1s ease';
            
            setTimeout(() => {
                heroSubtitle.style.opacity = '1';
                heroSubtitle.style.transform = 'translateY(0)';
            }, 600);
        }
    }, 200);
    
    // Create floating orbs background animation
    function createFloatingOrbs() {
        const orbContainer = document.createElement('div');
        orbContainer.className = 'floating-orbs';
        orbContainer.style.position = 'fixed';
        orbContainer.style.top = '0';
        orbContainer.style.left = '0';
        orbContainer.style.width = '100%';
        orbContainer.style.height = '100%';
        orbContainer.style.pointerEvents = 'none';
        orbContainer.style.zIndex = '1';
        
        for (let i = 0; i < 6; i++) {
            const orb = document.createElement('div');
            orb.className = 'floating-orb';
            orb.style.position = 'absolute';
            orb.style.borderRadius = '50%';
            orb.style.background = `radial-gradient(circle, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.05) 100%)`;
            orb.style.filter = 'blur(1px)';
            
            const size = Math.random() * 200 + 100;
            orb.style.width = size + 'px';
            orb.style.height = size + 'px';
            
            orb.style.left = Math.random() * window.innerWidth + 'px';
            orb.style.top = Math.random() * window.innerHeight + 'px';
            
            const duration = Math.random() * 20 + 15;
            orb.style.animation = `floatOrb ${duration}s ease-in-out infinite`;
            orb.style.animationDelay = Math.random() * 5 + 's';
            
            orbContainer.appendChild(orb);
        }
        
        document.body.appendChild(orbContainer);
    }
    
    createFloatingOrbs();
    
    // Form validation (if forms are added later)
    function validateForm(form) {
        const inputs = form.querySelectorAll('input[required], textarea[required]');
        let isValid = true;
        
        inputs.forEach(input => {
            if (!input.value.trim()) {
                input.classList.add('error');
                isValid = false;
            } else {
                input.classList.remove('error');
            }
        });
        
        return isValid;
    }
    
    // Add loading states to buttons
    function addLoadingState(button, originalText = 'Loading...') {
        button.disabled = true;
        button.style.opacity = '0.7';
        button.textContent = originalText;
        
        setTimeout(() => {
            button.disabled = false;
            button.style.opacity = '1';
        }, 2000);
    }
    
    // Initialize tooltips (if needed)
    function initTooltips() {
        const tooltipElements = document.querySelectorAll('[data-tooltip]');
        
        tooltipElements.forEach(element => {
            element.addEventListener('mouseenter', function() {
                const tooltip = document.createElement('div');
                tooltip.className = 'tooltip';
                tooltip.textContent = this.getAttribute('data-tooltip');
                tooltip.style.position = 'absolute';
                tooltip.style.background = 'rgba(0, 0, 0, 0.9)';
                tooltip.style.color = 'white';
                tooltip.style.padding = '8px 12px';
                tooltip.style.borderRadius = '6px';
                tooltip.style.fontSize = '14px';
                tooltip.style.zIndex = '1000';
                tooltip.style.pointerEvents = 'none';
                
                document.body.appendChild(tooltip);
                
                const rect = this.getBoundingClientRect();
                tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
                tooltip.style.top = rect.top - tooltip.offsetHeight - 10 + 'px';
            });
            
            element.addEventListener('mouseleave', function() {
                const tooltip = document.querySelector('.tooltip');
                if (tooltip) {
                    tooltip.remove();
                }
            });
        });
    }
    
    initTooltips();
});

// Launch Fluoverse App function
function launchFluoverse(path = '') {
    console.log('🚀 Launching Fluoverse app...');
    
    // Get UTM data to pass to app
    const utmData = getUTMData();
    
    // Build base URL with optional path (deep link)
    const baseUrl = 'https://fluoverseapp.netlify.app';
    const targetBase = path ? `${baseUrl}${path.startsWith('/') ? path : `/${path}`}` : `${baseUrl}/`;
    
    // Build URL with UTM parameters if they exist
    if (Object.keys(utmData).length > 0) {
        const params = new URLSearchParams();
        Object.entries(utmData).forEach(([key, value]) => {
            if (value) params.append(key, value);
        });
        
        const finalUrl = `${targetBase}?${params.toString()}`;
        window.location.href = finalUrl;
    } else {
        window.location.href = targetBase;
    }
}

// Spanish words rotation for mic button
const spanishWords = [
    ['¿Cómo estás?', 'Mucho gusto', 'Hasta luego'],
    ['Buenos días', '¿Cómo te llamas?', 'Mucho gusto'],
    ['¿Qué tal?', 'Encantado', 'Hasta pronto'],
    ['¿Cómo va?', 'Un placer', 'Nos vemos'],
    ['¿Todo bien?', 'Es un gusto', 'Hasta la vista']
];

let currentWordSet = 0;

// Function to rotate Spanish words
function rotateSpanishWords() {
    const wordBubbles = document.querySelectorAll('.word-bubble');
    
    if (wordBubbles.length === 0) return;
    
    // Get next word set
    currentWordSet = (currentWordSet + 1) % spanishWords.length;
    const newWords = spanishWords[currentWordSet];
    
    // Update word content
    wordBubbles.forEach((bubble, index) => {
        if (newWords[index]) {
            bubble.textContent = newWords[index];
        }
    });
}

// Function to combine words into a sentence
function combineWordsIntoSentence() {
    const wordBubbles = document.querySelectorAll('.word-bubble');
    
    if (wordBubbles.length === 0) return;
    
    // Get current words
    const currentWords = Array.from(wordBubbles).map(bubble => bubble.textContent);
    
    // Create sentence combinations
    const sentenceCombinations = [
        `${currentWords[0]} ${currentWords[1]} ${currentWords[2]}`,
        `${currentWords[0]} ${currentWords[2]} ${currentWords[1]}`,
        `${currentWords[1]} ${currentWords[0]} ${currentWords[2]}`,
        `${currentWords[1]} ${currentWords[2]} ${currentWords[0]}`,
        `${currentWords[2]} ${currentWords[0]} ${currentWords[1]}`,
        `${currentWords[2]} ${currentWords[1]} ${currentWords[0]}`
    ];
    
    // Pick a random combination
    const randomSentence = sentenceCombinations[Math.floor(Math.random() * sentenceCombinations.length)];
    
    // Hide all existing bubbles
    wordBubbles.forEach((bubble) => {
        bubble.style.opacity = '0';
        bubble.style.transform = 'scale(0)';
    });
    
    // Get the microphone visual container
    const micVisual = document.querySelector('.microphone-visual');
    console.log('MicVisual found:', micVisual);
    console.log('Random sentence:', randomSentence);
    
    // Create a new centered sentence bubble - positioned relative to button
    const sentenceBubble = document.createElement('div');
    sentenceBubble.className = 'word-bubble sentence-bubble';
    sentenceBubble.textContent = randomSentence;
    sentenceBubble.style.position = 'absolute';
    sentenceBubble.style.left = '50%';
    sentenceBubble.style.top = '+80px';
    sentenceBubble.style.transform = 'translateX(-50%) scale(0)';
    sentenceBubble.style.fontSize = '0.9rem';
    sentenceBubble.style.padding = '0.8rem 1.5rem';
    sentenceBubble.style.zIndex = '10';
    sentenceBubble.style.opacity = '0';
    sentenceBubble.style.textAlign = 'center';
    sentenceBubble.style.whiteSpace = 'nowrap';
    sentenceBubble.style.width = 'auto';
    
    // Add directly to the microphone visual container
    if (micVisual) {
        micVisual.appendChild(sentenceBubble);
        console.log('Sentence bubble added to micVisual');
        
        // Animate in
        setTimeout(() => {
            sentenceBubble.style.opacity = '1';
            sentenceBubble.style.transform = 'translateX(-50%) scale(1)';
        }, 100);
    }
    
    // Reset after 3 seconds
    setTimeout(() => {
        // Animate out
        sentenceBubble.style.opacity = '0';
        sentenceBubble.style.transform = 'translateX(-50%) scale(0)';
        
        setTimeout(() => {
            // Remove sentence bubble
            if (sentenceBubble.parentNode) {
                sentenceBubble.parentNode.removeChild(sentenceBubble);
            }
            
            // Show original bubbles
            wordBubbles.forEach((bubble) => {
                bubble.style.opacity = '1';
                bubble.style.transform = 'scale(1)';
            });
            
            // Rotate to next word set
            rotateSpanishWords();
        }, 300);
    }, 3000);
}

// Add click event to mic button
document.addEventListener('DOMContentLoaded', function() {
    const micButton = document.querySelector('.mic-button');
    if (micButton) {
        let isPressed = false;
        let pressTimer = null;
        
        // Check if device is mobile
        const isMobile = window.innerWidth <= 768;
        
        if (isMobile) {
            // Mobile: Only tap functionality - no press mechanism
            micButton.addEventListener('click', function() {
                rotateSpanishWords();
            });
        } else {
            // Desktop: Press and hold functionality
            // Handle button press (mousedown)
            micButton.addEventListener('mousedown', function() {
                isPressed = true;
                // Start timer to combine words after holding for 500ms
                pressTimer = setTimeout(() => {
                    if (isPressed) {
                        combineWordsIntoSentence();
                    }
                }, 500);
            });
            
            // Handle button release (mouseup)
            micButton.addEventListener('mouseup', function() {
                isPressed = false;
                if (pressTimer) {
                    clearTimeout(pressTimer);
                    pressTimer = null;
                }
                // If released before 500ms, just rotate words
                if (!pressTimer) {
                    rotateSpanishWords();
                }
            });
            
            // Handle mouse leave while pressed
            micButton.addEventListener('mouseleave', function() {
                isPressed = false;
                if (pressTimer) {
                    clearTimeout(pressTimer);
                    pressTimer = null;
                }
            });
        }
    }
});

// Testimonials Carousel
document.addEventListener('DOMContentLoaded', function() {
    const container = document.querySelector('.testimonials-container');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const dots = document.querySelectorAll('.dot');
    
    if (!container || !prevBtn || !nextBtn) return;
    
    let currentSlide = 0;
    const totalSlides = container.children.length;
    
    function updateCarousel() {
        const translateX = -currentSlide * 100;
        container.style.transform = `translateX(${translateX}%)`;
        
        // Update dots
        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === currentSlide);
        });
    }
    
    function nextSlide() {
        currentSlide = (currentSlide + 1) % totalSlides;
        updateCarousel();
    }
    
    function prevSlide() {
        currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
        updateCarousel();
    }
    
    function goToSlide(slideIndex) {
        currentSlide = slideIndex;
        updateCarousel();
    }
    
    // Event listeners
    nextBtn.addEventListener('click', nextSlide);
    prevBtn.addEventListener('click', prevSlide);
    
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => goToSlide(index));
    });
    
    // Auto-play (optional)
    setInterval(nextSlide, 9000);
});

// Read more functionality for testimonials
function toggleReadMore(button) {
    const testimonialCard = button.closest('.testimonial-card');
    const shortText = testimonialCard.querySelector('.testimonial-text');
    const fullText = testimonialCard.querySelector('.testimonial-text-full');
    
    if (fullText.style.display === 'none') {
        // Show full text
        shortText.style.display = 'none';
        fullText.style.display = 'block';
        button.textContent = 'Read less';
        
        // Expand the card slightly for longer text
        testimonialCard.style.maxHeight = 'none';
    } else {
        // Show short text
        shortText.style.display = 'block';
        fullText.style.display = 'none';
        button.textContent = 'Read more';
        
        // Reset card height
        testimonialCard.style.maxHeight = '';
    }
}

// Add CSS for animations
const style = document.createElement('style');
style.textContent = `
    .nav-menu.show {
        display: flex !important;
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background: rgba(10, 10, 10, 0.95);
        backdrop-filter: blur(20px);
        flex-direction: column;
        padding: 2rem;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .nav-toggle.active span:nth-child(1) {
        transform: rotate(45deg) translate(5px, 5px);
    }
    
    .nav-toggle.active span:nth-child(2) {
        opacity: 0;
    }
    
    .nav-toggle.active span:nth-child(3) {
        transform: rotate(-45deg) translate(7px, -6px);
    }
    
    .animate-in {
        animation: slideInUp 0.6s ease-out forwards;
    }
    
    @keyframes slideInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .navbar {
        transition: transform 0.3s ease;
    }
    
    .error {
        border-color: #ff4757 !important;
        box-shadow: 0 0 0 2px rgba(255, 71, 87, 0.2) !important;
    }
    
    @media (max-width: 768px) {
        .nav-menu {
            display: none;
        }
        
        .nav-toggle {
            display: flex !important;
        }
    }
`;

document.head.appendChild(style);

// Fluency Sprint Popup Functions
function initFluencyPopup() {
    // Check if popup was already shown in this session
    if (sessionStorage.getItem('fluencyPopupShown')) {
        return;
    }
    
    // Show popup after 3 seconds
    setTimeout(() => {
        showFluencyPopup();
    }, 3000);
}

function showFluencyPopup() {
    const popup = document.getElementById('fluency-sprint-popup');
    if (popup) {
        popup.classList.add('show');
        // Mark as shown in this session
        sessionStorage.setItem('fluencyPopupShown', 'true');
        
        // Prevent body scroll when popup is open
        document.body.style.overflow = 'hidden';
    }
}

function closeFluencyPopup() {
    const popup = document.getElementById('fluency-sprint-popup');
    if (popup) {
        popup.classList.remove('show');
        // Restore body scroll
        document.body.style.overflow = '';
    }
}

function joinFluencySprint() {
    // Close popup first
    closeFluencyPopup();
    
    // Redirect to competition info page
    window.location.href = 'competition.html';
}

// Close popup when clicking outside
document.addEventListener('click', function(e) {
    const popup = document.getElementById('fluency-sprint-popup');
    if (popup && e.target === popup) {
        closeFluencyPopup();
    }
});

// Close popup with Escape key
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        closeFluencyPopup();
    }
});

// UTM Parameter Management
let utmData = {};

// Parse UTM parameters from URL
function parseUTMParameters() {
    const urlParams = new URLSearchParams(window.location.search);
    const utmParams = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_content', 'utm_term'];
    
    utmData = {};
    utmParams.forEach(param => {
        const value = urlParams.get(param);
        if (value) {
            utmData[param] = value;
        }
    });
    
    // Store in sessionStorage for persistence across page navigation
    if (Object.keys(utmData).length > 0) {
        sessionStorage.setItem('utmData', JSON.stringify(utmData));
        console.log('UTM Parameters captured:', utmData);
    }
    
    return utmData;
}

// Get stored UTM data (from current URL or sessionStorage)
function getUTMData() {
    // First try to get from current URL
    const currentUTM = parseUTMParameters();
    if (Object.keys(currentUTM).length > 0) {
        return currentUTM;
    }
    
    // Fallback to sessionStorage
    const storedUTM = sessionStorage.getItem('utmData');
    if (storedUTM) {
        try {
            return JSON.parse(storedUTM);
        } catch (e) {
            console.error('Error parsing stored UTM data:', e);
        }
    }
    
    return {};
}

// Send UTM data to backend when user activates/joins
function sendUTMData(action = 'activation') {
    const utmData = getUTMData();
    
    if (Object.keys(utmData).length === 0) {
        console.log('No UTM data to send');
        return;
    }
    
    // Prepare payload
    const payload = {
        action: action,
        timestamp: new Date().toISOString(),
        page_url: window.location.href,
        referrer: document.referrer,
        user_agent: navigator.userAgent,
        ...utmData
    };
    
    // Send to your backend endpoint
    fetch('https://fluoverse.onrender.com/api/utm/track', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload)
    })
    .then(response => {
        if (response.ok) {
            console.log('UTM data sent successfully:', payload);
        } else {
            console.error('Failed to send UTM data:', response.status);
        }
    })
    .catch(error => {
        console.error('Error sending UTM data:', error);
    });
}

// Enhanced launchFluoverse function with UTM tracking
function launchFluoverseWithUTM(path = '') {
    // Send UTM data before redirecting
    sendUTMData('app_launch');
    
    // Launch the app
    launchFluoverse(path);
}

// Enhanced startPayment function with UTM tracking
function startPaymentWithUTM() {
    // Send UTM data before starting payment
    sendUTMData('payment_start');
    
    // Call the original startPayment function
    if (typeof startPayment === 'function') {
        startPayment();
    } else {
        console.error('startPayment function not found');
    }
}

// Enhanced joinFluencySprint function with UTM tracking
function joinFluencySprintWithUTM() {
    // Send UTM data before redirecting
    sendUTMData('competition_join');
    
    // Close popup and redirect
    closeFluencyPopup();
    window.location.href = 'competition.html';
}

// Initialize popup when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Parse UTM parameters on page load
    parseUTMParameters();
    
    // Initialize popup
    initFluencyPopup();
    
    // Initialize referral system
    initReferralSystem();
});

// Countdown Badge Function
function initializeCountdownBadge() {
    const badgeElement = document.getElementById('countdown-badge');
    if (!badgeElement) return;
    
    // Set sprint start date (October 24, 2025)
    const sprintStartDate = new Date('2025-10-24T00:00:00');
    
    function updateCountdown() {
        const now = new Date();
        const timeLeft = sprintStartDate - now;
        
        if (timeLeft > 0) {
            const days = Math.ceil(timeLeft / (1000 * 60 * 60 * 24));
            const hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            
            if (days > 1) {
                badgeElement.textContent = `${days} days left`;
            } else if (days === 1) {
                badgeElement.textContent = 'Tomorrow!';
            } else if (hours > 0) {
                badgeElement.textContent = `${hours}h left`;
            } else {
                badgeElement.textContent = 'Starting now!';
            }
            
            // Add urgency styling when time is running low
            if (days <= 1) {
                badgeElement.style.background = 'rgba(255, 107, 107, 0.25)';
                badgeElement.style.borderColor = 'rgba(255, 107, 107, 0.5)';
                badgeElement.style.animation = 'subtlePulse 1.5s ease-in-out infinite';
            }
        } else {
            badgeElement.textContent = 'Live now!';
            badgeElement.style.background = 'rgba(34, 197, 94, 0.15)';
            badgeElement.style.color = '#22c55e';
            badgeElement.style.borderColor = 'rgba(34, 197, 94, 0.3)';
        }
    }
    
    // Update immediately and then every hour
    updateCountdown();
    setInterval(updateCountdown, 3600000); // Update every hour
}

// ==================== REFERRAL CODE PRESERVATION ====================

// Check if user is authenticated (check for main app auth)
function isUserAuthenticated() {
    // Check for main app authentication (access token in localStorage)
    const accessToken = localStorage.getItem('accessToken');
    return accessToken && accessToken.startsWith('eyJ');
}

// Check if current user was referred (for tracking purposes)
function checkReferralSource() {
    const urlParams = new URLSearchParams(window.location.search);
    const referralCode = urlParams.get('ref');
    
    if (referralCode) {
        console.log('🎯 Referral code detected:', referralCode);
        // Store referral code for processing when user joins
        localStorage.setItem('fluoverse_referral_source', referralCode);
    }
}

// Initialize referral system (only for UI display and referral code preservation)
function initReferralSystem() {
    // Check if we're on the competition page
    if (!window.location.pathname.includes('competition.html')) {
        return;
    }
    
    // Always show the "Get My Referral Code" section
    const getReferralSection = document.getElementById('get-referral-code-section');
    if (getReferralSection) {
        getReferralSection.style.display = 'block';
    }
    
    // Always check for referral source (for both authenticated and non-authenticated users)
    checkReferralSource();
}

// Show referral UI for authenticated users
function showAuthenticatedReferralUI() {
    // Hide the "Get Referral Code" section
    const getReferralSection = document.getElementById('get-referral-code-section');
    if (getReferralSection) {
        getReferralSection.style.display = 'none';
    }
    
    // Show the referral progress section (first grid in referral section)
    const progressSection = document.querySelector('#referral-section > div:nth-child(2)');
    if (progressSection) progressSection.style.display = 'grid';
    
    // Show the referral link section (third div in referral section)
    const linkSection = document.querySelector('#referral-section > div:nth-child(3)');
    if (linkSection) linkSection.style.display = 'block';
    
    // Show the rewards section (fourth div in referral section)
    const rewardsSection = document.querySelector('#referral-section > div:nth-child(4)');
    if (rewardsSection) rewardsSection.style.display = 'block';
}

// Show referral UI for non-authenticated users
function showUnauthenticatedReferralUI() {
    // Show the "Get Referral Code" section
    const getReferralSection = document.getElementById('get-referral-code-section');
    if (getReferralSection) {
        getReferralSection.style.display = 'block';
    }
    
    // Hide the referral progress section
    const progressSection = document.querySelector('#referral-section > div:nth-child(2)');
    if (progressSection) progressSection.style.display = 'none';
    
    // Hide the referral link section
    const linkSection = document.querySelector('#referral-section > div:nth-child(3)');
    if (linkSection) linkSection.style.display = 'none';
    
    // Hide the rewards section
    const rewardsSection = document.querySelector('#referral-section > div:nth-child(4)');
    if (rewardsSection) rewardsSection.style.display = 'none';
}

// Get referral code from current URL
function getReferralCodeFromURL() {
    const urlParams = new URLSearchParams(window.location.search);
    const referralCode = urlParams.get('ref');
    
    if (referralCode) {
        console.log('🎯 Referral code detected:', referralCode);
    }
    
    return referralCode;
}

// Create Flutter app URL with preserved referral code
function createFlutterAppURL() {
    const baseURL = 'https://fluoverseapp.netlify.app/';
    const referralCode = getReferralCodeFromURL();
    
    if (referralCode) {
        const flutterURL = `${baseURL}?ref=${referralCode}`;
        console.log('🔗 Flutter app URL with preserved referral:', flutterURL);
        return flutterURL;
    }
    
    console.log('🔗 Flutter app URL (no referral):', baseURL);
    return baseURL;
}

// Launch Flutter app with preserved referral code
function launchFluoverseWithPreservedReferral() {
    // Send UTM data
    sendUTMData('app_launch');
    
    // Get the Flutter app URL with preserved referral code
    const flutterURL = createFlutterAppURL();
    
    // Redirect to Flutter app
    window.location.href = flutterURL;
}

// Enhanced launch function (for authenticated users)
function launchFluoverseWithReferral() {
    // Send UTM data and launch app
    sendUTMData('app_launch');
    launchFluoverse();
}

// Export functions for use in other parts of the app
window.referralSystem = {
    init: initReferralSystem,
    launchWithPreservedReferral: launchFluoverseWithPreservedReferral,
    createFlutterAppURL: createFlutterAppURL,
    getReferralCodeFromURL: getReferralCodeFromURL
};