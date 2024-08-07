---
title: iOS უსაფრთხოების პოლიტიკა
icon: material/apple-ios
---

# iOS უსაფრთხოების პოლიტიკა

## ინსტალაცია

1. მობილურის ბრაუზერით გადმოწერეთ [foi_security_policy_ios.mobileconfig](files/apple/foi_security_policy_ios.mobileconfig)
2. გახსენით ![Apple Settings](../assets/img/icons/apple/settings.svg){ .twemoji } **Settings** > 
    ![Apple General](../assets/img/icons/apple/general.svg){ .twemoji } **General** > 
    **VPN & Device Management** > **Downloaded Profile** > **FOI Security Policy**
3. დააჭირეთ Install-ს.

დაყენებული პარამეტრების დათვალიერება შეგიძლიათ 
[iMazing Profile Editor](https://apps.apple.com/us/app/imazing-profile-editor/id1487860882?mt=12)-ის მეშვეობით


## გამოყენებული პარამეტრები

FOI Security Policy მოიცავს შემდეგ კონფიგურაციას და ავტომატურად გააქტიურდება.

### პაროლი

#### Require passcode on device

- [x] ჩართული

განმარტება: ჩართულია უსაფრთხოების გაზრდის მიზნით, რათა მოწყობილობაზე წვდომა მხოლოდ ავტორიზებულ პირებს ჰქონდეთ.

#### Require alphanumeric value

- [x] ჩართული

განმარტება: ჩართულია უსაფრთხოების გაზრდის მიზნით, რათა პაროლი უფრო რთული და ძნელად გამოსაცნობი იყოს.

#### Minimum passcode length

- [x] 8 სიმბოლო

განმარტება: დაწესებულია მინიმალური სიგრძე უსაფრთხოების გაზრდის მიზნით.

#### Passcode history

- [x] 2

განმარტება: iOS-ზე ძველი პაროლის გამოყენება 72 საათის განმავლობაში შეიძლება. შეზღუდვის ჩართვა, 
რომლითაც ახალი პაროლი ძველი ორი პაროლის სიაში არ უნდა იყოს, ამ ფუნქციას გამორთავს, მეტი უსაფრთხოებისთვის.

#### Maximum number of failed attempts

- [x] 11 ცდა

განმარტება: შეზღუდულია არასწორი პაროლის შეყვანის მცდელობები უსაფრთხოების გაზრდის მიზნით.

