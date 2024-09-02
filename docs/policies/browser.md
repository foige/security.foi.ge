---
title: ბრაუზერი
icon: material/google-chrome
---

# ბრაუზერების უსაფრთხოების პოლიტიკა

FOI Security Policy მოიცავს შემდეგ კონფიგურაციას და ავტომატურად გააქტიურდება ყველა
ქვემოთ მოცემულ ბრაუზერში:

/// admonition | Android
    type: warning
FOI Security Policy-ს Android-ზე დაყენება შეუძლებელია და აუცილებელია პარამეტრების ხელით შეცვლა.
///

## Chrome / Brave / Firefox

### პაროლების მენეჯერი უნდა გაითიშოს

ბრაუზერის პაროლების მენეჯერის ნაცვლად, უნდა გამოიყენოთ რეკომენდირებული პაროლების მენეჯერი.

//// details | კონფიგურაცია
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | ხელით კონფიგურაცია
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
/// details | ხელით კონფიგურაცია
    type: info
    open: false

Chrome/Brave:

- მოძებნეთ 'leak detection' და 'password manager' iMazing Profile Editor-ით და გათიშეთ

Firefox:

- 

///
///


/// tab | Android
* Chrome: Settings > Google Password Manager > Offer to save passwords > `Disabled`
* Brave: Settings > Brave Password Manager > Save passwords > `Disabled`
///

////


//// details | ვალიდაცია
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - ჩამოთვლილი უნდა იყოს:

- PasswordManagerEnabled: false
///

/// tab | Android
N/A
///

////

/// details | დამატებითი ინფორმაცია
    type: reference
    open: false

- [DISA Stig](https://www.stigviewer.com/stig/google_chrome_current_windows/2023-11-21/finding/V-221567){:target="_blank"}
- [Leaked Password Detection](https://www.usenix.org/conference/usenixsecurity23/presentation/kwong){:target="_blank"}

///

---

### ბრაუზერის DNS უნდა გაითიშოს

ბრაუზერმა შესაძლოა გამოიყენოს საკუთარი DNS პარამეტრები და უგულებელყოს სისტემური. აუცილებელია
ბრაუზერში არსებული DNS Resolver-ის გათიშვა და სისტემის DNS პარამეტრების გამოყენება (DNS-over-HTTPS).

//// details | კონფიგურაცია
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | ხელით კონფიგურაცია
    type: info
    open: false

Computer Configuration > Administrative Templates > Classic Administrative Templates > 
    Google/Brave > Use built-in DNS client > `Disabled`

///
///

/// tab | macOS | iOS
{% include-markdown "../../includes/foi_security_policy.md"%}
/// details | ხელით კონფიგურაცია
    type: info
    open: false

მოძებნეთ 'Use built-in DNS client' iMazing Profile Editor-ით და გათიშეთ
///
///


/// tab | Android
არ არის საჭირო.
///

////


//// details | ვალიდაცია
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - ჩამოთვლილი უნდა იყოს:

- BuiltInDnsClientEnabled: false

///

/// tab | Android
N/A
///

////

/// details | დამატებითი ინფორმაცია
    type: reference
    open: false


///

---

### Third-party cookies უნდა დაიბლოკოს

Third-party cookies მთავარი გამოყენება მომხმარებლის ვებ ბრაუზინგის თვალთვალი/მონიტორინგია
და თითქმის არასდროს გამოიყენება სასარგებლო მიზნებისთვის. Third-party cookies უნდა დაიბლოკოს 
ბრაუზერში.

//// details | კონფიგურაცია
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | ხელით კონფიგურაცია
    type: info
    open: false

Computer Configuration > Administrative Templates > Classic Administrative Templates > 
    Google/Brave > Block third-party cookies > `Enabled`

///
///

/// tab | macOS | iOS
{% include-markdown "../../includes/foi_security_policy.md"%}
/// details | ხელით კონფიგურაცია
    type: info
    open: false

მოძებნეთ 'Block third party cookies' iMazing Profile Editor-ით და ჩართეთ.
///
///


/// tab | Android
Chrome: Settings > Privacy and security > Third-party cookies > `Block third-party cookies`
Brave: Settings > Brave Shields & Privacy > Block Cookies > `Block third-party cookies`
///

////


//// details | ვალიდაცია
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - ჩამოთვლილი უნდა იყოს:

- BlockThirdPartyCookies: true

///

/// tab | Android
N/A
///

////

/// details | დამატებითი ინფორმაცია
    type: reference
    open: false


///

---

### გარე დისტანციური კავშირები უნდა დაიბლოკოს

Chromium-ის ბრაუზერებში ჩაშენებულია ბრაუზერის და სისტემის დისტანციური კონტროლის ფუნქცია 
(Remote Desktop).
ამ კავშირებს firewall-ის "გარღვევა" შეუძლიათ, სადაც პოტენციური ბოროტმოქმედი
firewall-ის გვერდის ავლით, ინტერნეტიდან უკავშირდება სისტემას. ასეთი კავშირი უნდა დაიბლოკოს
და ეს შესაძლებლობა მხოლოდ ლოკალურ ქსელში არსებულ სისტემებს უნდა დარჩეთ.

//// details | კონფიგურაცია
    type: success
    open: true

/// tab | Windows
{% include-markdown "../../includes/foi_security_policy.md"%}

/// details | ხელით კონფიგურაცია
    type: info
    open: false

Google/Brave:

- Computer Configuration > Administrative Templates > Classic Administrative Templates > 
    Google/Brave > Remote access:
    - Allow remote access connections to this machine > `Disabled`
    - Allow remote support connections to this machine > `Disabled`
    - Enable firewall traversal from remote access host > `Disabled`

Firefox:

არ საჭიროებს.

///
///

/// tab | macOS | iOS
{% include-markdown "../../includes/foi_security_policy.md"%}
/// details | ხელით კონფიგურაცია
    type: info
    open: false

Google/Brave:

iMazing Profile Editor-ით მოძებნეთ და დააყენეთ შესაბამისი პარამეტრები:

```
- RemoteAccessHostFirewallTraversal: false
```

Firefox:

არ საჭიროებს.

///
///


/// tab | Android

არ საჭიროებს.

///

////


//// details | ვალიდაცია
    type: example
    open: true

/// tab | Windows | MacOS | iOS

chrome://policy - ჩამოთვლილი უნდა იყოს:

```
- RemoteAccessHostFirewallTraversal: false
```

///

/// tab | Android
არ საჭიროებს.
///

////

/// details | დამატებითი ინფორმაცია
    type: reference
    open: false

[DISA Stig](https://www.stigviewer.com/stig/google_chrome_current_windows/2023-11-21/finding/V-221558){:target="_blank"}

///