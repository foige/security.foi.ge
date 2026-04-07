---
title: macOS Security Policy
icon: material/apple
---

# macOS Security Policy

*Last updated: December 5, 2024*

## Prerequisites

- [x] [Password Manager](../solutions/passwords.md)
    - To store unique, strong passwords for the device that are also easy
      to enter.

## Installing the Policy

Download and open the file:

[:material-shield-lock: Download FOI Security Policy](files/apple/foi_security_policy_macos.mobileconfig){ .md-button .md-button--primary }

   
   /// tab | macOS 15
   
   ![Apple Settings](../assets/img/icons/apple/settings.svg){ .twemoji } **System Settings** >
   ![Apple General](../assets/img/icons/apple/general.svg){ .twemoji } **General** > **Device Management**.
   
   ///

   /// tab | macOS 14
   ![Apple Settings](../assets/img/icons/apple/settings.svg){ .twemoji } **System Settings** > 
   ![Apple Privacy](../assets/img/icons/apple/privacy.svg){ .twemoji } **Privacy & Security** > **Profiles**.
   
   ///

- In the **Downloaded** section, find **FOI Security Policy** and double-click it.
- In the opened window, click **Install**.
- Go to network settings ![Apple Settings](../assets/img/icons/apple/settings.svg){ .twemoji } **System Settings** > 
    **Network** > **VPN & Filters** > **Filters & Proxies**
- In the **Filters & Proxies** list, check **Enabled** next to **Cloudflare DoH**

You can view or change the applied settings using 
[iMazing Profile Editor](https://apps.apple.com/us/app/imazing-profile-editor/id1487860882?mt=12){:target="_blank"}

## Applied settings

FOI Security Policy includes the following configuration and will be automatically activated for all users:

### Restrictions

#### USB Restricted Mode

- [x] Enabled

Explanation: Enabled to increase security by restricting unauthorized USB device access.

#### Allow Submitting diagnostic and usage data to apple

- [ ] Disabled

Explanation: Disabled to protect user privacy.

#### Allow Apple-personalized advertising

- [ ] Disabled

Explanation: Disabled to protect user privacy and restrict advertising.

#### Allow Apple Watch to auto unlock device

- [ ] Disabled

Explanation: Disabled to increase security and prevent unauthorized access.

#### Allow proximity based password sharing requests

- [ ] Disabled

Explanation: Disabled to increase security and prevent unauthorized password sharing.

#### Allow password sharing

- [ ] Disabled

Explanation: Disabled to increase security and prevent unauthorized password sharing.

#### Enforced Fingerprint Timeout

Time after which Touch ID will be disabled and the system will require a one-time password entry.

- [x] 28800 seconds (8 hours)

Explanation: Enabled to increase security by periodically requiring password authentication.

### iCloud

#### Allow iCloud Keychain sync

- [ ] Disabled

Explanation: Disabled to increase security by restricting access to sensitive data stored on the device 
 — passwords and other keys — from unauthorized access.

### Password

#### allowSimple | Allow simple passcode

- [x] Enabled

Explanation: Since we use words in passwords, where repeating characters are normal,
e.g., cherry, this restriction is not necessary.

#### Require passcode on device

- [x] Enabled

Explanation: Enabled to increase security so that only authorized users have access to the device.

#### requireAlphanumeric | Require alphanumeric value

- [ ] Disabled

Explanation: Despite the fact that passwords cannot use only digits, this setting is disabled
because when enabled, users would be required to use digits along with words or syllables,
which is unnecessary and makes password entry more difficult.


#### Minimum passcode length

- [x] 15 characters

Explanation: Minimum length is set to increase security. 15 characters is the minimum possible
number of characters when using 4 syllables (4x3-character syllable + 3 dots, spaces, or other separators)

#### Maximum number of failed attempts

- [x] 10 attempts

Explanation: Failed password entry attempts are limited to increase security.

#### Delay after failed login attempts

- [x] 2 minutes

Explanation: A delay is set after incorrect password entry to reduce the risk of Brute-force attacks.

### Siri

#### Improve Siri & Dictation

- [ ] Disabled

Explanation: Disabled to protect user privacy.

### DNS Settings

#### Protocol

- [x] DNS over HTTPS

Explanation: Enabled to increase security and privacy so that DNS queries are encrypted.

The servers specified on the following page will be set automatically: [DNS](../solutions/dns.md)

### Energy Saver

#### Prevent Storing Temporary FileVault key for Standby

- [x] Enabled

Explanation: Enabled to increase security by preventing temporary decryption key storage.

### Firewall

#### Enable Firewall

- [x] Enabled

Explanation: Enabled to increase security by protecting the system from unauthorized access.

### Login Window

#### Disable automatic login if FileVault is disabled

- [x] Enabled

Explanation: Enabled to increase security and prevent unauthorized access.

#### Disable automatic login if FileVault is enabled

- [x] Enabled

Explanation: Enabled to increase security and prevent unauthorized access.

#### Enable external accounts

- [ ] Disabled

Explanation: Disabled to increase security by restricting external account usage.

#### Reopen windows when logging back in

- [ ] Disabled

Explanation: Disabled to increase security and prevent accidental exposure of sensitive information.

#### Show password hints after failed attempts

- [ ] 0 / Disabled

Explanation: Disabled to increase security by reducing the risk of password guessing.

### Screensaver

#### Require password to unlock screen.

- [x] Enabled

Explanation: Enabled to increase security and prevent unauthorized access.

#### Require password delay

- [x] 0 - immediately

Explanation: Set to minimum value to increase security.

### Security

#### Automatically Reenable Gatekeeper

- [x] Enabled

Explanation: Enabled to increase security by protecting the system from malware.

### Setup Assistant

#### macOS Skip iCloud

- [x] Enabled

Explanation: iCloud can be configured from system settings.

#### macOS Skip Siri

- [x] Enabled

Explanation: Enabled to increase security and privacy.

#### macOS Skip Screen Time Sharing

- [x] Enabled

Explanation: Enabled to increase security and privacy.

### Software Update

#### Automatically check for updates

- [x] Enabled

Explanation: Enabled to increase security so that the system is always up to date.

#### Download newly available updates in the background

- [x] Enabled

Explanation: Enabled to increase security so that updates are installed quickly.

#### Automatically install macOS updates

- [x] Enabled

Explanation: Enabled to increase security so that the system is always up to date.

#### Automatically install App Store app updates

- [x] Enabled

Explanation: Enabled to increase security so that applications are always up to date.

#### Install XProtect, MRT & Gatekeeper updates automatically

- [x] Enabled

Explanation: Enabled to increase security so that system protection mechanisms are always up to date.

#### Install security updates automatically

- [x] Enabled

Explanation: Enabled to increase security so that the system is always protected from new threats.

#### Brave/Firefox/Chrome/Safari

[Browser Security Policy](browser.md)