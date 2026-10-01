//
//  CourseDashboardViewModel.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation
import Combine
@MainActor
final class CourseDashboardViewModel: ObservableObject {

    enum State {
        case idle
        case loading
        case success
        case empty
        case failure(String)
    }

    @Published var courses: [Course] = []
    @Published var state: State = .idle

    private let repository: CourseRepository

    init(repository: CourseRepository = CourseRepository()) {
        self.repository = repository
    }

    func loadCourses() async {

        state = .loading

        do {

            courses = try await repository.fetchCourses()

            if courses.isEmpty {
                state = .empty
            } else {
                state = .success
            }

        } catch {

            state = .failure(
                error.localizedDescription
            )
        }
    }
}


