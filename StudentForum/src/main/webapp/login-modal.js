// login-modal.js

// Open modal and freeze background
function openLoginModal() {
    const modal = document.getElementById("loginModal");
    if (modal) {
        modal.style.display = "flex";
        const content = document.querySelector('.content');
        if (content) content.style.overflow = 'hidden';
    }
}

// Close modal and restore background scroll
function closeLoginModal() {
    const modal = document.getElementById("loginModal");
    if (modal) {
        modal.style.display = "none";
        const content = document.querySelector('.content');
        if (content) content.style.overflow = 'auto';
    }
}

/**
 * Generic login check for buttons or forms
 * @param {Event} event - click or submit event
 * @param {boolean} isLoggedIn - true if user is logged in
 * @param {string|null} redirectUrl - optional URL to navigate if logged in
 */
function requireLogin(event, isLoggedIn, redirectUrl = null) {
    if (!isLoggedIn) {
        event.preventDefault();
        openLoginModal();
        return false;
    }
    if (redirectUrl) {
        window.location.href = redirectUrl;
        return false;
    }
    return true; // allow normal action
}
