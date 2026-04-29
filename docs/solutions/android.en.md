---
title: Android
icon: material/android
---

# Android

## Prerequisites

- [x] Install a [Password Manager](passwords.md)
    - To store a unique, strong password for the phone that is also easy to enter.

{% include-markdown "../../includes/device_has_updates.en.md"%}

## Recommended devices

Security features supported by Android devices are fragmented. As a result,
not all devices can provide equal security, and it may be possible to extract data without
the user's password.

Therefore, it is recommended to use only devices that meet all security parameters supported
by Android. One such feature is [StrongBox](https://source.android.com/docs/security/best-practices/hardware){:target="_blank"},
which means the device has an additional Security Chip (TPM) that protects user information and is resistant
to unauthorized data extraction.

An incomplete list of Android smartphones that have such a Security Chip (TPM)
can be found at [this link](https://www.android-device-security.org/database/?realMeasurementsOnly=true&preDefinedScore=defaultSecurity&securityScoreCalculationApproach=true&securityScoreLabel-API%20Level=High&securityScoreLabel-Patchlevel=High&securityScoreLabel-Fingerprint=High&securityScoreLabel-Keymaster%20Version=Moderate&securityScoreLabel-Key%20Attestation%20Unique%20ID=High&securityScoreLabel-Keystore%20Export=High&securityScoreLabel-Keystore%20Import=Low&securityScoreLabel-OpenApi%20eSE=Low&securityScoreLabel-Embedded%20SIM%20(eSIM)=Low&securityScoreLabel-Strongbox=High&securityScoreLabel-A%2FB%20System%20Updates=High&securityScoreLabel-Identity%20Credential=High&securityScoreLabel-Protected%20Confirmation=High&securityScoreLabel-Trusted%20Execution%20Environment=High&securityScoreLabel-Encrypted%20Shared%20Preferences=High&securityScoreLabel-Android%20Virtualization%20Framework=Moderate&securityScoreLabel-Multiple%20User%20Support=High&show=Strongbox&page=1&rows=50&Strongbox=True&securityScoreSelectedCols=Fingerprint;Keymaster%20Version;Keystore%20Export;Keystore%20Import;Strongbox;A%2FB%20System%20Updates;Identity%20Credential;Protected%20Confirmation;Trusted%20Execution%20Environment;Encrypted%20Shared%20Preferences;Android%20Virtualization%20Framework;Multiple%20User%20Support;OpenApi%20eSE;Embedded%20SIM%20(eSIM)&securityScoreWeight-Release%20Date=10&securityScoreWeight-Fingerprint=43&securityScoreWeight-Keymaster%20Version=55&securityScoreWeight-Keystore%20Export=55&securityScoreWeight-Keystore%20Import=55&securityScoreWeight-OpenApi%20eSE=66&securityScoreWeight-Embedded%20SIM%20(eSIM)=61&securityScoreWeight-Strongbox=66&securityScoreWeight-A%2FB%20System%20Updates=20&securityScoreWeight-Identity%20Credential=74&securityScoreWeight-Protected%20Confirmation=76&securityScoreWeight-Trusted%20Execution%20Environment=66&securityScoreWeight-Encrypted%20Shared%20Preferences=65&securityScoreWeight-Android%20Virtualization%20Framework=50&securityScoreWeight-Multiple%20User%20Support=65&selectedDeviceModel=1&minThreshold-api_level=31&minThreshold-releasedate=2021-8-14&minThreshold-patchlevel=2024-05-01&minThreshold-Keymaster%20Version=4&minThreshold-OpenApi%20eSE=1&negateBooleans=Key%20Attestation%20Unique%20ID;Keystore%20Export;Rooted){:target="_blank"}

/// admonition | Google Pixel
    type: success

Among Android smartphones, **Google Pixel** is, generally, the most secure,
because they follow all recommendations proposed by Android.


Other manufacturers are not required to follow these recommendations.

Pixel smartphones also,
compared to other Android devices, receive updates the fastest and for the longest period.

///

## System configuration

### Password

Android limits the maximum password length to 16 characters, so we will use short syllables randomly selected by a computer, making it practically impossible to crack, while you'll only need to enter it once every 72 hours.

{% include-markdown "../../includes/mobile_biometrics.en.md" %}

#### Creating a new password

1. Generate a new mobile password with the FOI Password Generator

    /// admonition | Tip
        type: tip

    Press the generate button until you get a password whose last word you can easily memorize.
        
    ///

    [:material-key: FOI Password Generator](../tools/password-generator/index.md){ .md-button .md-button--primary }

2. Since the password length is limited on Android, instead of separating with a dot or space, start each word with a capital letter
3. Memorizing the password:
    - Write the first three syllables on paper
    - Memorize the last word
    - After memorizing all four words, destroy the paper
4. Saving the password in **Bitwarden**:
    - Create a new entry, give it a name (e.g., **My Pixel 9 Password**)
    - Enter the full password in the Password field
    - Click :material-content-save: Save button

#### Changing the password

<small>Google Pixel instructions are used. On your device, changing the password may be done from a different location</small>

1. Open **Settings**
2. Go to **Security and Privacy > Device Unlock**
3. Select **Screen Lock > Password**
4. Enter the existing password
5. Enter the new password. Since the password length is limited on Android, instead of separating with a dot or space, start each word with a capital letter

{% include-markdown "../../includes/password_paper_storage.en.md" %}

### DNS

**FOI Security Policy** will add two Encrypted DNS servers to the device — Cloudflare and Adguard.

Visit the [DNS](dns.md) page and configure the necessary settings.

### VPN

Visit the [VPN](vpn.md) page, install the VPN provider's application and connect to a server.
