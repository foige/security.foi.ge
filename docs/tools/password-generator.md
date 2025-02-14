---
title: "FOI პაროლების გენერატორი"
hide:
  - navigation
---

<link rel="stylesheet" href="../../assets/stylesheets/password-generator.css?v=2025-02-15">

# პაროლების გენერატორი

მარტივად დამახსოვრებადი და გამოყენებაზე მორგებული ძლიერი პაროლების გენერატორი.

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

<script src="../../assets/javascripts/password-generator.js?v=2025-02-15"></script>
