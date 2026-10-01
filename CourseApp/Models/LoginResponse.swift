//
//  LoginResponse.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation
//{"data":{"Id":"f632dcf0-e46e-4e2e-a52a-f3ccf0c1abc8","success":true}}
struct LoginResponse: Decodable {
    let data: LoginData
}

struct LoginData: Decodable {
    let id: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case success
    }
}
