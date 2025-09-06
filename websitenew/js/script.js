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
    
    // Demo button interaction
    const demoBtn = document.getElementById('demo-btn');
    if (demoBtn) {
        demoBtn.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Add loading state
            const originalText = this.textContent;
            this.textContent = 'Loading Demo...';
            this.style.pointerEvents = 'none';
            
            // Simulate demo loading
            setTimeout(() => {
                alert('Demo would open here! This is just a UI preview.');
                this.textContent = originalText;
                this.style.pointerEvents = 'auto';
            }, 1500);
        });
    }
    
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
