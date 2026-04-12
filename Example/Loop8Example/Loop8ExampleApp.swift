//
//  Loop8ExampleApp.swift
//  Loop8Example
//
//  Created by John Harutyunyan on 25.03.26.
//

import SwiftUI
import Loop8AuthSDK

@main
struct Loop8ExampleApp: App {

	init() {
		_ = Loop8SDK.shared.configure(config: SDKConfig(
			clientId: "YOUR_CLIENT_ID",
			redirectUri: "loop8example://callback"
		))
		Loop8SDK.shared.onSessionExpired = {
			print("Loop8 session expired. Ask user to login again.")
		}
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
				.onOpenURL { url in
					Loop8SDK.shared.handleRedirect(url: url)
				}
		}
	}
}
