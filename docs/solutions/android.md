---
title: Android
icon: material/android
---

# Android

## წინასწარ შესასრულებელი ნაბიჯები

- [x] დააინსტალირეთ [პაროლების მენეჯერი](passwords.md)
    - ტელეფონისთვის უნიკალური, ძლიერი პაროლის შესანახად, რომელიც ამავდროულად მარტივი შესაყვანი იქნება.

{% include-markdown "../../includes/device_has_updates.md"%}

## რეკომენდირებული მოწყობილობები

Android მოწყობილობების მიერ მხარდაჭერილი უსაფრთხოების ფუნქციები ფრაგმენტირებულია. შედეგად,
ყველა მოწყობილობა თანაბარ უსაფრთხოებას ვერ უზრუნველყოფს და შესაძლოა, მონაცემების მოპოვება მომხმარებლის
პაროლის გარეშეც მოხდეს.

ამიტომ, რეკომენდებულია მხოლოდ იმ მოწყობილობების გამოყენება, რომლებიც Android-ის მიერ მხარდაჭერილ
ყველა უსაფრთხოების პარამეტრს აკმაყოფილებენ. ერთ-ერთი ასეთი ფუნქციაა [StrongBox](https://source.android.com/docs/security/best-practices/hardware){:target="_blank"},
რომელიც ნიშნავს, რომ მოწყობილობას აქვს დამატებითი უსაფრთხოების ჩიპი, რომელიც მომხმარებლის ინფორმაციას იცავს და გამძლეა
მონაცემების არასანქცირებული ამოღებისგან.

Android სმარტფონების არასრული ჩამონათვალი, რომლებსაც აქვთ ასეთი უსაფრთხოების ჩიპი, 
შეგიძლიათ იხილოთ [ბმულზე](https://www.android-device-security.org/database/?realMeasurementsOnly=true&preDefinedScore=defaultSecurity&securityScoreCalculationApproach=true&securityScoreLabel-API%20Level=High&securityScoreLabel-Patchlevel=High&securityScoreLabel-Fingerprint=High&securityScoreLabel-Keymaster%20Version=Moderate&securityScoreLabel-Key%20Attestation%20Unique%20ID=High&securityScoreLabel-Keystore%20Export=High&securityScoreLabel-Keystore%20Import=Low&securityScoreLabel-OpenApi%20eSE=Low&securityScoreLabel-Embedded%20SIM%20(eSIM)=Low&securityScoreLabel-Strongbox=High&securityScoreLabel-A%2FB%20System%20Updates=High&securityScoreLabel-Identity%20Credential=High&securityScoreLabel-Protected%20Confirmation=High&securityScoreLabel-Trusted%20Execution%20Environment=High&securityScoreLabel-Encrypted%20Shared%20Preferences=High&securityScoreLabel-Android%20Virtualization%20Framework=Moderate&securityScoreLabel-Multiple%20User%20Support=High&show=Strongbox&page=1&rows=50&Strongbox=True&securityScoreSelectedCols=Fingerprint;Keymaster%20Version;Keystore%20Export;Keystore%20Import;Strongbox;A%2FB%20System%20Updates;Identity%20Credential;Protected%20Confirmation;Trusted%20Execution%20Environment;Encrypted%20Shared%20Preferences;Android%20Virtualization%20Framework;Multiple%20User%20Support;OpenApi%20eSE;Embedded%20SIM%20(eSIM)&securityScoreWeight-Release%20Date=10&securityScoreWeight-Fingerprint=43&securityScoreWeight-Keymaster%20Version=55&securityScoreWeight-Keystore%20Export=55&securityScoreWeight-Keystore%20Import=55&securityScoreWeight-OpenApi%20eSE=66&securityScoreWeight-Embedded%20SIM%20(eSIM)=61&securityScoreWeight-Strongbox=66&securityScoreWeight-A%2FB%20System%20Updates=20&securityScoreWeight-Identity%20Credential=74&securityScoreWeight-Protected%20Confirmation=76&securityScoreWeight-Trusted%20Execution%20Environment=66&securityScoreWeight-Encrypted%20Shared%20Preferences=65&securityScoreWeight-Android%20Virtualization%20Framework=50&securityScoreWeight-Multiple%20User%20Support=65&selectedDeviceModel=1&minThreshold-api_level=31&minThreshold-releasedate=2021-8-14&minThreshold-patchlevel=2024-05-01&minThreshold-Keymaster%20Version=4&minThreshold-OpenApi%20eSE=1&negateBooleans=Key%20Attestation%20Unique%20ID;Keystore%20Export;Rooted){:target="_blank"}

/// admonition | Google Pixel
    type: success

Android-ზე მომუშავე სმარტფონებიდან **Google Pixel**, ზოგადად, ყველაზე უსაფრთხოა,
რადგან ისინი იცავენ ყველა რეკომენდაციას, რომელიც Android-ის მიერ არის შემოთავაზებული.


სხვა მწარმოებლებს ამ რეკომენდაციების შესრულება არ ევალებათ.

Pixel სმარტფონები ასევე,
სხვა Android მოწყობილობებთან შედარებით, ყველაზე სწრაფად და დიდი ხნის განმავლობაში იღებენ განახლებებს.

///

## სისტემის კონფიგურაცია

### პაროლი

Android ზღუდავს პაროლის მაქსიმალურ სიგრძეს 16 სიმბოლომდე, ამიტომ გამოვიყენებთ კომპიუტერის მიერ შემთხვევითი წესით შერჩეულ მოკლე ბგერებს, რომლის გატეხვაც პრაქტიკულად შეუძლებელი იქნება, ხოლო მისი შეყვანა მხოლოდ 72 საათში ერთხელ მოგიწევთ.

{% include-markdown "../../includes/mobile_biometrics.md" %}

#### ახალი პაროლის შექმნა

1. დააგენერირეთ მობილურის ახალი პაროლი FOI პაროლების გენერატორით

    /// admonition | რჩევა
        type: tip

    გენერირების ღილაკს დააჭირეთ მანამ, სანამ არ მიიღებთ პაროლს, რომლის ბოლო სიტყვასაც მარტივად დაიმახსოვრებთ.
        
    ///

    [:material-key: FOI პაროლების გენერატორი](../tools/password-generator/index.md){ .md-button .md-button--primary }

2. რადგან ანდროიდში პაროლის სიგრძე შეზღუდულია, გამოტოვების (წერტილი ან "სფეისი") მაგივრად, ყოველი სიტყვა დაიწყეთ დიდი ასოთი
3. პაროლის დამახსოვრება:
    - ჩაიწერეთ პირველი სამი ბგერა ფურცელზე
    - ბოლო სიტყვა დაიმახსოვრეთ
    - ოთხივე სიტყვის დამახსოვრების შემდეგ გაანადგურეთ ფურცელი
4. პაროლის შენახვა **Bitwarden**-ში:
    - შექმენით ახალი ჩანაწერი, დაარქვით სახელი (მაგ. **My Pixel 9 Password**)
    - შეიყვანეთ სრული პაროლი Password ველში
    - დააჭირეთ :material-content-save: Save ღილაკს

#### პაროლის შეცვლა

<small>გამოყენებულია Google Pixel-ის ინსტრუქციები. თქვენს მოწყობილობაზე პაროლის შეცვლა შესაძლებელია, განსხვავებული ადგილიდან ხდებოდეს</small>

1. გახსენით **Settings**
2. გადადით **Security and Privacy > Device Unlock**
3. აირჩიეთ **Screen Lock > Password**
4. შეიყვანეთ არსებული პაროლი
5. შეიყვანეთ ახალი პაროლი. რადგან ანდროიდში პაროლის სიგრძე შეზღუდულია, გამოტოვების (წერტილი ან "სფეისი") მაგივრად, ყოველი სიტყვა დაიწყეთ დიდი ასოთი

{% include-markdown "../../includes/password_paper_storage.md" %}

### DNS

**FOI Security Policy** მოწყობილობაზე დაამატებს ორ დაშიფრულ DNS სერვერს - Cloudflare და Adguard.

გაეცანით [DNS](dns.md) გვერდს და დააყენეთ საჭირო პარამეტრები.

### VPN

გაეცანით [VPN](vpn.md) გვერდს, დააყენეთ VPN პროვაიდერის აპლიკაცია და დაუკავშირდით სერვერს.

