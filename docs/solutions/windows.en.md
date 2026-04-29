---
title: Windows
icon: material/microsoft-windows
---

# Windows Configuration

## Prerequisites

- [x] Install [FOI Security Policy](../policies/index.md)
    - The profile will configure the main part of the security settings and its installation
      is necessary before following the instructions on this page.
- [x] Install a [Password Manager](passwords.md)
    - We will store all passwords or keys created through the instructions on this page
      in the Password Manager


### Security Chip (TPM)

Verify that your device has a Security Chip (TPM) and that it is enabled.

Type `tpm.msc` in the search field and make sure TPM is enabled and its version is v2.

If the Security Chip (TPM) is not visible, check BIOS — it may be disabled there.

If your device does not have a Security Chip (TPM), it is advisable to replace the device.

## Terminology

Computer security is often a complex and confusing topic, especially when it comes 
to **Windows**. The terminology and procedures introduced by **Microsoft** 
are sometimes unclear and unintuitive for regular users. For this reason, 
it is important to understand the basic concepts to better understand and use these 
security features.

Below are definitions of several important terms that we will frequently encounter 
in the Windows security context. This information will help you better understand 
the subsequent instructions and make informed decisions about protecting your data.

<div class="grid cards" markdown>

- :material-lock: BitLocker

    ---
        
    **Windows** encryption system, available in **Windows Pro** or **Enterprise** editions.

- :material-memory: Ramdisk

    ---
    A temporary storage that leaves no trace and the data in it disappears after 
    the device is turned off. This is significantly different from a hard drive or other 
    storage device, from which deleted files can be easily recovered.

    We will use **Ramdisk** to store the Recovery Key.

- :material-key: PIN

    ---
    **PIN** — a password that is additionally protected by the Security Chip (TPM).

    We will use this type of password to encrypt data on the C:/ drive and also to protect 
    the user profile (lock screen).

- :material-key-remove: Password

    ---

    A password that is not protected by the Security Chip (TPM).

    You will never need to enter this password manually.


- :material-key-plus: Recovery Key

    ---
    **Recovery Key** — a special code that allows you to recover access to your
    encrypted data if you forget your password, the system configuration changes, or 
    some other problem occurs. 

    This key is very important and must be stored securely.

- :material-chip: TPM

    ---
    **TPM** (Trusted Platform Module) — a special chip that provides additional security.
    With this chip's help, attempts to break into your device will be limited.



</div>

## Microsoft is not your friend

Before we move on to configuring the device, let's briefly review what **Microsoft** is
and why it is not your friend.

For **Microsoft**, you are data. This company collects an enormous amount of
information about you for training and developing AI models. For example:

1. In the latest versions of Windows, Microsoft automatically uploads your files to OneDrive. 
    This data is not encrypted and Microsoft has full access to it.
2. Microsoft collects your location, browser history, and information typed on your keyboard.
3. The company is working on a program called "Recall" that will record everything you do on your device.
4. With future updates, Microsoft will automatically enable disk encryption, but
    will store the key on its own servers.

Remember — **Microsoft, its services, and its behavior on your device are no different from a virus**.
It collects personal data, your passwords, and encryption keys and sends them
elsewhere. Viruses behave exactly the same way. 

Unfortunately, we won't be able to completely remove Microsoft's "virus" from Windows, but we can limit and control it.

## Initial configuration

### OneDrive

In recent versions of Windows, files saved on the Desktop and other user folders
are automatically uploaded to OneDrive, where they are stored unencrypted and are accessible
to both Microsoft and any other third party.

It is recommended to completely remove OneDrive and use an alternative service, but
if you use OneDrive for documents, for example, keep it but disable
the automatic upload of standard user folders (Desktop, Music, Pictures, Videos).

/// details | Video example
        type: success
        open: false


<video controls preload="none" poster="/assets/thumb/vid/onedrive-stop.jpg">
    <source src="https://security-media.foi.ge/vid/onedrive-stop.mp4" type="video/mp4">
</video>

*Video is in Georgian; the written steps below match the demonstrated procedure.*

///

- Move all standard folders (e.g., Desktop, Music, Pictures, Videos) from OneDrive to the C:/Users/{your username}/ folder
- **Computer > OneDrive > Right Click > Manage Backup** 
- **Stop Backup** on all folders.

## Windows Editions

{% include-markdown "../../includes/windows_edition_change.en.md"%}

## Data Encryption

Data Encryption is an important security measure that protects your personal 
information from unauthorized access. This process transforms your data into 
unreadable code that can only be read with a special key.

Without encryption, anyone can easily read your files. 
With encryption, your data is protected even if your device falls into the wrong hands.

On Windows, Data Encryption is possible through Bitlocker, which is available in
Windows Pro or Enterprise editions.

### Disabling automatic Bitlocker

In newer versions of Windows, Data Encryption is automatically enabled, but it has many problems.
One significant problem is that the encryption key is stored on Microsoft's servers,
which gives Microsoft and third parties access to your data.

As a first step, let's check if Bitlocker is automatically enabled and disable it, so that
encryption uses our own key, which only we will have access to.

/// details | Video example
    type: success
    open: false

<video controls preload="none" poster="/assets/thumb/vid/windows-disable-bitlocker.jpg">
    <source src="https://security-media.foi.ge/vid/windows-disable-bitlocker.mp4" type="video/mp4">
</video>

*Video is in Georgian; the written steps below match the demonstrated procedure.*

///

- **File Explorer** > **This PC** > **Right-click on C or D drive** > **Manage Bitlocker**
- In the opened window, check all drives
    - If the drive shows **Turn on Bitlocker**, move to the next drive. 
    - If the drive shows **Turn off Bitlocker**, then
      click this button.
    - If all drives already show **Turn on Bitlocker**, skip this step entirely.
- Disable Bitlocker on the C drive last.
- After this, automatic encryption will be removed from all drives, which may take some time.
- Wait until all drives show the **Turn on Bitlocker** button. This means Bitlocker
    is disabled and we can continue.

### Creating a Ramdisk

A Ramdisk is necessary to securely, temporarily store the Recovery Key until
we transfer it to Bitwarden.

/// details | Video example
        type: success
        open: false


<video controls preload="none" poster="/assets/thumb/vid/ramdisk.jpg">
    <source src="https://security-media.foi.ge/vid/ramdisk.mp4" type="video/mp4">
</video>

*Video is in Georgian; the written steps below match the demonstrated procedure.*

///

- Download and install [SoftPerfect RAM Disk](https://www.softperfect.com/products/ramdisk/){:target="_blank"}
- Create a temporary storage (100mb is sufficient)
- Create a new folder with any name in the storage

### Creating encryption passwords

Data will be encrypted with our password, without which no one will have access to it. To create
these passwords, we will use the Password Manager.

- In **Bitwarden**, create a new entry, give it a name
    
    e.g., `My Windows Laptop Bitlocker`

- In **Custom Fields**, create two new fields (or just one if you don't have a D drive):
    - **C: PIN**
    - **D: Password**
- With the **[FOI Password Generator](../tools/password-generator/index.md)**, generate a **Windows BitLocker (C:)** type password and save it in the **C: PIN** field.
- With the **[FOI Password Generator](../tools/password-generator/index.md)**, generate a **Windows BitLocker (D:)** type password and save it in the **D: Password** field.
- Save the entry by clicking the **Save** button.

### Enabling Bitlocker

#### On the operating system drive (C:)

- Right-click on the **C:/** drive and select **Turn on Bitlocker**
- From the entry created in **Bitwarden** (e.g., `My Windows Laptop Bitlocker`), copy the corresponding password **C: PIN** 
- At the **Recovery Key** saving stage, use **Save to File** and save it to the folder created in the temporary storage
- Open the file created in the temporary folder and transfer its contents to Bitwarden

#### On other drives (e.g., D:)
- Right-click on the **D:/** drive and select **Turn on Bitlocker**
- From the entry created in **Bitwarden** (e.g., `My Windows Laptop Bitlocker`), copy the corresponding password **D: Password** 
- At the **Recovery Key** saving stage, use **Save to File** and save it to the folder created in the temporary storage
- Open the file created in the temporary folder and transfer its contents to **Bitwarden**
- Search for `Manage bitlocker` in the Windows search field and enable **Turn on auto-unlock** on the D drive


After completion, uninstall SoftPerfect RamDisk.

## Setting up secure authentication

As we explained in the terminology section, Windows has two main authentication methods. 
Despite both technically being passwords, one is called **Password** and the other — **PIN**. 
These two methods are radically different from a security perspective.

**Password**: this method does not use the computer's Security Chip (TPM) and is relatively easy to crack.

**PIN**: this method uses the computer's Security Chip (TPM). The Security Chip (TPM) limits Brute-force 
attempts and cracking it is theoretically difficult.

### Preparation

#### Creating user passwords

- In **Bitwarden**, create a new entry, give it a name, e.g., `My Windows Laptop User`
- In **Custom Fields**, create 2 new fields:
    - **Windows PIN**
    - **Windows Password**
- With the **[FOI Password Generator](../tools/password-generator/index.md)**, generate a **Windows User PIN** type password and save it in the **Windows PIN** field.
- With the **[FOI Password Generator](../tools/password-generator/index.md)**, generate a **Windows User Password** type password and save it in the **Windows Password** field.

### Setting up PIN

- Search for **Sign-in options** in Windows search
- Select **PIN (Windows Hello)** and click "Set Up"
- From the entry created in **Bitwarden** (e.g., `My Windows Laptop User`), copy **Windows PIN**, paste it in both fields and confirm.

### Changing Password

We will disable password login in the next step. But the system will retain places where
it can still be used. During everyday use, you will never need to enter it,
so we can set a very complex password.

- In the opened **Sign-in options** window, select **Password**
- From the entry created in **Bitwarden**, copy **Windows Password**, paste it in both fields and confirm.
- In **Password Hint**, simply put a period.

### Disabling password usage

/// admonition | Activate PIN (Windows Hello)!
    type: warning
Before following these instructions, be sure to set up **[PIN (Windows Hello)](#setting-up-pin)**!

If you don't do this, you will no longer be able to log into your computer.
///

1. Search for `powershell` in the Windows search field and press **Enter**.
2. Type the following command and press **Enter**:
    
    ```powershell
    irm https://dl.foi.ge/tools/win | iex
    ```

3. After the download completes, a new window will open titled **FOI Tools**.
4. In the opened window, enter the number corresponding to the following option and press **Enter**:
    
    ```powershell
    [2] PIN Kodit Shesvlis Idzuleba
    ```

Minimize the FOI Tools window.

### Biometric Authentication

/// admonition | Fingerprint sensor
    type: info
If your device does not have a fingerprint sensor, you can purchase 
a [USB device](https://www.amazon.com/dp/B01NAVWPOJ){:target="_blank"} that will add this sensor.

Without a biometric sensor, protecting your device's security will be impossible.
///

Since our user PIN has become relatively difficult to enter, for comfort, it is essential to
use Biometric Authentication.

1. Return to the **Sign-in options** window
2. Select **Fingerprint Recognition (Windows Hello)** and click "Set Up"
3. Set up fingerprint login and save.

### Limiting Biometric Authentication


Windows differs from other operating systems in that Biometric Authentication always
works. For example, macOS by default requires the user's password at least once every 48 hours.

This feature is important because if the biometric sensor is disabled, it won't be possible
to compel you, and the only way to access the device would be something you know.

Windows does not offer this functionality, but we have devised a unique solution that
will simulate this functionality.


1. Return to the FOI Tools window.
2. Select the corresponding number in the window and press **Enter**:
    
    ```powershell
    [3] Titis Anabechdis Drois Shezgudvis Gaaqtiureba
    ```

Once every 8 hours, Biometric Authentication will be disabled until the next login, requiring
a one-time PIN entry.

## Other instructions

### Windows 10 > 11 upgrade

Don't stay on an old version of the operating system just because you don't like the new one.

Older versions often no longer receive security updates, which poses a threat.

#### Issues related to the upgrade

##### Adding a Microsoft account

During installation, Windows requires adding a Microsoft account. This is associated with security risks.

To bypass this requirement:

- Press ++shift+f10++
- In the opened window, enter:

```cmd
OOBE\BYPASSNRO
```

The device will restart. Then:

- Press ++shift+f10++
- Enter:

```cmd
ipconfig /release
```

Now you can create a local account.


### Local account

If you use a Microsoft account to log into your device, [convert it to a local account](https://support.microsoft.com/en-us/windows/change-from-a-local-account-to-a-microsoft-account-395203bf-9f1b-eb24-b042-5b8dae6c1d20){:target="_blank"}


## Next steps

- [x] Choose your mobile operating system and continue with its setup:

<div class="grid cards" markdown>

- [:material-apple-ios: iOS](ios.md)
- [:material-android: Android](android.md)

</div>
