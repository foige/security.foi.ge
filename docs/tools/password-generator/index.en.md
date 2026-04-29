---
title: "FOI Password Generator"
icon: material/key
hide:
  - navigation
---
<link rel="stylesheet" href="/assets/stylesheets/password-generator.css?v=2026-04-29">

# FOI Password Generator

Easy-to-memorize and usage-tailored strong password generator.

<input type="radio" name="password-language" value="en" checked hidden>

<div class="os-selection-container">
  <h3>Choose your devices</h3>
  
  <div class="os-selection">
    <div class="os-group">
      <h4>Mobile device</h4>
      <div class="os-options">
        <label class="os-option">
          <input type="radio" name="mobile-os" value="ios" checked>
          <span class="os-icon">📱</span>
          <span>iOS</span>
        </label>
        <label class="os-option">
          <input type="radio" name="mobile-os" value="android">
          <span class="os-icon">📱</span>
          <span>Android</span>
        </label>
      </div>
    </div>

    <div class="os-group">
      <h4>Computer</h4>
      <div class="os-options">
        <label class="os-option">
          <input type="radio" name="desktop-os" value="macos" checked>
          <span class="os-icon">💻</span>
          <span>macOS</span>
        </label>
        <label class="os-option">
          <input type="radio" name="desktop-os" value="windows">
          <span class="os-icon">💻</span>
          <span>Windows</span>
        </label>
      </div>
    </div>
  </div>
</div>

<div class="button-container">
  <button id="generate-button" onclick="generatePasswords()" disabled>
    <span class="button-text">Generate passwords</span>
  </button>
</div>

<div id="passwords-container" style="display: none;">
  <div class="password-group critical">
    <div class="group-header">
      <span class="header-icon">🔑</span>
      <span class="header-text">Critical passwords</span>
    </div>
    <div class="storage-note critical">
      <div class="warning-banner">Save on paper only!</div>
      <div class="instruction-step">
        <span class="instruction-icon">🧠</span>
        <div class="instruction-content">
          <div class="instruction-title">Memorize the highlighted word immediately</div>
          <div class="instruction-text">Do not write it on paper</div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">✍️</span>
        <div class="instruction-content">
          <div class="instruction-title">Bitwarden password</div>
          <div class="instruction-text">Write the remaining words on <span class="highlight-critical">a separate piece of paper</span>, keep it in a safe place until memorized. <span class="highlight-critical">Do not carry it with you! Do not take a photo!</span> </div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">📱</span>
        <div class="instruction-content">
          <div class="instruction-title">Mobile password</div>
          <div class="instruction-text">Write the remaining words on <span class="highlight-critical">a separate piece of paper</span> until memorized. You can carry this paper with you until fully memorized</div>
          <div class="instruction-note">You can also save this password in Bitwarden</div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">🔥</span>
        <div class="instruction-content">
          <div class="instruction-title">Destroy the papers after memorizing</div>
          <div class="instruction-text">Writing on paper is <span class="highlight-critical">a temporary solution</span> until the password is fully memorized</div>
        </div>
      </div>
    </div>
    <div class="password-item">
      <div class="password-label">Bitwarden password:</div>
      <div id="bitwarden-password" class="password-value"></div>
      <small>This is the most important password and you will use it to protect Bitwarden. As long as you remember this password and all others are stored in Bitwarden, you will never "forget" any password.</small>
      <small><br/>Bitwarden's password cannot be recovered!</small>
    </div>
    <div class="password-item">
      <div class="password-label">Mobile password:</div>
      <div id="mobile-password" class="password-value"></div>
      <small>This password will protect you from Cellebrite if you power off the device.<br/>Combined with Face ID or fingerprint, it offers ideal protection.</small>
    </div>
  </div>

  <div class="password-group other">
    <div class="group-header">
      <span class="header-icon">🔒</span>
      <span class="header-text">Additional passwords</span>
    </div>
    <div class="storage-note">
      <div class="warning-banner storage">Save in Bitwarden only!</div>
      <div class="instruction-step">
        <div class="instruction-icon">🔐</div>
        <div class="instruction-content">
          <div class="instruction-title">Save in Bitwarden</div>
          <div class="instruction-text">
            The passwords listed below
          </div>
          <div class="instruction-note">
            Memorizing these passwords is not necessary — knowing the Bitwarden password is sufficient
          </div>
        </div>
      </div>
      <div class="instruction-divider"></div>
    </div>
    <div id="desktop-passwords"></div>
  </div>
</div>

<div id="additional-note" style="margin: 20px 0;"></div>
<div id="error-message" style="color: red;"></div>

<script>
// File integrity checksums (SHA-256)
const INTEGRITY_CHECKSUMS = {
  'password-generator.js': 'b0f54e2471febadb5e1ec8f6de1004e0cfb3154482d66d6cb0dea45bf220711b',
  'foi_words_en.txt': '08d5274313dd6a0afa05b95d39258af14ae8f0253a04ae4a54f05c0502be77da',
  'foi_words_ka.txt': '144431071c6719c1b80057cb4663f3495241b67d01d0a14aee6246d6cb7d12a6',
  'foi_syllables_en.txt': '1d66cf7aef6228bce29ded75bbcf9b2a27f4765d47eb61f05e8640a233702036',
  'foi_syllables_ka.txt': '9f4eb22deefcfd2c4fef2090d28fa849e23a21b183e4d208fc869d838a8c132d',
};

// Compute SHA-256 hash of content
async function computeHash(content) {
  const encoder = new TextEncoder();
  const data = encoder.encode(content);
  const hashBuffer = await crypto.subtle.digest('SHA-256', data);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

// Verify file integrity
async function verifyIntegrity(filename, content) {
  const expectedHash = INTEGRITY_CHECKSUMS[filename];
  if (!expectedHash) {
    const error = `No integrity check available for ${filename}`;
    document.getElementById('error-message').textContent = error;
    throw new Error(error);
  }

  const actualHash = await computeHash(content);
  if (actualHash !== expectedHash) {
    const error = `Integrity check failed for ${filename}. The file may have been tampered with.`;
    document.getElementById('error-message').textContent = error;
    console.error(error);
    console.error(`Expected: ${expectedHash}`);
    console.error(`Actual: ${actualHash}`);
    throw new Error(error);
  }
}

// Load and verify password generator script
(async function loadPasswordGenerator() {
  try {
    const response = await fetch('/assets/javascripts/password-generator.js?v=2026-04-29');
    if (!response.ok) throw new Error('Failed to load password generator');
    const content = await response.text();
    
    // Verify integrity before executing
    await verifyIntegrity('password-generator.js', content);
    
    // Create and execute script
    const script = document.createElement('script');
    script.text = content;
    document.body.appendChild(script);
  } catch (error) {
    document.getElementById('error-message').textContent = error.message;
    console.error('Failed to load password generator:', error);
  }
})();
</script>
