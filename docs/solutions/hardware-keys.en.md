---
title: Hardware Security Keys
icon: simple/yubico
---

# Hardware Security Keys

Hardware security keys, such as Yubikey, are often recommended for improving authentication 
and authorization processes using protocols such as PIV.
However, the practical use of these devices can become a challenge due to several factors 
that often call into question the claims made by manufacturers.

## Technical complexity
The documentation and interfaces of devices like Yubikey are known 
for their technical complexity. Hardware keys expect users to have 
a thorough understanding of concepts such as FIDO, PIV, and the importance of key backups. 
This high knowledge barrier makes such methods ineffective for average users who 
will not have sufficient technical expertise to use these devices effectively and 
securely.

## Assumptions vs reality
Hardware keys make assumptions that are almost never true in practice:

- **The user knows exactly what they are doing and creates backups**: 

<div class="grid cards" markdown>

- :x: Assumed

    ---
    Users understand the technical details of how the device works,
    and can easily create backups or even understand the necessity of doing so.

- :white_check_mark: In reality

    ---
    Creating key backups can be difficult even for individuals 
    with high technical knowledge.
</div>


- **Recovery in case of loss is simple**: 

<div class="grid cards" markdown>

- :x: Assumed

    ---
    In case of key loss, users 
    will easily solve problems without assistance, or will even be able to obtain such assistance. 

- :white_check_mark: In reality

    ---
    In case of key loss, users often permanently lose access to systems.
</div>



- **Users will not leave the security key connected**:

<div class="grid cards" markdown>

- :x: Assumed

    ---
    Users will not leave the security key permanently connected. 

- :white_check_mark: In reality

    ---
    The absolute majority of users will leave their key permanently 
      connected for comfort, which may cause additional risks, 
      such as physical theft or unauthorized use.
</div>

- **Extracting data from the Security Chip (TPM) is impossible**:

<div class="grid cards" markdown>

- :x: Assumed

    ---
    An adversary will never be able to extract data from the security key that would
    give them access to the system.

- :white_check_mark: In reality

    ---
    [Demonstrated methods](https://ninjalab.io/a-side-journey-to-titan/){:target="_blank"} for extracting data from hardware keys exist.
    Additionally, attempting to extract data from an external hardware chip poses significantly 
    less potential risk for the adversary, because a failed attempt will only destroy it
    and not the protected device and the data it contains.
</div>

## Legal and physical threats

Adversaries, especially governments, can legally confiscate security keys. 
Additionally, known methods exist for extracting information from these keys. For example, successful attacks 
on Google's Titan security key revealed vulnerabilities that gave adversaries 
access to the key's contents.
Furthermore, unlike biometric protection methods that identify a person,
hardware keys only establish possession, and possession can easily be transferred to someone else — legally or illegally.
Experienced individuals can disassemble the device to extract embedded keys, which represents a significant security risk.

///  admonition | Remember 
    type: warning

- **What you have (key)**: can easily be taken from you
- **What you know (password)**: only you can give it up.

///


## Closed ecosystem
Yubikeys and similar hardware security modules operate 
in a closed ecosystem. There is almost no independent data 
confirming the claims made about their security effectiveness. 
The lack of transparency and independent verification makes it difficult
to fully trust and verify the security advantages declared by manufacturers.


## Comparison with integrated security
Comparing hardware security keys with integrated hardware security 
modules, such as Apple's Secure Enclave, Google's Titan chips, or Windows devices' TPM, 
reveals even more shortcomings:

### Gaining access to a device protected by Yubikey:

If a device protected by Yubikey or another hardware key is confiscated by a government or
another entity with significant resources, that entity can gain access to the data relatively easily.

In most cases, the key will also end up in their hands along with the protected device.

Given that security keys create false expectations, users will be inclined
to set a relatively simple PIN on it, which transfers protection from what only the user knows (strong password)
to what the user simply has (physical object).

Also, the device may not even require entering a PIN and the mere presence of the key may be enough to access the system.

This can be resolved by protecting the key with a strong PIN. However, this reduces the comfort level and completely
negates the main benefit offered by hardware keys — simplicity.

///  admonition | You already have a "Yubikey"
    type: warning

The security module built into your device (Secure Enclave, Titan, TPM) is essentially
the same Yubikey for authentication purposes, but extracting it is much more difficult and risky for the adversary!

///


### Gaining access to a device protected by a hardware security module and biometrics:

Devices with integrated security modules that use biometric 
data and PIN codes offer more robust security. 

Such systems impose a limited number of Biometric Authentication access attempts, and with FOI Security Policy,
require PIN verification once every 8 hours, which protects against both physical theft and forced access attempts. 


Unlike Yubikeys, opening the device to access its security module 
often results in data destruction, which strengthens data security.

## A better alternative

### Apple devices with Secure Enclave:

Enable Biometric Authentication (Touch ID / Face ID), install FOI Security Policy, and set a password
consisting of at least 4 words generated by the Password Manager.

In this case, using the device will only be possible with Biometric Authentication or a password,
which, combined with the built-in security module, provides stronger protection than a Yubikey. Because 
Biometric Authentication establishes your identity, while the Security Chip (TPM) establishes possession, which already constitutes Multi-factor Authentication.

In case of device loss or confiscation, due to the time-limited Biometric Authentication, access to the system will only be possible with a password.

### Windows devices with TPM:

If your device does not have a fingerprint sensor, [you can freely purchase and add one](https://www.amazon.com/dp/B01NAVWPOJ){:target="_blank"}.

Enable Biometric Authentication (Windows Hello), install FOI Security Policy, set a 4-word PIN, and connect a trusted device (e.g., phone) via Bluetooth.

In this case, the system will first require fingerprint verification for login, and then, if the trusted device is connected and nearby,
will automatically log you into the system.

FOI Security Policy will disconnect the trusted device as a second factor once every 8 hours, additionally requiring PIN entry.

This can be considered three-factor authentication, which provides more protection than a Yubikey.

## Conclusion
Despite hardware security keys such as Yubikey 
providing a certain level of digital authentication, 
their effectiveness is limited by technical complexity, user behavior, and a closed, 
often unverified ecosystem. 
For most users, especially those 
facing real threats, integrated security modules offer 
a more secure and user-friendly alternative.
