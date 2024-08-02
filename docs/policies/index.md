# FOI Security Policy

ხშირად, ოპერაციულ სისტემებსა და პროგრამებში უსაფრთხოების პარამეტრების მართვა რთულია. ზოგჯერ ეს პარამეტრები 
დამალული, რთულად მისაგნები ან ბუნდოვანია. მათი ხელით შეცვლა შეიძლება კი შეიძლება დროში გაიწელოს ან შეცდომები გამოიწვიოს.

**FOI Security Policy** არის მზა პარამეტრების ნაკრები სხვადასხვა ოპერაციული
სისტემისა და პროგრამისთვის. მისი გამოყენებით, თქვენი უსაფრთხოების პარამეტრები ავტომატურად 
დაყენდება რეკომენდირებულ მნიშვნელობებზე.

ეს პარამეტრები ეფუძნება ორ წყაროს:

1. [DISA STIG](https://public.cyber.mil/stigs/) სტანდარტებს, რომლებიც შექმნილია აშშ-ს თავდაცვის დეპარტამენტის სისტემების დასაცავად.
2. ჩვენს საკუთარ რეკომენდაციებს, რომლებიც მორგებულია ყოველდღიურ გამოყენებაზე და რეალურ გამოწვევებზე.

**FOI Security Policy** დაგეხმარებათ თქვენი სისტემების უსაფრთხოების გაძლიერებაში მარტივად და სწრაფად.


## ინსტალაცია

### Windows

/// admonition | Windows Defender-მა შეიძლება ეს ფაილი ვირუსად მიიჩნიოს
    type: warning
Windows Defender-მა შეიძლება ჩვენი უსაფრთხოების პარამეტრები შეცდომით ვირუსად აღიქვას, სახელწოდებით 
`Trojan:Win32/Wacatac.B!ml`. ეს ხდება იმიტომ, რომ ჩვენი პროგრამა ცვლის მნიშვნელოვან სისტემურ პარამეტრებს, რაც 
ვირუსების ტიპიური ქცევაა.

სახელში "!ml" ნიშნავს, რომ ეს გადაწყვეტილება მანქანურმა სწავლებამ მიიღო. ამ შემთხვევაში, ეს არის 
მცდარი განგაში - ჩვენი პარამეტრები უსაფრთხოა.

რეკომენდაცია:

1. Windows Defender-ში მიუთითეთ, რომ ფაილი უსაფრთხოა.
2. თუ მაინც გეპარებათ ეჭვი, შეგიძლიათ ყველა პარამეტრი ხელით დააყენოთ. ჩვენი კოდი სრულად 
   ხელმისაწვდომია Github-ზე, სადაც შეგიძლიათ ნახოთ ზუსტად რა ცვლილებებს ვაკეთებთ.

მარტივად: ეს უბრალოდ უსაფრთხოების სისტემის გადაჭარბებული სიფრთხილეა.
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

#### პინკოდით უსაფრთხო შესვლის დაყენება

/// admonition | მნიშვნელოვანი გაფრთხილება!
    type: warning
სანამ შემდეგ ნაბიჯზე გადახვალთ, აუცილებლად ჩართეთ Windows Hello PIN-ით შესვლა!

თუ ამას არ გააკეთებთ, ვეღარ შეძლებთ კომპიუტერში შესვლას.
///

როგორ დავაყენოთ პინკოდით შესვლა:

1. გაუშვით ფაილი `2. Disable Passwords.lnk` საქაღალდეში `foi_security_policy_win`.

რას აკეთებს ეს?

- ეს ფაილი გამორთავს პაროლით შესვლას
- ამის შემდეგ, კომპიუტერში შესასვლელად გამოიყენებთ მხოლოდ PIN-ს
- PIN უფრო უსაფრთხოა, რადგან ის იყენებს თქვენი კომპიუტერის სპეციალურ უსაფრთხოების ჩიპს (TPM)

##### ვერიფიკაცია

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
    - Apple Menu :material-apple: > System Settings > General > Device Management.

    MacOS 14:
    - Apple Menu :material-apple: > System Settings > Privacy and Security > Profiles.

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
