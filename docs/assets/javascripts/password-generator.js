let wordsEn = [];
let wordsKa = [];
let syllablesEn = [];
let syllablesKa = [];
let words = []; // Current active word list
let syllables = []; // Current active syllables list
let wordsLoaded = { en: false, ka: false };
let syllablesLoaded = { en: false, ka: false };
let minWordLength = Infinity;
let maxWordLength = -Infinity;
let sharedWord = '';

// Load English resources
Promise.all([
  fetch('../foi_words_en.txt')
    .then(response => {
      if (!response.ok) throw new Error('Failed to load English words');
      return response.text();
    })
    .then(async content => {
      await verifyIntegrity('foi_words_en.txt', content);
      return content;
    }),
  fetch('../foi_syllables_en.txt')
    .then(response => {
      if (!response.ok) throw new Error('Failed to load English syllables');
      return response.text();
    })
    .then(async content => {
      await verifyIntegrity('foi_syllables_en.txt', content);
      return content;
    })
])
.then(([wordsData, syllablesData]) => {
  wordsEn = wordsData.split('\n').filter(Boolean);
  syllablesEn = syllablesData.split('\n').filter(Boolean);
  wordsLoaded.en = true;
  syllablesLoaded.en = true;
  checkWordsLoaded();
})
.catch(error => {
  document.getElementById('error-message').textContent = 'Error: Unable to load English resources. ' + error.message;
  console.error('Error fetching English resources:', error);
  document.getElementById('generate-button').disabled = true;
});

// Load Georgian resources
Promise.all([
  fetch('../foi_words_ka.txt')
    .then(response => {
      if (!response.ok) throw new Error('Failed to load Georgian words');
      return response.text();
    })
    .then(async content => {
      await verifyIntegrity('foi_words_ka.txt', content);
      return content;
    }),
  fetch('../foi_syllables_ka.txt')
    .then(response => {
      if (!response.ok) throw new Error('Failed to load Georgian syllables');
      return response.text();
    })
    .then(async content => {
      await verifyIntegrity('foi_syllables_ka.txt', content);
      return content;
    })
])
.then(([wordsData, syllablesData]) => {
  wordsKa = wordsData.split('\n').filter(Boolean);
  syllablesKa = syllablesData.split('\n').filter(Boolean);
  wordsLoaded.ka = true;
  syllablesLoaded.ka = true;
  checkWordsLoaded();
})
.catch(error => {
  document.getElementById('error-message').textContent = 'Error: Unable to load Georgian resources. ' + error.message;
  console.error('Error fetching Georgian resources:', error);
  document.getElementById('generate-button').disabled = true;
});

function checkWordsLoaded() {
  if (wordsLoaded.en && wordsLoaded.ka && syllablesLoaded.en && syllablesLoaded.ka) {
    // Set initial word list based on default language selection
    const selectedLanguage = document.querySelector('input[name="password-language"]:checked').value;
    updateWordList(selectedLanguage);
    document.getElementById('generate-button').disabled = false;
  }
}

function updateWordList(language) {
  switch (language) {
    case 'en':
      words = wordsEn;
      syllables = syllablesEn;
      break;
    case 'ka':
      words = wordsKa;
      syllables = syllablesKa;
      break;
    case 'combined':
      words = [...wordsEn, ...wordsKa];
      syllables = [...syllablesEn, ...syllablesKa];
      break;
  }
  computeWordLengths();
}

// Add event listener for language selection
document.querySelectorAll('input[name="password-language"]').forEach(radio => {
  radio.addEventListener('change', (e) => {
    updateWordList(e.target.value);
    resetPasswordContainer();
  });
});

const osConfigs = {
  'ios': {
    type: 'passphrase',
    numWords: 4,
    separator: ' ',
    maxLength: 25,
    additionalHTML: '<p style="color: #b8860b;">- გაეცანით <a href="/solutions/ios/">iOS კონფიგურაციის გვერდს.</a><br>- არ დაგავიწყდეთ მაღალი ასოს და გამოტოვებების (სფეისის) შეყვანა.<br>- კომფორტის შესანარჩუნებლად გამოიყენეთ Face ID.</p>'
  },
  'android': {
    type: 'passphrase',
    numWords: 4,
    separator: '',
    maxLength: 16,
    titleCase: true,
    useSyllables: true, // Use syllables for non-shared words
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

function generateRandomWord(useSyllables = false) {
  if (useSyllables) {
    let result = '';
    for (let i = 0; i < 1; i++) {
      result += syllables[getRandomInt(syllables.length)];
    }
    return result;
  }
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
      selectedWords.push(generateRandomWord(config.useSyllables));
    }

    if (useSharedWord) {
      // Always use a regular word for the shared word, not syllables
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

function stylePassphrase(passphrase, isSharedWord = false, isCritical = false) {
  if (!passphrase.includes(' ')) {
    // For passwords without spaces (Android)
    const chars = passphrase.split('');
    
    if (isSharedWord) {
      // Find the last word by looking for the pattern: uppercase followed by lowercase
      const matches = passphrase.match(/[A-Z][a-z]+/g);
      if (matches) {
        const lastWord = matches[matches.length - 1];
        const lastWordIndex = passphrase.lastIndexOf(lastWord);
        
        const firstPart = passphrase.substring(0, lastWordIndex);
        const lastPart = passphrase.substring(lastWordIndex);

        const styledFirst = firstPart.split('').map(char => {
          if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
            return `<span style="color: #ffd700; font-weight: bold;">${char}</span>`;
          } else if (char.match(/[0-9]/)) {
            return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
          }
          return char;
        }).join('');

        const styledLast = lastPart.split('').map(char => {
          if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
            return `<span style="color: #ffd700; font-weight: bold;">${char}</span>`;
          } else if (char.match(/[0-9]/)) {
            return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
          }
          return char;
        }).join('');

        const memoryPart = `<span class="memory-container"><span class="memory-word">${styledLast}</span><span class="memory-indicator">🧠</span></span>`;
        if (isCritical) {
          return `<span class="write-container"><span class="write-indicator">✍️</span>${styledFirst}</span>${memoryPart}`;
        }
        return `${styledFirst}${memoryPart}`;
      }
    }

    // Style all characters if not a shared word
    const styledText = chars.map(char => {
      if (char === char.toUpperCase() && char.match(/[A-Z]/)) {
        return `<span style="color: #ffd700; font-weight: bold;">${char}</span>`;
      } else if (char.match(/[0-9]/)) {
        return `<span style="color: #b8860b; font-weight: bold;">${char}</span>`;
      }
      return char;
    }).join('');
    
    if (isCritical) {
      return `<span class="write-container"><span class="write-indicator">✍️</span>${styledText}</span>`;
    }
    return styledText;
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

  const joinedWords = styledWords.join(' ');
  if (isCritical) {
    const lastSpaceIndex = joinedWords.lastIndexOf('<span class="memory-container">');
    const beforeMemory = joinedWords.substring(0, lastSpaceIndex);
    const afterMemory = joinedWords.substring(lastSpaceIndex);
    return `<span class="write-container"><span class="write-indicator">✍️</span>${beforeMemory}</span>${afterMemory}`;
  }
  return joinedWords;
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
  if (!wordsLoaded.en || !wordsLoaded.ka || !syllablesLoaded.en || !syllablesLoaded.ka) {
    document.getElementById('error-message').textContent = 'ველოდებით რესურსების ჩატვირთვას...';
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
  
  bitwardenElement.innerHTML = stylePassphrase(bitwardenPass, true, true);
  mobileElement.innerHTML = stylePassphrase(mobilePass, true, true);
  
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