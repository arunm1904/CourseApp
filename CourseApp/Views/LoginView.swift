//
//  LoginView.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Spacer()

                Text("Course App")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField(
                    "Email",
                    text: $viewModel.email
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()

                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .textFieldStyle(.roundedBorder)

                if let error = viewModel.errorMessage {

                    Text(error)
                        .foregroundStyle(.red)
                        .font(.footnote)
                }

                Button {

                    Task {
                        await viewModel.login()
                    }

                } label: {

                    if viewModel.isLoading {

                        ProgressView()
                            .tint(.white)

                    } else {

                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    viewModel.isLoading ||
                    !viewModel.isValidInput
                )

                Text("Demo: test@example.com / 123456")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()
            }
            .padding()
            .navigationDestination(
                isPresented: $viewModel.isLoggedIn
            ) {
                CourseDashboardView()
            }
        }
    }
}
