//
//  APIConfig.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

final class APIConfig {

    static let shared = APIConfig()

    private init() {}

    
    let baseURL = "https://mockserver.in/"

    let loginEndpoint = "api/wild-flame-5256/login"
    let courseEndpoint = "api/wild-flame-5256/courseList"

    var loginURL: String {
        "\(baseURL)\(loginEndpoint)"
    }
    var courseURL: String {
        "\(baseURL)\(courseEndpoint)"
    }
}
