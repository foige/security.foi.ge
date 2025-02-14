let words = [];
let wordsLoaded = false;
let minWordLength = Infinity;
let maxWordLength = -Infinity;
let sharedWord = '';

const osConfigs = {
  'ios': {
    type: 'passphrase',
    numWords: 4,
    separator: ' ',
    maxLength: 20,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/ios/">iOS კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ მაღალი ასოს და გამოტოვებების (სფეისის) შეყვანა.<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ Face ID.</p>'
  },
  'android': {
    type: 'passphrase',
    numWords: 4,
    separator: '',
    maxLength: 16,
    titleCase: true,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/android/">Android კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ მაღალი ასოს და ყოველი სიტყვის პირველი ასოს დიდ რეგისტრში შეყვანა.<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ თითის ანაბეჭდი.</p>'
  },
  'macos': {
    user: {
      type: 'passphrase',
      numWords: 4,
      separator: ' ',
      additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/macos/">macOS კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ მაღალი ასოს და გამოტოვებების შეყვანა.<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ Touch ID.</p>'
    },
    admin: {
      type: 'passphrase',
      numWords: 5,
      separator: ' ',
      additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/macos/">macOS კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ გამოტოვებების შეყვანა.</p>'
    }
  },
  'windows': {
    pin: {
      type: 'passphrase',
      numWords: 4,
      separator: ' ',
      additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/windows/">Windows კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ მაღალი ასოს და გამოტოვებების შეყვანა.<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ <a href="/solutions/windows/#ბიომეტრიული-აუთენტიფიკაცია">თითის ანაბეჭდი</a></p>'
    },
    user: {
      type: 'password',
      maxLength: 15,
      additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/windows/">Windows კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ მაღალი ასოს და გამოტოვებების შეყვანა.<br>- ამ პაროლის ხელით შეყვანა არასდროს მოგიწევთ.</p>'
    },
    bitlocker: {
      type: 'passphrase',
      numWords: 5,
      separator: ' ',
      additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/windows/">Windows კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ მაღალი ასოს და გამოტოვებების შეყვანა.</p>'
    }
  },
  'bitwarden': {
    type: 'passphrase',
    numWords: 5,
    separator: ' ',
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/passwords/">პაროლების მენეჯერის კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ გამოტოვებების შეყვანა.<br>- ბოლო სიტყვა დაიმახსოვრეთ და არ ჩაიწეროთ!</p>'
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
  return Math.floor(buffer[0] / (0xFFFFFFFF + 1) * max);
}

function generateRandomWord() {
  return words[getRandomInt(words.length)];
}

function generateRandomLetterPassword(maxLength) {
  const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let password = '';
  for (let i = 0; i < maxLength; i++) {
    password += charset[getRandomInt(charset.length)];
  }
  return password;
}

function generatePassphrase(config, useSharedWord = false) {
  if (config.type === 'password') {
    return generateRandomLetterPassword(config.maxLength);
  }

  let found = false;
  let attempts = 0;
  const maxAttempts = 1000;
  let result = '';

  while (!found && attempts < maxAttempts) {
    attempts++;
    const selectedWords = [];
    for (let i = 0; i < config.numWords - (useSharedWord ? 1 : 0); i++) {
      selectedWords.push(generateRandomWord());
    }

    if (useSharedWord) {
      selectedWords.push(sharedWord);
    }

    if (config.titleCase) {
      result = selectedWords.map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(config.separator);
    } else {
      if (useSharedWord) {
        const lastIndex = selectedWords.length - 1;
        selectedWords[lastIndex] = selectedWords[lastIndex].charAt(0).toUpperCase() + selectedWords[lastIndex].slice(1);
      } else if (config.numWords < 5) {
        const randomIndex = getRandomInt(selectedWords.length);
        selectedWords[randomIndex] = selectedWords[randomIndex].charAt(0).toUpperCase() + selectedWords[randomIndex].slice(1);
      }
      result = selectedWords.join(config.separator);
    }

    if (!config.maxLength || result.length <= config.maxLength) {
      found = true;
    }
  }

  if (!found) {
    return 'Error: პაროლის გენერირება მითითებული პარამეტრებით ვერ მოხერხდა. სცადეთ პარამეტრების შეცვლა.';
  }

  return result;
}

function stylePassphrase(passphrase, isSharedWord = false) {
  if (!passphrase.includes(' ')) {
    // For passwords without spaces (Android)
    const chars = passphrase.split('');
    const upperIndices = chars.reduce((acc, char, i) => {
      if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
        acc.push(i);
      }
      return acc;
    }, []);

    if (isSharedWord && upperIndices.length > 0) {
      const lastUpperIndex = upperIndices[upperIndices.length - 1];
      const firstPart = chars.slice(0, lastUpperIndex);
      const lastPart = chars.slice(lastUpperIndex);

      const styledFirst = firstPart.map(char => {
        if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
          return `<span style="color: #ffd700; font-weight: bold;">${char}</span>`;
        } else if (char.match(/[0-9]/)) {
          return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
        }
        return char;
      }).join('');

      const styledLast = lastPart.map(char => {
        if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
          return `<span style="color: #ffd700; font-weight: bold;">${char}</span>`;
        } else if (char.match(/[0-9]/)) {
          return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
        }
        return char;
      }).join('');

      return `${styledFirst}<span class="memory-container"><span class="memory-word">${styledLast}</span><span class="memory-indicator">🧠</span></span>`;
    }

    // Style all characters if not a shared word or no uppercase found
    return chars.map(char => {
      if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
        return `<span style="color: #ffd700; font-weight: bold;">${char}</span>`;
      } else if (char.match(/[0-9]/)) {
        return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
      }
      return char;
    }).join('');
  }

  const words = passphrase.split(' ');
  const styledWords = words.map((word, index) => {
    const styledChars = word.split('').map(char => {
      if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
        return `<span style="color: #ffd700; font-weight: bold;">${char}</span>`;
      } else if (char.match(/[0-9]/)) {
        return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
      }
      return char;
    }).join('');

    if (isSharedWord && index === words.length - 1) {
      return `<span class="memory-container"><span class="memory-word">${styledChars}</span><span class="memory-indicator">🧠</span></span>`;
    }
    return styledChars;
  });

  return styledWords.join(' ');
}

// Function to reset the page state
function resetPasswordContainer() {
  document.getElementById('passwords-container').style.display = 'none';
  document.getElementById('error-message').textContent = '';
  document.getElementById('additional-note').innerHTML = '';
}

// Add event listeners to OS selection radio buttons
document.querySelectorAll('input[name="mobile-os"], input[name="desktop-os"]').forEach(radio => {
  radio.addEventListener('change', resetPasswordContainer);
});

function generatePasswords() {
  if (!wordsLoaded) {
    document.getElementById('error-message').textContent = 'სიტყვების ჩატვირთვას ველოდებით...';
    return;
  }

  document.getElementById('passwords-container').style.display = 'block';
  document.getElementById('error-message').textContent = '';

  sharedWord = generateRandomWord();

  const mobileOS = document.querySelector('input[name="mobile-os"]:checked').value;
  const desktopOS = document.querySelector('input[name="desktop-os"]:checked').value;

  const bitwardenPass = generatePassphrase(osConfigs.bitwarden, true);
  const mobilePass = generatePassphrase(osConfigs[mobileOS], true);

  // Add overlay and event listeners to prevent copying
  function addCopyProtection(element) {
    // Create overlay
    const overlay = document.createElement('div');
    overlay.style.position = 'absolute';
    overlay.style.top = '0';
    overlay.style.left = '0';
    overlay.style.width = '100%';
    overlay.style.height = '100%';
    overlay.style.zIndex = '10';
    element.style.position = 'relative';
    element.appendChild(overlay);
    
    // Prevent copy events
    element.addEventListener('copy', e => e.preventDefault());
    element.addEventListener('cut', e => e.preventDefault());
    element.addEventListener('paste', e => e.preventDefault());
    element.addEventListener('selectstart', e => e.preventDefault());
  }
  
  const bitwardenElement = document.getElementById('bitwarden-password');
  const mobileElement = document.getElementById('mobile-password');
  
  bitwardenElement.innerHTML = stylePassphrase(bitwardenPass, true);
  mobileElement.innerHTML = stylePassphrase(mobilePass, true);
  
  // Add protection to critical passwords
  addCopyProtection(bitwardenElement);
  addCopyProtection(mobileElement);

  const desktopPasswords = document.getElementById('desktop-passwords');
  desktopPasswords.innerHTML = '';

  if (desktopOS === 'macos') {
    const userPass = generatePassphrase(osConfigs.macos.user);
    const adminPass = generatePassphrase(osConfigs.macos.admin);

    desktopPasswords.innerHTML = `
      <div class="password-item">
        <div class="password-label">macOS User:</div>
        <div class="password-value">${stylePassphrase(userPass)}</div>
      </div>
      <div class="password-item">
        <div class="password-label">macOS Admin/Unlock:</div>
        <div class="password-value">${stylePassphrase(adminPass)}</div>
      </div>
    `;
  } else {
    const bitlockerPass = generatePassphrase(osConfigs.windows.bitlocker);
    const userPin = generatePassphrase(osConfigs.windows.pin);
    const userPass = generatePassphrase(osConfigs.windows.user);

    desktopPasswords.innerHTML = `
      <div class="password-item">
        <div class="password-label">Windows BitLocker - შიფრაციის პაროლი:</div>
        <div class="password-value">${stylePassphrase(bitlockerPass)}</div>
      </div>
      <div class="password-item">
        <div class="password-label">Windows User PIN - მომხმარებლის მთავარი პაროლი:</div>
        <div class="password-value">${stylePassphrase(userPin)}</div>
      </div>
      <div class="password-item">
        <div class="password-label">Windows User Password - მომხმარებლის სარეზერვო პაროლი:</div>
        <div class="password-value">${stylePassphrase(userPass)}</div>
      </div>
    `;
  }

  const additionalNote = document.getElementById('additional-note');
  additionalNote.innerHTML = `
    <div class="os-instructions">
      ${osConfigs[mobileOS].additionalHTML || ''}
      ${desktopOS === 'macos' ? osConfigs.macos.user.additionalHTML : osConfigs.windows.pin.additionalHTML}
    </div>
  `;
}