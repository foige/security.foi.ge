---
title: iOS
icon: material/apple-ios
---

# iOS

## Prerequisites

- [x] Install a [Password Manager](passwords.md)
    - To store a unique, strong password for the phone that is also easy to enter.
- [x] Install [FOI Security Policy](../policies/index.md)
    - The profile will configure the main part of the security settings and its installation
      is necessary before following the instructions on this page.


{% include-markdown "../../includes/device_has_updates.md"%}

## System configuration

On iOS, all settings are configured by installing [FOI Security Policy](../policies/index.md).

For encrypting data stored on iCloud, you can use the [macOS instructions](macos.md#icloud).

### Password

By default, we use 6-digit passwords on the device. 
The reason is that iPhones have additional security mechanisms beyond passwords. 
Software and hardware restrictions reduce the speed of Brute-force (trying all possible combinations) 
to a level where trying all combinations could potentially take years.

iOS has a setting where entering the password incorrectly 11 times causes 
the data on the device to be erased. However, these are only software and hardware 
restrictions that may have vulnerabilities, allowing an attacker unlimited attempts.

The Entropy (password strength) of a 6-digit password is only 15 bits. If there is a software or
hardware flaw in the device, such a password could be cracked in less than a second.

After installing **FOI Security Policy**, if you were using a 6-digit password, the system 
will automatically prompt you to set a new password. 

Go to the **[FOI Security Policy](../policies/index.md)** page and follow the instructions.


### DNS

**FOI Security Policy** will add two Encrypted DNS servers to the device — Cloudflare and Adguard.

Visit the [DNS](dns.md) page, choose the server you prefer and activate it through:

![Apple Settings](../assets/img/icons/apple/settings.svg){ .twemoji } **System Settings** 
    > **VPN & Device Management** > **DNS**

### VPN

Visit the [VPN](vpn.md) page, install the VPN provider's application and connect to a server.
