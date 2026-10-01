//
//  Untitled.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation
import Combine

@MainActor
final class CourseDetailsViewModel: ObservableObject {

    @Published private(set) var lessons: [Lesson] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let repository: CourseRepository

    let course: Course

    init(
        course: Course,
        repository: CourseRepository = CourseRepository()
    ) {
        self.course = course
        self.repository = repository
    }

    var progress: Int {

        CourseProgressCalculator.calculate(from: lessons)
//        guard !lessons.isEmpty else {
//            return 0
//        }
//
//        let completed = lessons.filter {
//            $0.isCompleted
//        }.count
//
//        return Int(
//            (Double(completed) /
//             Double(lessons.count)) * 100
//        )
    }

    func loadLessons() async {

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {

            lessons = try await repository.fetchLessons(
                courseID: course.id
            )

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    func toggleLesson(_ lesson: Lesson) {

        guard let index =
                lessons.firstIndex(
                    where: { $0.id == lesson.id }
                )
        else {
            return
        }

        lessons[index].isCompleted.toggle()
    }

    
}
struct CourseProgressCalculator {

    static func calculate(from lessons: [Lesson]) -> Int {

        guard !lessons.isEmpty else {
            return 0
        }

        let completedCount = lessons.filter {
            $0.isCompleted
        }.count

        return Int(
            (Double(completedCount) / Double(lessons.count)) * 100
        )
    }
}
