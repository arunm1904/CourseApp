//
//  MockAPIService.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation

protocol APIServiceProtocol {
    func login(email: String, password: String) async throws -> LoginResponse
    func fetchCourses() async throws -> [Course]
    func fetchLessons(courseID: Int) async throws -> [Lesson]
}


enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case loginFailed
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."

        case .invalidResponse:
            return "Invalid server response."

        case .serverError(let statusCode):
            return "Server error: \(statusCode)"

        case .loginFailed:
            return "Login failed."

        case .decodingError:
            return "Unable to process server response."
        }
    }
}
final class MockAPIService: APIServiceProtocol {

    init() {}

    private let loginURL = APIConfig.shared.loginURL
    
    func login(
            email: String,
            password: String
        ) async throws -> LoginResponse {
            
            //for testing
//            try await Task.sleep(for: .seconds(1))
//            //{"data":{"Id":"f632dcf0-e46e-4e2e-a52a-f3ccf0c1abc8","success":true}}
//            return LoginResponse(data:LoginData(id: "f632dcf0-e46e-4e2e-a52a-f3ccf0c1abc8", success: true))
            
            

            guard let url = URL(string: loginURL) else {
                throw APIError.invalidURL
            }

            var request = URLRequest(url: url)

            request.httpMethod = "GET"

            request.setValue(
                "application/json",
                forHTTPHeaderField: "Accept"
            )

            let (data, response) =
                try await URLSession.shared.data(for: request)

            guard let httpResponse =
                    response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(
                httpResponse.statusCode
            ) else {
                throw APIError.serverError(
                    httpResponse.statusCode
                )
            }

            do {

                return try JSONDecoder().decode(
                    LoginResponse.self,
                    from: data
                )

            } catch {

                print("Decoding error:", error)
                throw APIError.decodingError
            }
        }

//    func fetchCourses() async throws -> [Course] {
//        try await Task.sleep(for: .seconds(1))
//
//       
//        return [
//            Course(
//                id: 1,
//                title: "Python Programming",
//                instructor: "John Smith",
//                progress: 65,
//                lessons: 20
//            ),
//            Course(
//                id: 2,
//                title: "Generative AI",
//                instructor: "Sarah Williams",
//                progress: 40,
//                lessons: 16
//            ),
//            Course(
//                id: 3,
//                title: "Full Stack Development",
//                instructor: "David Brown",
//                progress: 25,
//                lessons: 28
//            )
//        ]
//    }
    
    func fetchCourses() async throws -> [Course] {

        guard let url = URL(string: APIConfig.shared.courseURL) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(
                [Course].self,
                from: data
            )
        } catch {
            print("Courses decoding error:", error)
            throw APIError.decodingError
        }
    }
    
    
    
        func fetchLessons(courseID: Int) async throws -> [Lesson] {
    
            try await Task.sleep(for: .milliseconds(500))
    
            switch courseID {
    
            case 1:
                return [
                    Lesson(id: 1, title: "Introduction", isCompleted: true),
                    Lesson(id: 2, title: "Variables & Data Types", isCompleted: true),
                    Lesson(id: 3, title: "Functions", isCompleted: false),
                    Lesson(id: 4, title: "OOP", isCompleted: false)
                ]
    
            case 2:
                return [
                    Lesson(id: 1, title: "Introduction to Generative AI", isCompleted: true),
                    Lesson(id: 2, title: "Prompt Engineering", isCompleted: false),
                    Lesson(id: 3, title: "LLMs", isCompleted: false),
                    Lesson(id: 4, title: "AI Applications", isCompleted: false)
                ]
    
            default:
                return [
                    Lesson(id: 1, title: "Introduction", isCompleted: true),
                    Lesson(id: 2, title: "Frontend", isCompleted: false),
                    Lesson(id: 3, title: "Backend", isCompleted: false),
                    Lesson(id: 4, title: "Database", isCompleted: false)
                ]
            }
        }
}


