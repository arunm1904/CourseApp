//
//  LoginViewModel.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var isLoggedIn = false

    private let api: APIServiceProtocol

//    init(api: APIServiceProtocol = MockAPIService()) {
//        self.api = api
//    }
    
    // Dependency injection initializer
       init(api: APIServiceProtocol) {
           self.api = api
       }

       // Default initializer
       convenience init() {
           self.init(api: MockAPIService())
       }

    var isValidInput: Bool {

        !email.trimmingCharacters(in: .whitespaces).isEmpty// &&
       // password.count >= 6
    }

    func login() async {

            errorMessage = nil

            guard !email.isEmpty else {
                errorMessage = "Please enter email."
                return
            }

            guard email.contains("@") else {
                errorMessage = "Please enter a valid email."
                return
            }

            guard !password.isEmpty else {
                errorMessage = "Please enter password."
                return
            }

            isLoading = true

            defer {
                isLoading = false
            }

            do {

                let response = try await api.login(
                    email: email,
                    password: password
                )

                if response.data.success {

                    print("Login successful")
                    print("User ID:", response.data.id)

                    isLoggedIn = true

                } else {

                    errorMessage = "Login failed."
                }

            } catch {

                errorMessage = error.localizedDescription
            }
        }
}
