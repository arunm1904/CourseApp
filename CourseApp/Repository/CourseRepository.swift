//
//  CourseRepository.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation

final class CourseRepository {

    private let api: APIServiceProtocol
    private let cache: LocalCacheService

    init(
        api: APIServiceProtocol = MockAPIService(),
        cache: LocalCacheService = LocalCacheService()
    ) {
        self.api = api
        self.cache = cache
    }

    func fetchCourses() async throws -> [Course] {

        do {
            let courses = try await api.fetchCourses()

            // Save successful API response
            cache.saveCourses(courses)

            return courses

        } catch {

            // Offline fallback
            if let cachedCourses = cache.getCourses() {
                return cachedCourses
            }

            throw error
        }
    }

    func fetchLessons(courseID: Int) async throws -> [Lesson] {
        try await api.fetchLessons(courseID: courseID)
    }
}
