//
//  Lesson.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation

struct Lesson: Identifiable, Codable {
    let id: Int
    let title: String
    var isCompleted: Bool
}
