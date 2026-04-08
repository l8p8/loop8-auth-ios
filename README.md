# Loop8 Auth SDK — iOS

The official iOS SDK for integrating Loop8 authentication into your app.

**Requirements:** iOS 17+ · Swift 5.9+ · Xcode 15+

---

## Table of Contents

1. [Installation](#1-installation)
2. [Configure the SDK](#2-configure-the-sdk)
3. [Handle the login callback](#3-handle-the-login-callback)
4. [Add the login button](#4-add-the-login-button)
5. [Required Info.plist settings](#5-required-infoplist-settings)
6. [Example app](#6-example-app)

---

## 1. Installation

### Swift Package Manager

In Xcode:

1. Go to **File → Add Package Dependencies**
2. Enter the URL:
   ```
   https://github.com/l8p8/loop8-auth-ios
   ```
3. Set the version rule to **Up to Next Major Version** from `0.1.0`
4. Click **Add Package**
5. Select **Loop8AuthSDK** and click **Add to Target**

---

## 2. Configure the SDK

Configure the SDK as early as possible — inside your `App` initializer or `AppDelegate`.

#### SwiftUI

```swift
import SwiftUI
import Loop8AuthSDK

@main
struct MyApp: App {

    init() {
        Loop8SDK.shared.configure(config: SDKConfig(
            clientId: "YOUR_CLIENT_ID",
            redirectUri: "yourapp://callback"
        ))

        // Optional: called when the user's session expires and cannot be
        // silently refreshed. Use this to navigate the user back to the login screen.
        Loop8SDK.shared.onSessionExpired = {
            // Navigate to login screen
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

#### UIKit / AppDelegate

If your app uses UIKit with an `AppDelegate`, configure the SDK in `didFinishLaunchingWithOptions`. Deep link handling is also done directly in `AppDelegate` via `application(_:open:options:)` — no additional setup is needed elsewhere.

```swift
import UIKit
import Loop8AuthSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        Loop8SDK.shared.configure(config: SDKConfig(
            clientId: "YOUR_CLIENT_ID",
            redirectUri: "yourapp://callback"
        ))

        // Optional: called when the user's session expires and cannot be
        // silently refreshed. Use this to navigate the user back to the login screen.
        Loop8SDK.shared.onSessionExpired = {
            // Navigate to login screen
        }

        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        Loop8SDK.shared.handleRedirect(url: url)
        return true
    }
}
```

| Parameter | Description |
|---|---|
| `clientId` | Your app's client ID, provided by Loop8 |
| `redirectUri` | Must match the URL scheme registered in `Info.plist` |

---

## 3. Handle the login callback

After the user authenticates in the Loop8 app, iOS redirects back to your app via a deep link. You must forward that URL to the SDK.

#### SwiftUI

```swift
var body: some Scene {
    WindowGroup {
        ContentView()
            .onOpenURL { url in
                Loop8SDK.shared.handleRedirect(url: url)
            }
    }
}
```

#### UIKit / AppDelegate

The callback is already handled in `AppDelegate.application(_:open:options:)` shown above.

---

## 4. Add the login button

Place `Loop8LoginButton` anywhere in your SwiftUI view hierarchy. The button appearance is fully managed by the SDK and cannot be customized.

```swift
import SwiftUI
import Loop8AuthSDK

struct ContentView: View {

    @State private var isAuthenticated = false

    var body: some View {
        VStack {
            if isAuthenticated {
                Text("Authenticated")
            } else {
                Loop8LoginButton(
                    onSuccess: { result in
                        // result.idToken
                        isAuthenticated = true
                    },
                    onFailure: { error in
                        print("Login failed: \(error.localizedDescription)")
                    }
                )
                .padding(.horizontal, 18)
            }
        }
    }
}
```

---

## 5. Required Info.plist settings

Add the following to your app's `Info.plist`. Replace `yourapp` with the custom URL scheme you chose for `redirectUri`.

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.yourcompany.yourapp.callback</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>yourapp</string>
        </array>
    </dict>
</array>
```

> The URL scheme (`yourapp`) must match the scheme part of the `redirectUri` you passed to `SDKConfig`.
> For example, if your `redirectUri` is `myapp://callback`, your scheme is `myapp`.

---

## 6. Example app

A full working example is included in the [`Example/`](./Example) folder.

To run it:

1. Open `Example/Loop8Example.xcodeproj` in Xcode
2. Select a simulator or device
3. Build and run

The example app demonstrates configuration, the login button, and callback handling.
