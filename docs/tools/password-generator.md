---
title: "FOI პაროლების გენერატორი"
hide:
  - navigation
---
<link rel="stylesheet" href="../../assets/stylesheets/password-generator.css?v=2025-02-20">

# პაროლების გენერატორი

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
          <div class="instruction-title">დაიმახსოვრეთ ხაზგასმული სიტყვა მაშინვე</div>
          <div class="instruction-text">არ ჩაწეროთ ის ფურცელზე</div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">✍️</span>
        <div class="instruction-content">
          <div class="instruction-title">Bitwarden-ის პაროლი</div>
          <div class="instruction-text">დარჩენილი სიტყვები ჩაიწერეთ <span class="highlight-critical">ცალკე ფურცელზე</span>, შეინახეთ უსაფრთხო ადგილას დამახსოვრებამდე. <span class="highlight-critical">არ ატაროთ თან!</span> </div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">📱</span>
        <div class="instruction-content">
          <div class="instruction-title">მობილურის პაროლი</div>
          <div class="instruction-text">დარჩენილი სიტყვები ჩაიწერეთ <span class="highlight-critical">ცალკე ფურცელზე</span> დამახსოვრებამდე. ეს ფურცელი შეგიძლიათ თან ატაროთ მის სრულად დამახსოვრებამდე</div>
          <div class="instruction-note">ეს პაროლი შეგიძლიათ Bitwarden-შიც შეინახოთ</div>
        </div>
      </div>
      <div class="instruction-step">
        <span class="instruction-icon">🔥</span>
        <div class="instruction-content">
          <div class="instruction-title">გაანადგურეთ ფურცლები დამახსოვრების შემდეგ</div>
        </div>
      </div>
    </div>
    <div class="password-item">
      <div class="password-label">Bitwarden-ის პაროლი:</div>
      <div id="bitwarden-password" class="password-value"></div>
    </div>
    <div class="password-item">
      <div class="password-label">მობილურის პაროლი:</div>
      <div id="mobile-password" class="password-value"></div>
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
            ამ პაროლების დამახსოვრება საჭირო არაა - Bitwarden-ის პაროლის ცოდნა საკმარისია
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
  'password-generator.js': '4b168075646545971f0e1a91c82f6607dd072578d6c026bdd6f5efe5617822fc',
  'foi_words_en.txt': 'b294dd133291abeb153593f4c44ea3583473d29dda0284699a1a9887967cff68',
  'foi_words_ka.txt': '8a0eb56e7df296b9860d074608a692bda46928560283ab57821446c201e0066f',
  'foi_syllables_en.txt': '98f25a9e8a0584b69d325214ce6d03c2f761278f0efdeb2f0cc146d6c3dbd601',
  'foi_syllables_ka.txt': 'ac3413cd96dce202cb9126db5523346f2c23e78adf0b2c5e757f768915ec2fe6',
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
    const response = await fetch('../../assets/javascripts/password-generator.js?v=2025-02-20');
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
