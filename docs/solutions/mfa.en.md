---
title: Multi-factor Authentication
icon: material/two-factor-authentication
---

# Multi-factor Authentication

Multi-factor Authentication (2FA / MFA) is an additional security layer 
that requires an extra factor alongside a password to access an account. 

Despite SMS-based 2FA being widely used, it is not recommended 
for security reasons. The drawbacks of SMS include:

1. Vulnerable to SIM Swapping (simply put — someone else uses your number)
2. SMS messages are not encrypted and are accessible to third parties (e.g., mobile operators, government agencies, applications)

Instead, the use of app-based authenticators is recommended.

## Prerequisites

- [x] Install a [Password Manager](passwords.md)
    - To create and store a unique, strong password for the two-step app account
    - To store the two-step app account recovery key

## Recommended application

<div class="grid cards" markdown>

- ![Ente Auth](../assets/img/logo/ente-auth.svg){ .lg .middle .twemoji } [Ente Auth](https://ente.io/auth/){:target="_blank"}

    ---
    **Ente Auth** is an open-source and free 2FA code generator where
    your data is encrypted with your unique password and no one besides you,
    including Ente, has access to it.

</div>


## Installation and account creation

/// details | Video example
        type: success
        open: false


<video width="414" controls preload="none" poster="/assets/thumb/vid/ente-auth.jpg">
    <source src="https://security-media.foi.ge/vid/ente-auth.mp4" type="video/mp4">
</video>

*Video is in Georgian; the written steps below match the demonstrated procedure.*

///

1. Download and install the application for your device:

    <div class="grid cards" markdown>
    
    - [:material-apple-ios: iOS 17](https://apps.apple.com/us/app/ente-auth/id6444121398){:target="_blank"}
    - [:material-android: Android](https://play.google.com/store/apps/details?id=io.ente.auth){:target="_blank"}
    
    </div>

2. Open **Ente Auth** and enter your email address
3. Open **Bitwarden** and start creating a new entry.
4. Name the entry, e.g., `Ente Auth`
5. Username: enter your email address
6. Password: click the :fontawesome-solid-arrows-rotate: button to generate a new password
7. Select **Password type**: `Password`, **Length**: `30`, make sure `A-Z`, `a-z`, `0-9` are enabled and click **Select**
8. Save the entry by clicking the *Save* button
9. Select the created entry, click the :material-dots-horizontal: button and select **Copy Password**
10. Return to the **Ente Auth** app and paste the copied password
11. Click the **Create account** button
12. Enter the code received via email in the corresponding field
13. In the next window, you will see the **Recovery key**.

    Data stored in **Ente Auth** is encrypted with your 
    password, and if you need to change or recover it, you will need to enter this
    special code. This code will be the only way to recover your data.

14. Copy the indicated code, return to Bitwarden, start creating a new entry and
    name it, e.g., `Ente Auth Recovery Key`
15. Paste the copied data in the **Password** field and click **Save**
16. Return to the **Ente Auth** app, click the **Continue** button
17. The account is created

## Using **Ente Auth** authentication with the Google account example

For demonstration, we will enable additional authentication with **Ente Auth** on a Google account. 

1. On your laptop's browser, go to the Google account [security settings page](https://myaccount.google.com/security){:target="_blank"}
2. Select **2-Step Verification**
3. Select **Authenticator** > **Set up authenticator**
4. On your phone, open **Ente Auth** and click **Scan a QR Code** or the **+** button
5. Scan the QR code shown in the browser and click **Next**
6. Enter the code shown in the app and click **Verify**
7. In the browser, click **Turn on 2-Step Verification** > **Turn on** > **Turn on 2-Step Verification**

In your laptop's browser, on the same page, be sure to disable all other additional authentication methods
and keep only **Authenticator**, which we just set up.

/// admonition | The weakest link method
    type: warning

**Remember**: your security level is determined by the weakest method.

**Example**: if you use SMS alongside **Ente Auth** for two-step authentication to protect your account,
then your overall security level is reduced to the SMS (very weak) security level.

///


## Recommendations

- [x] Use only the mobile app and do **not** install **Ente Auth** on your laptop
- [x] Use **Ente Auth** as the sole two-step authentication method on services, disable all others (e.g., email, SMS)

## Next steps

- [x] Enable Multi-factor Authentication on all important accounts and choose
    **Ente Auth / Authenticator** as the sole method, disable SMS and all other methods.
- [x] Choose your Desktop operating system and continue with its setup:

<div class="grid cards" markdown>

- [:material-microsoft-windows: Windows](windows.md)
- [:material-apple: macOS](macos.md)

</div>
