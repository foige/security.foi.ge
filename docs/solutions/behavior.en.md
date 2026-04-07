---
title: General Recommendations
icon: material/account-alert
---

# General Recommendations

## Before entering a high-risk environment

If you expect that your device may fall into the hands of adversaries
in a particular environment (e.g., a protest, a border crossing, or any high-risk situation), it is essential to follow several recommendations.

Any encrypted device (laptop, smartphone, etc.) has two modes — Before First Unlock (BFU) and After First Unlock (AFU).
The first mode is active when the password has not been entered after a restart, while the second is active when the password has been
entered at least once.

The security differences between these modes are quite significant. After the first unlock,
extracting information from the device is still possible regardless of how strong
a password you have used. The scale of the information depends on the device and its general security, and therefore,
we should consider that handing over a device in AFU mode to an adversary is not safe.

- [x] Follow all recommendations on this site for all your devices
- [x] Power off all devices left at home
- [x] Do not disable Face ID / Touch ID! These features are automatically disabled when the device is powered off

    - Explanation: if you can still comfortably use the device after disabling these features,
       it means you are using a password on the device that can be easily cracked.

## The risk of your device falling into adversary's hands is immediate and unavoidable

- [x] Power off all devices you have with you — in this case, the device will enter BFU state and extracting data from it will be very difficult or impossible
- [x] If detained, contact a lawyer, but not from your phone! After entering the password, your phone may be confiscated and
   they will attempt to examine the data on your device. Request to make the call from a different device

If you cannot power off the device in time, activate the special mode on your mobile that
will temporarily disable Face ID / fingerprint unlock.

//// details | Quick biometric disable
    type: info
    open: false

iOS and Android systems have methods to quickly disable Biometric Authentication.
In this case, the next device unlock will only be possible with a password.

For Android, the availability of **Lockdown** mode depends on the device manufacturer.
For Android users, it is recommended to use a [**Google Pixel**](android.md/#რეკომენდირებული-მოწყობილობები) device, where
this mode is confirmed to exist.

/// tab | iOS

- Press the power button quickly 5 times.
- Or, alternatively, press and hold the power and volume up or down buttons simultaneously for 5 seconds.
- Biometric Authentication will be disabled

///


/// tab | Android

- Press and hold the power button for a few seconds, select **Lockdown**

///

////


## If your device is lost or stolen

- [x] Immediately change all important account passwords from another secure device
- [x] Use the remote wipe function if available
- [x] Block your SIM card with your mobile operator
- [x] Notify the relevant authorities (police, employer) about the device loss
- [x] Cancel any bank cards or financial information that was connected to the device

## General security recommendations

- [x] [Use strong, unique passwords for all accounts](passwords.md)
- [x] [Enable Multi-factor Authentication where possible](mfa.md)
- [x] Regularly update your devices and programs
- [x] Never use public Wi-Fi networks
