//
//  ContentView.swift
//  Loop8Example
//
//  Created by John Harutyunyan on 25.03.26.
//

import SwiftUI
import Loop8AuthSDK

struct ContentView: View {
	@State private var isAuthenticated = false
	@State private var isLoading = false
	@State private var status: String = "Not authenticated"

	var body: some View {
		ZStack {
			Color.lBackground
				.ignoresSafeArea()

			VStack {
				Image(isAuthenticated ? "authenticated" : "notAuthenticated")
					.resizable()
					.frame(maxWidth: .infinity)
					.frame(height: 474, alignment: .top)
				Spacer()
			}
			.ignoresSafeArea()

			VStack(spacing: 20) {
				Image("loop8IdLogo")
					.resizable()
					.scaledToFit()
					.frame(width: 104, height: 36)
					.frame(height: 64)
					.frame(maxWidth: .infinity)

				Image(isAuthenticated ? "authenticatedLogo" : "notAuthenticatedLogo")
					.resizable()
					.scaledToFit()
					.frame(width: 116, height: 116)
					.padding(.top, 30)

				Text(status)
					.font(.system(size: 24, weight: .semibold, design: .rounded))
					.foregroundStyle(Color.lTextTitle)
					.multilineTextAlignment(.center)

				Spacer()

				if isAuthenticated {
					Button("Reset Session") {
						Loop8SDK.shared.resetSession()
						withAnimation(.easeInOut(duration: 0.2)) {
							isAuthenticated = false
							status = "Not authenticated"
						}
					}
					.font(.system(size: 16, weight: .semibold, design: .rounded))
					.foregroundStyle(Color.lTextTitle)
					.padding(.bottom, 20)
				}

				if !isAuthenticated {
					Loop8LoginButton(
						onAuthStarted: {
							withAnimation {
								isLoading = true
							}
						},
						onSuccess: { _ in
							withAnimation(.easeInOut(duration: 0.2)) {
								isLoading = false
								isAuthenticated = true
								status = "Authenticated"
							}
						},
						onFailure: { error in
							withAnimation(.easeInOut(duration: 0.2)) {
								isLoading = false
								isAuthenticated = false
								status = "Error: \(error.localizedDescription)"
							}
						}
					)
					.padding(.horizontal, 18)
					.padding(.bottom, 20)
				}
			}
			.padding(.horizontal, 8)

			if isLoading {
				Color.black.opacity(0.15)
					.ignoresSafeArea()
				ProgressView()
					.progressViewStyle(.circular)
					.scaleEffect(1.5)
					.tint(.white)
			}
		}
	}
}
