---
title: Browser
icon: material/google-chrome
---

# Browser Security Policy

FOI Security Policy includes the following configuration and will be automatically activated in all
browsers listed below:

/// admonition | Android
    type: warning
FOI Security Policy cannot be installed on Android and settings must be changed manually.
///

## Chrome / Brave / Firefox

### Password Manager must be disabled

Instead of the browser's password manager, you should use the recommended Password Manager.

//// details | Configuration
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | Manual configuration
    type: info
    open: false

Chrome/Brave:

- Computer Configuration > Administrative Templates > Google/Brave > Password Manager:
    - Enable saving passwords to the password manager > `Disabled`

Firefox:

- Comp

///
///

/// tab | macOS | iOS
{% include-markdown "../../includes/foi_security_policy.md"%}
/// details | Manual configuration
    type: info
    open: false

Chrome/Brave:

- Search for 'leak detection' and 'password manager' in iMazing Profile Editor and disable them

Firefox:

- 

///
///


/// tab | Android
* Chrome: Settings > Google Password Manager > Offer to save passwords > `Disabled`
* Brave: Settings > Brave Password Manager > Save passwords > `Disabled`
///

////


//// details | Validation
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - should be listed:

- PasswordManagerEnabled: false
///

/// tab | Android
N/A
///

////

/// details | Additional information
    type: reference
    open: false

- [DISA Stig](https://www.stigviewer.com/stig/google_chrome_current_windows/2023-11-21/finding/V-221567){:target="_blank"}
- [Leaked Password Detection](https://www.usenix.org/conference/usenixsecurity23/presentation/kwong){:target="_blank"}

///

---

### Browser DNS must be disabled

The browser may use its own DNS settings and ignore system settings. It is necessary to
disable the browser's DNS Resolver and use the system's DNS settings (DNS-over-HTTPS).

//// details | Configuration
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | Manual configuration
    type: info
    open: false

Computer Configuration > Administrative Templates > Classic Administrative Templates > 
    Google/Brave > Use built-in DNS client > `Disabled`

///
///

/// tab | macOS | iOS
{% include-markdown "../../includes/foi_security_policy.md"%}
/// details | Manual configuration
    type: info
    open: false

Search for 'Use built-in DNS client' in iMazing Profile Editor and disable it
///
///


/// tab | Android
Not required.
///

////


//// details | Validation
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - should be listed:

- BuiltInDnsClientEnabled: false

///

/// tab | Android
N/A
///

////

/// details | Additional information
    type: reference
    open: false


///

---

### Third-party cookies must be blocked

The main use of third-party cookies is tracking/monitoring user web browsing
and they are almost never used for useful purposes. Third-party cookies must be blocked 
in the browser.

//// details | Configuration
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | Manual configuration
    type: info
    open: false

Computer Configuration > Administrative Templates > Classic Administrative Templates > 
    Google/Brave > Block third-party cookies > `Enabled`

///
///

/// tab | macOS | iOS
{% include-markdown "../../includes/foi_security_policy.md"%}
/// details | Manual configuration
    type: info
    open: false

Search for 'Block third party cookies' in iMazing Profile Editor and enable it.
///
///


/// tab | Android
Chrome: Settings > Privacy and security > Third-party cookies > `Block third-party cookies`
Brave: Settings > Brave Shields & Privacy > Block Cookies > `Block third-party cookies`
///

////


//// details | Validation
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - should be listed:

- BlockThirdPartyCookies: true

///

/// tab | Android
N/A
///

////

/// details | Additional information
    type: reference
    open: false


///

---

### External remote connections must be blocked

Chromium browsers have a built-in browser and system remote control function 
( Remote Desktop).
These connections can "pierce" the firewall, where a potential attacker
connects to the system from the internet, bypassing the firewall. Such connections must be blocked
and this capability should only remain for systems on the local network.

//// details | Configuration
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | Manual configuration
    type: info
    open: false

Google/Brave:

- Computer Configuration > Administrative Templates > Classic Administrative Templates > 
    Google/Brave > Remote access:
    - Allow remote access connections to this machine > `Disabled`
    - Allow remote support connections to this machine > `Disabled`
    - Enable firewall traversal from remote access host > `Disabled`

Firefox:

Not required.

///
///

/// tab | macOS | iOS
{% include-markdown "../../includes/foi_security_policy.md"%}
/// details | Manual configuration
    type: info
    open: false

Google/Brave:

Search and set the corresponding parameters using iMazing Profile Editor:

```
- RemoteAccessHostFirewallTraversal: false
```

Firefox:

Not required.

///
///


/// tab | Android

Not required.

///

////


//// details | Validation
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - should be listed:

```
- RemoteAccessHostFirewallTraversal: false
```

///

/// tab | Android
Not required.
///

////

/// details | Additional information
    type: reference
    open: false

[DISA Stig](https://www.stigviewer.com/stig/google_chrome_current_windows/2023-11-21/finding/V-221558){:target="_blank"}

///