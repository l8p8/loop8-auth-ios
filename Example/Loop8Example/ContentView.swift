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
	@State private var status: String = "Not authenticated"
	@State private var resetMessage: String?

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

				if let resetMessage {
					Text(resetMessage)
						.font(.system(size: 18, weight: .semibold, design: .rounded))
						.foregroundStyle(Color.lTextTitle)
						.padding(.horizontal, 18)
						.padding(.vertical, 8)
						.background(Color.green.opacity(0.2))
						.overlay(
							Capsule().stroke(Color.green.opacity(0.45), lineWidth: 1)
						)
						.clipShape(Capsule())
				}

				Spacer()

				if isAuthenticated {
					Button {
						Loop8SDK.shared.logout { _ in }
						withAnimation(.easeInOut(duration: 0.2)) {
							isAuthenticated = false
							status = "Not authenticated"
							resetMessage = nil
						}
					} label: {
						Text("Log out")
							.font(.system(size: 20, weight: .semibold, design: .rounded))
							.foregroundStyle(Color.lTextTitle)
							.frame(maxWidth: .infinity)
							.frame(height: 56)
							.contentShape(Rectangle())
					}
					.overlay(
						RoundedRectangle(cornerRadius: 14)
							.stroke(Color.lLine, lineWidth: 1)
					)
					.padding(.horizontal, 18)
					.padding(.bottom, 20)
				} else {
					Loop8LoginButton(
						title: "Continue with Loop8",
						onSuccess: { _ in
							withAnimation(.easeInOut(duration: 0.2)) {
								isAuthenticated = true
								status = "Authenticated"
								resetMessage = nil
							}
						},
						onFailure: { error in
							withAnimation(.easeInOut(duration: 0.2)) {
								isAuthenticated = false
								status = "Error: \(error.localizedDescription)"
								resetMessage = nil
							}
						}
					)
					.padding(.horizontal, 18)

					Button("Reset Session") {
						Loop8SDK.shared.resetSession()
						withAnimation(.easeInOut(duration: 0.2)) {
							isAuthenticated = false
							status = "Not authenticated"
							resetMessage = "Session successfully reset!"
						}
					}
					.font(.system(size: 16, weight: .semibold, design: .rounded))
					.foregroundStyle(Color.lTextTitle)
					.padding(.bottom, 20)
				}
			}
			.padding(.horizontal, 8)
		}
	}

}
