---
title: iOS Security Policy
icon: material/apple-ios
---

# iOS Security Policy

*Last updated: December 5, 2024*

## Prerequisites

- [x] [Password Manager](../solutions/passwords.md)
    - To store a unique, strong password for the phone that is also easy
      to enter.

## Installing the Policy

### Preparation

The security policy also regulates password strength, and if your password is simple,
you will not be able to install it. Therefore, changing the password before profile installation is necessary.

For the new password, we will use 4 short words randomly selected by a computer, making it practically impossible to crack,
while you will only need to enter it once every 72 hours.

{% include-markdown "../../includes/mobile_biometrics.en.md" %}

#### Creating a new password

1. Generate a new mobile password with the FOI Password Generator

    /// admonition | Tip
        type: tip

    Press the generate button until you get a password whose last word you can easily memorize.
        
    ///

    [:material-key: FOI Password Generator](../tools/password-generator/index.md){ .md-button .md-button--primary }

2. Use a space as a separator between words in the password
3. Memorizing the password:
    - Write the first three words on paper
    - Memorize the last word
    - After memorizing all four words, destroy the paper
4. Saving the password in **Bitwarden**:
    - Create a new entry, give it a name (e.g., **My iPhone 15 Password**)
    - Enter the full password in the Password field
    - Click the :material-content-save: Save button


#### Changing the password

1. Open ![Apple Settings](../assets/img/icons/apple/settings.svg){ .twemoji } **Settings**
2. Go to **Face ID & Passcode**
3. Select **Change Passcode**
4. Enter the existing password
5. Select **Passcode Options** > **Custom Alphanumeric Code**
6. Enter the new password. Enter a space between words

{% include-markdown "../../includes/password_paper_storage.en.md" %}


### Installing the Profile


[:material-shield-lock: Download FOI Security Policy](files/apple/foi_security_policy_ios.mobileconfig){ .md-button .md-button--primary }

1. Open the ![iOS Files](../assets/img/logo/ios-files.svg){ .twemoji } **Files** app > **Downloads** > open the downloaded file: **foi_security_policy_ios.mobileconfig**
2. Open ![Apple Settings](../assets/img/icons/apple/settings.svg){ .twemoji } **Settings** > ![Apple General](../assets/img/icons/apple/general.svg){ .twemoji } **General** > **VPN & Device Management**
3. Select **FOI Security Policy** > click **Install**


### Unlocking Apple Watch

After profile installation, Apple Watch can only be unlocked via iPhone.

For this, open the **Apple Watch** app on iPhone > **My Watch** > enable **Unlock with iPhone**.

Apple Watch will automatically unlock if the phone is connected and unlocked.

The watch will remain unlocked until removed from the wrist.


## Applied settings

FOI Security Policy includes the following configuration and will be automatically activated.

You can also view the applied settings using 
[iMazing Profile Editor](https://apps.apple.com/us/app/imazing-profile-editor/id1487860882?mt=12){:target="_blank"}

### DNSSettings | DNS Settings

Will install two Encrypted DNS servers on the phone. You can choose them on the [DNS](../solutions/dns.md)
page according to the instructions.

### Password

#### allowSimple | Allow simple passcode

- [x] Enabled

Explanation: Since we use words in passwords, where repeating characters are normal,
e.g., cherry, this restriction is not necessary.

#### forcePIN | Require passcode on device

- [x] Enabled

Explanation: Enabled to increase security so that using the device without setting
a password is impossible.

#### maxFailedAttempts | Maximum failed attempts

- [x] 11 attempts

Explanation: Enabled to increase security so that after 11 incorrect password attempts,
the data on the device is erased.

#### Minimum passcode length

- [x] 15 characters

Explanation: Minimum length is set to increase security. 15 characters is the minimum possible
number of characters when using 4 syllables (4x3-character syllable + 3 dots, spaces, or other separators)

#### pinHistory | Passcode history

- [x] 2

Explanation: On iOS, the old password can be used for 72 hours. Enabling the restriction 
that the new password must not be in the list of the last two passwords disables this function, for greater security.

#### requireAlphanumeric | Require alphanumeric value

- [ ] Disabled

Explanation: Despite the fact that passwords cannot use only digits, this setting is disabled
because when enabled, users would be required to use digits along with words or syllables,
which is unnecessary and makes password entry more difficult.


### Restrictions

### allowApplePersonalizedAdvertising | Allow Apple Personalized Advertising

- [ ] Disabled

Explanation: Disabled to increase privacy by reducing the risk of transmitting personal 
data to Apple.

### allowAutoUnlock | Allow Apple Watch to auto unlock device

- [ ] Disabled

Explanation: Disabled to increase security so that unlocking the phone with Apple Watch
is impossible.

#### allowCloudKeychainSync | Allow iCloud Keychain Sync

- [ ] Disabled

Explanation: Disabled to increase security by restricting access to sensitive data stored 
on the device — passwords and other keys — from unauthorized access.

#### allowDiagnosticSubmission | Allow submitting diagnostic and usage data to Apple

- [ ] Disabled

Explanation: Disabled to increase security by reducing the risk of transmitting 
personal and sensitive data to Apple.

#### allowPasswordSharing | Allow password sharing

- [ ] Disabled

Explanation: Disabled to increase security to prevent unauthorized 
password sharing.

