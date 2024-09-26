---
title: "FOI პაროლების გენერატორი"
hide:
  - navigation
---

# პაროლების გენერატორი

მარტივად დამახსოვრებადი და გამოყენებაზე მორგებული ძლიერი პაროლების გენერატორი.

აირჩიეთ გამოყენება:

<div style="margin-bottom: 5px;">
  <button class="os-button" data-os="ios" onclick="selectOS('ios');">iOS Lock</button>
  <button class="os-button" data-os="android" onclick="selectOS('android');">Android Lock</button>
</div>

<div style="margin-bottom: 5px;">
  <button class="os-button" data-os="macos-easy" onclick="selectOS('macos-easy');">macOS (user)</button>
  <button class="os-button" data-os="macos-hard" onclick="selectOS('macos-hard');">macOS (admin/unlock)</button>
</div>

<div style="margin-bottom: 5px;">
  <button class="os-button" data-os="windows-user-pin" onclick="selectOS('windows-user-pin');">Windows User PIN</button>
  <button class="os-button" data-os="windows-user-password" onclick="selectOS('windows-user-password');">Windows User Password</button>
  <button class="os-button" data-os="windows-bitlocker-os" onclick="selectOS('windows-bitlocker-os');">Windows BitLocker (C:)</button>
  <button class="os-button" data-os="windows-bitlocker-fixed" onclick="selectOS('windows-bitlocker-fixed');">Windows BitLocker (D:)</button>
</div>

<div style="margin-bottom: 20px;">
  <button class="os-button" data-os="bitwarden" onclick="selectOS('bitwarden');">Bitwarden</button>
  <button class="os-button" data-os="generic" onclick="selectOS('generic');">სხვა</button>
</div>

<div>
  <button id="generate-button" style="background-color: #672a7c;" onclick="generatePassphrase()" disabled>გენერირება</button>
</div>

გენერირებული პაროლი:

<div>
  <div id="passphrase" style="font-family: monospace; font-size: 1.23em; border: 1px solid #ccc; padding: 15px; margin-bottom: 10px;"></div>
</div>

<div id="additional-note" style="margin-bottom: 20px;"></div>

<div id="error-message" style="color: red;"></div>

/// details | დამატებითი კონფიგურაცია
    type: info
    open: false
<input type="hidden" id="os-selector" value="ios">

<div>
  <label for="num-words">სიტყვების რაოდენობა</label>
  <input type="number" id="num-words" value="4" min="4" onchange="generatePassphrase()">
</div>

<div>
  <label for="password-length">მაქსიმალური სიგრძე</label>
  <input type="number" id="password-length" placeholder="No limit" min="1" onchange="generatePassphrase()" disabled>
</div>

<div>
  <label for="separator">სიტყვებს შორის გამოტოვება</label>
  <input type="text" id="separator" placeholder="Leave empty for Title Case" onchange="generatePassphrase()" disabled>
</div>
///

<script>

let words = [];
let wordsLoaded = false;
let minWordLength = Infinity;
let maxWordLength = -Infinity;

// OS configurations
const osConfigs = {
  'ios': {
    passwordLength: 20,
    separator: ' ',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 4,
    maxWords: 4,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/ios/">iOS კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ ციფრის და გამოტოვებების (სფეისის) შეყვანა.<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ Face ID. <br>- პაროლი შეინახეთ ფურცელზე და Bitwarden-ში. <br>- დამახსოვრების შემდეგ ფურცელი დაწვით.</p>'
  },
  'android': {
    passwordLength: 16,
    separator: '',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 4,
    maxWords: 4,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/android/">Android კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ ციფრის და ყოველი სიტყვის პირველი ასოს დიდ რეგისტრში შეყვანა.<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ თითის ანაბეჭდი. <br>- პაროლი შეინახეთ ფურცელზე და Bitwarden-ში.<br>- დამახსოვრების შემდეგ ფურცელი დაწვით.</p>'
  },
  'macos-easy': {
    passwordLength: null,
    separator: ' ',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 4,
    maxWords: 4,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/macos/">macOS კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ ციფრის და გამოტოვებების შეყვანა (წერტილი ან სფეისი).<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ Touch ID. <br>- პაროლი შეინახეთ Bitwarden-ში.</p>'
  },
  'macos-hard': {
    passwordLength: null,
    separator: ' ',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 5,
    maxWords: 5,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/macos/">macOS კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ გამოტოვებების შეყვანა (წერტილი ან სფეისი).<br>- პაროლი შეინახეთ Bitwarden-ში.</p>'
  },
  'windows-user-pin': {
    passwordLength: 20,
    separator: ' ',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 4,
    maxWords: 4,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/windows/">Windows კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ ციფრის და გამოტოვებების შეყვანა (წერტილი ან სფეისი).<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ <a href="/solutions/windows/#ბიომეტრიული-აუთენტიფიკაცია">თითის ანაბეჭდი</a> <br>- პაროლი შეინახეთ Bitwarden-ში.</p>'
  },
  'windows-user-password': {
    passwordLength: null,
    separator: '.',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 8,
    maxWords: 8,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/windows/">Windows კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ ციფრის და გამოტოვებების შეყვანა (წერტილი).<br>- ამ პაროლის ხელით შეყვანა არასდროს მოგიწევთ. <br>- პაროლი შეინახეთ Bitwarden-ში.</p>'
  },
  'windows-bitlocker-os': {
    passwordLength: 20,
    separator: ' ',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 4,
    maxWords: 4,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/windows/">Windows კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ ციფრის და გამოტოვებების (სფეისის) შეყვანა.<br>- პაროლი შეინახეთ Bitwarden-ში.</p>'
  },
  'windows-bitlocker-fixed': {
    passwordLength: null,
    separator: '.',
    fixedLength: true,
    separatorDisabled: true,
    passwordLengthDisabled: true,
    minWords: 7,
    maxWords: 7,
    numWordsDisabled: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/windows/">Windows კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ გამოტოვებების (წერტილის) შეყვანა.<br>- პაროლი შეინახეთ Bitwarden-ში.</p>'
  },
  'bitwarden': {
    passwordLength: null,
    separator: ' ',
    fixedLength: false,
    separatorDisabled: false,
    passwordLengthDisabled: true,
    minWords: 5,
    maxWords: 8,
    numWordsDisabled: false,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/passwords/">პაროლების მენეჯერის კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ გამოტოვებების შეყვანა (წერტილი ან სფეისი).<br>- პაროლი შეინახეთ ფურცელზე.<br>- დამახსოვრების შემდეგ ფურცელი დაწვით.</p>'
  },
  'generic': {
    passwordLength: null,
    separator: '.',
    fixedLength: false,
    separatorDisabled: false,
    passwordLengthDisabled: true,
    minWords: 6,
    maxWords: 8,
    numWordsDisabled: false,
    additionalHTML: '<p style="color: #b8860b;">- პაროლი შეინახეთ Bitwarden-ში.</p>'
  }
};

fetch('../short_words.txt')
  .then(response => {
    if (!response.ok) {
      throw new Error('Failed to load words.txt');
    }
    return response.text();
  })
  .then(data => {
    words = data.split('\n').filter(Boolean);
    wordsLoaded = true;
    computeWordLengths();
    document.getElementById('generate-button').disabled = false;
    // Update OS selection based on URL parameter
    initializeOSSelection();
  })
  .catch(error => {
    document.getElementById('error-message').textContent = 'Error: Unable to load word list.';
    console.error('Error fetching words.txt:', error);
  });

function computeWordLengths() {
  for (let word of words) {
    const length = word.length;
    if (length < minWordLength) minWordLength = length;
    if (length > maxWordLength) maxWordLength = length;
  }
}

function getRandomInt(max) {
  const buffer = new Uint32Array(1);
  window.crypto.getRandomValues(buffer);
  const randomFraction = buffer[0] / (0xFFFFFFFF + 1);
  const randomInt = Math.floor(randomFraction * max);
  return randomInt;
}

function getRandomDigit() {
  return getRandomInt(10).toString();
}

function getQueryParams() {
  const params = {};
  window.location.search.substring(1).split('&').forEach(function(pair) {
    const keyValue = pair.split('=');
    params[decodeURIComponent(keyValue[0])] = decodeURIComponent(keyValue[1] || '');
  });
  return params;
}

function initializeOSSelection() {
  const params = getQueryParams();
  let os = 'generic'; // default OS
  if (params.os && osConfigs.hasOwnProperty(params.os)) {
    os = params.os;
  }
  selectOS(os);
}

function updateURLParameter(param, value) {
  let newURL = new URL(window.location.href);
  newURL.searchParams.set(param, value);
  window.history.replaceState({}, '', newURL);
}

function selectOS(os) {
  document.getElementById('os-selector').value = os;
  updateOSButtons(os);
  updateInterface();
  generatePassphrase();
  updateURLParameter('os', os); 
}

function updateOSButtons(selectedOS) {
  const osButtons = document.querySelectorAll('.os-button');
  osButtons.forEach(button => {
    const buttonOS = button.getAttribute('data-os');
    if (buttonOS === selectedOS) {
      button.classList.add('selected-os');
    } else {
      button.classList.remove('selected-os');
    }
  });
}

function updateInterface() {
  const os = document.getElementById('os-selector').value;
  const config = osConfigs[os];
  const passwordLengthInput = document.getElementById('password-length');
  const separatorInput = document.getElementById('separator');
  const numWordsInput = document.getElementById('num-words');

  passwordLengthInput.disabled = config.passwordLengthDisabled;

  if (config.fixedLength) {
    passwordLengthInput.value = config.passwordLength;
  } else {
    passwordLengthInput.value = '';
    passwordLengthInput.placeholder = 'No limit';
  }

  separatorInput.disabled = config.separatorDisabled;
  separatorInput.value = config.separator !== null ? config.separator : '';
  separatorInput.placeholder = config.separatorDisabled ? 'დიდი პირველი ასო' : '';

  numWordsInput.min = config.minWords;
  numWordsInput.max = config.maxWords;
  numWordsInput.value = config.minWords;
  numWordsInput.disabled = config.numWordsDisabled;

  if (config.minWords === config.maxWords) {
    numWordsInput.disabled = true;
  } else {
    numWordsInput.disabled = false;
  }
}

function generatePassphrase() {
  if (!wordsLoaded) {
    document.getElementById('passphrase').innerHTML = '';
    document.getElementById('additional-note').innerHTML = '';
    return;
  }

  const os = document.getElementById('os-selector').value;
  const config = osConfigs[os];

  const numWordsInput = document.getElementById('num-words');
  let numWords = parseInt(numWordsInput.value);

  // Enforce min and max number of words
  if (numWords < config.minWords) {
    numWords = config.minWords;
    numWordsInput.value = config.minWords;
  }
  if (numWords > config.maxWords) {
    numWords = config.maxWords;
    numWordsInput.value = config.maxWords;
  }

  const passwordLengthInput = document.getElementById('password-length');
  let passwordLength = parseInt(passwordLengthInput.value);

  if (config.fixedLength) {
    passwordLength = config.passwordLength;
  } else if (isNaN(passwordLength) || passwordLengthInput.value === '') {
    passwordLength = null; // No limit
  } else if (passwordLength < 1) {
    passwordLength = 1;
    passwordLengthInput.value = 1;
  }

  const separatorInput = document.getElementById('separator');
  let separator = separatorInput.value;
  if (separatorInput.disabled) {
    separator = config.separator;
  }

  const options = {
    numWords: numWords,
    passwordLength: passwordLength,
    separator: separator,
    titleCase: separator == '',
    includeDigit: numWords < 5,
  };

  const passphrase = createPassphrase(options);
  if (passphrase.startsWith('Error:')) {
    document.getElementById('error-message').textContent = passphrase;
    document.getElementById('passphrase').innerHTML = '';
    document.getElementById('additional-note').innerHTML = '';
  } else {
    document.getElementById('error-message').textContent = '';
    const styledPassphrase = stylePassphrase(passphrase);
    document.getElementById('passphrase').innerHTML = styledPassphrase;

    if (config.additionalHTML) {
      document.getElementById('additional-note').innerHTML = config.additionalHTML;
    } else {
      document.getElementById('additional-note').innerHTML = '';
    }
  }
}

function createPassphrase({ numWords, passwordLength, separator, titleCase, includeDigit }) {
  let passphrase = '';
  let passphrasePart = '';
  const digit = includeDigit ? getRandomDigit() : '';
  const digitLength = includeDigit ? 1 : 0;

  function formatWords(wordsArray) {
    return wordsArray.map(word => {
      if (titleCase) {
        return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
      } else {
        return word;
      }
    }).join(separator !== null ? separator : '');
  }

  const separatorLength = separator !== null ? separator.length : 0;
  const minPossibleWordLength = numWords * minWordLength;
  const minPossibleSeparatorLength = separator !== null ? (numWords - 1) * separatorLength : 0;
  const minPossibleLength = minPossibleWordLength + minPossibleSeparatorLength + digitLength;

  let maxPassphraseLength = passwordLength;

  if (passwordLength !== null && minPossibleLength > maxPassphraseLength) {
    return 'Error: Cannot generate passphrase with current settings. Try reducing the number of words or increasing the password length.';
  }

  let found = false;
  let attempts = 0;
  const maxAttempts = 200;

  while (!found && attempts < maxAttempts) {
    attempts++;
    const selectedWords = [];
    for (let i = 0; i < numWords; i++) {
      selectedWords.push(words[getRandomInt(words.length)]);
    }

    passphrasePart = formatWords(selectedWords);

    // Enforce at least one word with 5+ characters for 4-word passphrases
    if (numWords === 4) {
      let hasLengthOver5 = false;
      for (let word of selectedWords) {
        if (word.length >= 5) hasLengthOver5 = true;
      }
      if (!hasLengthOver5) {
        continue;
      }
    }

    const totalLength = passphrasePart.length + digitLength;

    // Check length constraints if applicable
    if (passwordLength === null || totalLength <= maxPassphraseLength) {
      passphrase = digit + passphrasePart;
      found = true;
    }
  }

  if (!found) {
    return 'Error: პაროლის გენერირება მითითებული პარამეტრებით ვერ მოხერხდა. სცადეთ პარამეტრების შეცვლა.';
  }

  return passphrase;
}

function stylePassphrase(passphrase) {
  const styledCharacters = passphrase.split('').map(char => {
    if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
      return `<span style="color: #8b8bb8; font-weight: bold;">${char}</span>`;
    } else if (char.match(/[0-9]/)) {
      return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
    } else {
      return char;
    }
  });
  return styledCharacters.join('');
}

document.getElementById('passphrase').addEventListener('click', function() {
    const selection = window.getSelection();
    const range = document.createRange();
    range.selectNodeContents(this);
    selection.removeAllRanges();
    selection.addRange(range);
  });

</script>

<style>

button {
  cursor: pointer;
  padding: 10px 20px;
  margin: 5px;
  font-size: 1em;
  border: 2px solid transparent;
  background-color: #1e1e1e;
  color: #fff;
  transition: background-color 0.3s, border-color 0.3s;
}

#passphrase {
  cursor: pointer;
}

.os-button:hover {
  background-color: #2a2a2a;
}

.os-button.selected-os {
  border-color: #ffd700; /* Gold color */
  background-color: #2a2a2a;
}

</style>
