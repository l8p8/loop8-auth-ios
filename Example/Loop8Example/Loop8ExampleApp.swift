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
			clientId: "I7S283JLR89WBTGG",
			redirectUri: "loop8example://callback",
			authorityURL: URL(string: "https://auth-qa.l8p8.com")!,
			scopes: ["openid"]
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
