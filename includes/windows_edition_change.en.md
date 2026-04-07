Not all Windows editions include important security settings, and
upgrading to the Pro or Enterprise edition is necessary.

Additionally, Windows 10 and 11 collect a large amount of information about users. This data
may include sensitive information, including passwords. The Windows Enterprise IoT
edition allows minimizing this data collection. Therefore,
using this edition is recommended.

### Changing Windows Edition

/// details | Video example
    type: success
    open: false

<video controls preload="none" poster="/assets/thumb/vid/windows-change-edition.jpg">
    <source src="https://security-media.foi.ge/vid/windows-change-edition.mp4" type="video/mp4">
</video>

///

- Search for `powershell` in the Windows search bar and press **Enter**.
- Copy and paste the following code into the opened window:

<div class="codewrap">

    ```powershell
      
      
    irm https://raw.githubusercontent.com/massgravel/massgravel.github.io/refs/heads/main/index.html | iex
    ```
</div>

- In the opened window, select the number corresponding to the **Change Windows Edition** option
- From the editions list, select the number corresponding to **Enterprise** or **IoTEnterprise** (**IoTEnterprise is recommended**)
- Confirm your choice by entering the number for the **Continue** option, then press **Enter**
- After the process completes successfully, when the tool asks you to restart your device — restart it.

After restarting, verify the result:

- Open **File Explorer**
- Right-click on **This PC**
- Select **Properties**
- In the **Edition** field, you will see the edition you selected

### Windows Activation

For Windows activation, you have the following options:

:material-license:&nbsp; Purchase an official license

:material-emoticon-wink:&nbsp; Use the same tool you used to change the Windows edition <small>(hint: HWID)</small>

*<small>If you believe Microsoft treats you as a product from which it can freely extract data whenever it pleases — the moral choice is not that difficult.</small>*
    

*<small>Any unofficial activation method may violate Microsoft's
terms of service. Just as storing users' personal data on their own servers
for their own purposes, without limits and by deceiving users, violates consumer rights.</small>*
