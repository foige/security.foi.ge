# ავტომატური კონფიგურაცია (FOI Security Policy)

უსაფრთხოების პარამეტრების მართვა ოპერაციულ სისტემებსა თუ პროგრამებში არსებული სტანდარტული 
საშუალებებით ყოველთვის შესაძლებელი არაა. რიგ შემთხვევებში, ეს პარამეტრები "დამალულია".

დამატებით, ყველა პარამეტრის ხელით შეცვლა შესაძლოა რთული ან შეცდომებთან დაკავშირებული იყოს.

FOI Security Policy არის პარამეტრების ნაკრები სხვადასხვა ოპერაციული სისტემისა და პროგრამისთვის,
რომლის დაყენების შემდეგ, ამ სისტემების უსაფრთხოების პარამეტრები ავტომატურად შეივსება რეკომენდირებულით.

პარამეტრების ნაწილი ეყრდნობა DISA STIG-ის სტანდარტებს, რომლებიც შექმნილია სპეციალურად აშშ-ს
თავდაცვის დეპარტამენტის (DoD) საინფორმაციო სისტემების უსაფრთხოების უზრუნველსაყოფად.
ნაწილი კი არის ჩვენი რეკომენდაციები, ან DISA STIG-ის რეკომენდაციის ადაპტაცია real-world 
სცენარებისთვის და სხვა გამოწვევებისთვის.


## ინსტალაცია

### Windows

/// admonition | Trojan:Win32/Wacatac.B!ml
    type: warning
იმის გამო, რომ სისტემური პროფილები უსაფრთხოების პარამეტრებს ცვლიან, Windows Defender-ს
ისინი ვირუსად მიაჩნია. !ml კომპონენტი სახელში ნიშნავს, რომ ამაში მონაწილეობას
machine learning / მანქანური დასწავლა იღებს და ამ შემთხვევაში, ცრუ პოზიტიურ შედეგს ვიღებთ.

შესაბამისად შეგიძლიათ Windows Defender-ს მიუთითოთ, რომ ფაილი არაა ვირუსი.

ალტერნატიულად, რადგან კოდი სრულად ხელმისაწვდომია Github-ზე, შეგიძლიათ ყველა გამოყენებული პარამეტრის
ხელით დაყენება.
///

#### პოლიტიკის დაყენება

1. გადმოწერეთ [foi_security_policy_win.zip](/policies/files/foi_security_policy_win.zip)
2. ამოაარქივეთ დესკტოპზე.
3. გახსენეთ `foi_security_policy_win` საქაღალდე.
4. გაუშვით `1. Install GPO.lnk` ფაილი.
5. წარმატებული ინსტალაციის შემთხვევაში, მიიღებთ შემდეგ შეტყობინებას:

```
Computer Policy update has completed successfully.
User Policy update has completed successfully.

Press any key to continue . . .
```

#### უსაფრთხო პინით აუთენთიფიკაციის ფორსირება

/// admonition | ყურადღება!
    type: warning
შემდეგი ნაბიჯის შესრულებამდე, აუცილებლად ჩართეთ Windows Hello PIN-ით აუთენტიფიკაცია!
სხვა შემთხვევაში, სისტემაში ვეღარ შეხვალთ
///

1. `foi_security_policy_win` საქაღალდეში, გაუშვით ფაილი `2. Disable Passwords.lnk`
2. ეს ფაილი გათიშავს პაროლით აუთენტიფიკაციას და ყველა აუთენტიფიკაცია PIN-ით მოხდება,
   რომელიც PIN-თან ერთად, დამატებით, უსაფრთხოების ჩიპსაც იყენებს (TPM).

ინსტალაციის დასრულების შემდეგ, Windows ძიების ველში ჩაწერეთ **gpedit.msc**, დააჭირეთ **Enter**.

1. ფანჯრის მარცხენა მხარეს აირჩიეთ: **Computer Configuration > Administrative Templates > All Settings**.
2. დაალაგეთ სია "State" სვეტის მიხედვით.
3. სია დაახლოებით ასე უნდა გამოიყურებოდეს:

   ![Computer Configuration](/assets/img/policies/win_policy_sample.png)

ამ ჩამონათვალში შეგიძლიათ ნახოთ, ან შეცვალოთ FOI Security Policy-ის მიერ დაყენებული ყველა პარამეტრი.

იმ შემთხვევაში, თუ სიის დასაწყისში Disabled/Enabled პარამეტრები არ ჩანს, ინსტალაცია არ იყო წარმატებული.


### macOS

1. გადმოწერეთ [foi_security_policy_macos.mobileconfig](/policies/files/apple/foi_security_policy_macos.mobileconfig)
2. გახსენით ფაილი.
3. იპოვეთ გადმოწერილი პროფილი:
    
    MacOS 15:
    - Apple Menu  > System Settings > General > Device Management.

    MacOS 14:
    - Apple Menu  > System Settings > Privacy and Security > Profiles.

4. Downloaded სექციაში იპოვეთ "FOI Security Policy" და ორჯერ დააკლიკეთ.
5. გახსნილ ფანჯარაში დააჭირეთ Install-ს.
6. გადადით ქსელის პარამეტრებში System Settings > Network > VPN & Filters > Filters & Proxies
7. "Filters & Proxies" ჩამონათვალში, Cloudflare DoH-ის გვერდით მონიშნეთ `Enabled`

დაყენებული პარამეტრების დათვალიერება შეგიძლიათ 
[iMazing Profile Editor](https://apps.apple.com/us/app/imazing-profile-editor/id1487860882?mt=12)-ის მეშვეობით


### iOS

1. გადმოწერეთ [foi_security_policy_ios.mobileconfig](/policies/files/apple/foi_security_policy_ios.mobileconfig)
2. Settings > General > VPN & Device Management > Downloaded Profile > FOI Security Policy
3. დააჭირეთ Install-ს.

დაყენებული პარამეტრების დათვალიერება შეგიძლიათ 
[iMazing Profile Editor](https://apps.apple.com/us/app/imazing-profile-editor/id1487860882?mt=12)-ის მეშვეობით
