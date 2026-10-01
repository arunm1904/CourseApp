//
//  Course.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//
import Foundation

struct Course: Identifiable, Codable {
    let id: Int
    let title: String
    let instructor: String
    var progress: Int
    let lessons: Int
}
