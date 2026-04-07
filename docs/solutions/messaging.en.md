---
title: Communication
icon: material/chat
---

# Communication

## Prerequisites

- [x] [Password Manager](passwords.md)

## Recommended communication tool

<div class="grid cards" markdown>

- ![Signal](../assets/img/logo/signal.svg){ .lg .middle .twemoji } [Signal](https://signal.org/download/){:target="_blank"}

    ---
    **Signal** is the most secure communication tool. Signal stores only
    minimal information about the user and all communication is end-to-end encrypted (E2EE). 
    This means that only you and your recipient have access to your communication.
    Even if a government requests data about you from Signal, Signal
    has nothing and therefore cannot provide anything.

</div>

## Additional security

### Registration lock

Since Signal uses a mobile number for registration, attackers
can steal your number and register with it. To prevent this,
it is essential to set a password on registration.

1. In Bitwarden, generate a 5-word password and save it. Name it, e.g., "Signal PIN"
2. In Signal, go to :material-dots-vertical: > **Settings** > **Account** > **Signal PIN**
3. Click **Create PIN** or **Change PIN** and enter the generated password
4. - [x] Enable "Registration Lock"

After this, when reinstalling Signal, in addition to number verification, you will need to
enter this password. Other parties will only be able to register with your number without this password
if the number is not active on any device for 7 days.

### Hiding your mobile number

In Signal, it is possible to use usernames instead of a mobile number.
After setting a username, your number will be visible to those you communicate with
only if they have you added in their contacts.

1. In Signal, go to :material-dots-vertical: > **Settings** > **Click on your name or photo**
2. Next to the **@** symbol, enter your desired username
3. In Signal, go to :material-dots-vertical: > **Settings** > **Privacy** > **Phone Number** and set:

    Who can see my phone number:

     - **Nobody**
   
    Who can find me by number:

     - **Nobody**

4. Instead of sharing your mobile number, share your unique username.

### Automatic message deletion

Despite Signal messages being end-to-end encrypted, these messages are still stored
on the device. If someone gains access to your or your recipient's device,
your messages will become available to them.

With automatic message deletion, messages are deleted after the set time expires. The timer starts after the recipient reads the message.

1. In Signal, go to :material-dots-vertical: > **Settings** > **Privacy** > **Disappearing messages**
2. Select 1 week

After this, all messages sent or received in newly started chats will be deleted from all
devices after 1 week.

In cases where you want to keep message history for a longer period or disable automatic
deletion entirely, you can change this from a specific chat's settings.

### Identity verification

Make sure the person you are talking to is truly who you think they are. There is a risk that
someone may try to impersonate a person known to you. To prevent this, you can:

1. When meeting the person (preferably in person, but as a last resort — via video call), start communicating with them through Signal's chat.
2. On both devices, in the Signal chat, go to :material-dots-vertical: > **View safety number**
3. Compare the numbers and if they match, mark as "Mark as verified"

If someone has inserted themselves "in the middle" of this communication, or has registered with the person's number on another device,
this number will change and the contact will automatically lose verification.

Never trust a new contact until you verify their identity. Signal does not verify
people's names and, accordingly, anyone can call themselves whatever they want.
