---
title: "FOI პაროლების გენერატორი"
icon: material/key
hide:
  - navigation
---
<link rel="stylesheet" href="/assets/stylesheets/password-generator.css?v=2026-04-29">

# FOI პაროლების გენერატორი

მარტივად დამახსოვრებადი და გამოყენებაზე მორგებული ძლიერი პაროლების გენერატორი.

<div class="language-selection-container">
  <h3>აირჩიეთ პაროლის ენა</h3>
  <div class="language-selection">
    <label class="language-option recommended" style="width: 100%; margin-bottom: 1rem;">
      <input type="radio" name="password-language" value="combined" checked>
      <span class="language-icon">🌐</span>
      <span>კომბინირებული</span>
      <span class="strength-indicator">💪</span>
    </label>
    <div class="grid">
      <div class="grid-50">
        <label class="language-option">
          <input type="radio" name="password-language" value="ka">
          <span class="language-icon">🇬🇪</span>
          <span>ქართული</span>
        </label>
      </div>
      <div class="grid-50">
        <label class="language-option">
          <input type="radio" name="password-language" value="en">
          <span class="language-icon">🇬🇧</span>
          <span>ინგლისური</span>
        </label>
      </div>
    </div>
  </div>
</div>

<div class="os-selection-container">
  <h3>აირჩიეთ თქვენი მოწყობილობები</h3>
  
  <div class="os-selection">
    <div class="os-group">
      <h4>მობილური მოწყობილობა</h4>
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
      <h4>კომპიუტერი</h4>
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
    <span class="button-text">პაროლების გენერირება</span>
  </button>
</div>

<div id="passwords-container" style="display: none;">
  <div class="password-group critical">
    <div class="group-header">
      <span class="header-icon">🔑</span>
      <span class="header-text">კრიტიკული პაროლები</span>
    </div>
    <div class="storage-note critical">
      <div class="warning-banner">შეინახეთ მხოლოდ ფურცელზე!</div>
      <div class="instruction-step">
        <span class="instruction-icon">🧠</span>
        <div class="instruction-content">
          <div class="instruction-title">დაიზეპირეთ ხაზგასმული სიტყვა მაშინვე</div>
          <div class="instruction-text">არ ჩაწეროთ ის ფურცელზე</div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">✍️</span>
        <div class="instruction-content">
          <div class="instruction-title">Bitwarden-ის პაროლი</div>
          <div class="instruction-text">დარჩენილი სიტყვები ჩაიწერეთ <span class="highlight-critical">ცალკე ფურცელზე</span>, შეინახეთ უსაფრთხო ადგილას დაზეპირებამდე. <span class="highlight-critical">არ ატაროთ თან! არ გადაუღოთ ფოტო!</span> </div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">📱</span>
        <div class="instruction-content">
          <div class="instruction-title">მობილურის პაროლი</div>
          <div class="instruction-text">დარჩენილი სიტყვები ჩაიწერეთ <span class="highlight-critical">ცალკე ფურცელზე</span> დაზეპირებამდე. ეს ფურცელი შეგიძლიათ თან ატაროთ მის სრულად დაზეპირებამდე</div>
          <div class="instruction-note">ეს პაროლი შეგიძლიათ Bitwarden-შიც შეინახოთ</div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">🔥</span>
        <div class="instruction-content">
          <div class="instruction-title">გაანადგურეთ ფურცლები დაზპირების შემდეგ</div>
          <div class="instruction-text">ფურცელზე ჩაწერა <span class="highlight-critical">დროებითი გამოსავალია</span> პაროლის სრულად დაზეპირებამდე</div>
        </div>
      </div>
    </div>
    <div class="password-item">
      <div class="password-label">Bitwarden-ის პაროლი:</div>
      <div id="bitwarden-password" class="password-value"></div>
      <small>ეს ყველაზე მნიშვნელოვანი პაროლია და მას Bitwarden-ის დასაცავად გამოიყენებთ. იქამდე, სანამ გახსოვთ ეს პაროლი და ყველა დანარჩენი Bitwarden-ში გაქვთ შენახული, არცერთი პაროლი აღარ "დაგავიწყდებათ".</small>
      <small><br/>Bitwarden-ის პაროლის აღდგენა შეუძლებელია!</small>
    </div>
    <div class="password-item">
      <div class="password-label">მობილურის პაროლი:</div>
      <div id="mobile-password" class="password-value"></div>
      <small>ეს პაროლი Cellebrite-სგან დაგიცავთ იმ შემთხვევაში, თუ მოწყობილობას გათიშავთ.<br/>Face ID ან თითის ანაბეჭდთან ერთად, ის იდეალურ დაცვას გთავაზობთ.</small>
    </div>
  </div>

  <div class="password-group other">
    <div class="group-header">
      <span class="header-icon">🔒</span>
      <span class="header-text">დამატებითი პაროლები</span>
    </div>
    <div class="storage-note">
      <div class="warning-banner storage">შეინახეთ მხოლოდ Bitwarden-ში!</div>
      <div class="instruction-step">
        <div class="instruction-icon">🔐</div>
        <div class="instruction-content">
          <div class="instruction-title">შეინახეთ Bitwarden-ში</div>
          <div class="instruction-text">
            ქვემოთ მოცემული პაროლები
          </div>
          <div class="instruction-note">
            ამ პაროლების დაზეპირება აუცილებელი არაა - Bitwarden-ის პაროლის ცოდნა საკმარისია
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
